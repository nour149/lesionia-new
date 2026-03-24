package com.example.Lesionia.project.service.service_imp;

import com.example.Lesionia.project.domain.PostResponse;
import com.example.Lesionia.project.domain.my_user;
import com.example.Lesionia.project.domain.patient;
import com.example.Lesionia.project.repo.patient_repo;
import com.example.Lesionia.project.service.service_interface.patient_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Calendar;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class patient_service_imp implements patient_service {

    private final com.example.Lesionia.project.service.service_interface.my_userService my_userService;
    private final patient_repo patient_repo;

    @Autowired
    private public_services public_services;

    @Override
    public patient save_patient(patient patient) {
        String loginuser = patient.getLOGINUSER();
        my_user u = my_userService.getmy_user(loginuser);
        String number = public_services.get_year();
        int n = get_number(number);
        log.info("we have patients " + n + " in this year");
        n = n + 1;
        int l = Integer.toString(n).length();
        switch (l) {
            case 4:
                patient.setPATIENTIDENTIFIER(u.getFROMINST() + number + n);
                break;
            case 3:
                patient.setPATIENTIDENTIFIER(u.getFROMINST() + 0 + number + n);
                break;
            case 2:
                patient.setPATIENTIDENTIFIER(u.getFROMINST() + number + 0 + 0 + n);
                break;
            case 1:
                patient.setPATIENTIDENTIFIER(u.getFROMINST() + number + 0 + 0 + 0 + n);
        }
        return patient_repo.save(patient);

    }

    @Override
    public patient update_patient(patient patient) {
        return patient_repo.save(patient);
    }

    @Override
    public patient get_one_patient(String PATIENTIDENTIFIER) {
        return patient_repo.findByPATIENTIDENTIFIER(PATIENTIDENTIFIER);
    }


    @Override
    public List<patient> get_patients() {
        return patient_repo.findAll();
    }


    @Override
    public List<patient> get_my_patients(String LOGINUSER) {
        return patient_repo.get_my_patients(LOGINUSER);
    }

    @Override
    public int get_number(String number) {
        return patient_repo.get_number(number + "____");
    }

    @Override
    public PostResponse get_patients_pagination(int pageNo, int pageSize) {
        // create Pageable instance
        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<patient> posts = patient_repo.findAll(pageable);
        List<patient> listOfPosts = posts.getContent();
        PostResponse postResponse = new PostResponse();
        postResponse.setContent(listOfPosts);
        postResponse.setPageNo(posts.getNumber());
        postResponse.setPageSize(posts.getSize());
        postResponse.setTotalElements(posts.getTotalElements());
        postResponse.setTotalPages(posts.getTotalPages());
        postResponse.setLast(posts.isLast());
        return postResponse;
    }

    @Override
    public PostResponse get_my_patients_pagination(String loginuser, int pageNo, int pageSize) {
        // create Pageable instance
        Pageable pageable = PageRequest.of(pageNo, pageSize);
        Page<patient> posts = patient_repo.findByLOGINUSEROrderByPATIENTIDENTIFIERDesc(loginuser, pageable);
        List<patient> listOfPosts = posts.getContent();
        PostResponse postResponse = new PostResponse();
        postResponse.setContent(listOfPosts);
        postResponse.setPageNo(posts.getNumber());
        postResponse.setPageSize(posts.getSize());
        postResponse.setTotalElements(posts.getTotalElements());
        postResponse.setTotalPages(posts.getTotalPages());
        postResponse.setLast(posts.isLast());
        return postResponse;
    }


    @Override
    public int male_number() {
        return patient_repo.male_number("Male");
    }

    @Override
    public int female_number() {
        return patient_repo.female_number("Female");
    }

    @Override
    public List get_by_age() {
        return patient_repo.get_by_age_gender();
    }

    @Override
    public List<String> patient_by_user() {
        return patient_repo.patient_by_user();
    }

    @Override
    public List male_number_by_age() {
        return patient_repo.male_number_group_by_age("Male");

    }
    @Override
    public List female_number_by_age() {
        return patient_repo.female_number_group_by_age("Female");
    }

    @Override
    public List n_a_number_by_age() {
        return patient_repo.n_a_number_group_by_age("N/A");
    }

    @Override
    public List list_age() {
        return patient_repo.age_list();
    }
    @Override

    public PostResponse get_all_by_inst(String FROMINST, int pageNo) {
        // create Pageable instance
        Pageable pageable = PageRequest.of(pageNo, 5);
        Page<patient> posts = patient_repo.get_all_by_inst(FROMINST, pageable);
        List<patient> listOfPosts = posts.getContent();
        PostResponse postResponse = new PostResponse();
        postResponse.setContent(listOfPosts);
        postResponse.setPageNo(posts.getNumber());
        postResponse.setPageSize(posts.getSize());
        postResponse.setTotalElements(posts.getTotalElements());
        postResponse.setTotalPages(posts.getTotalPages());
        postResponse.setLast(posts.isLast());
        return postResponse;

    }
}