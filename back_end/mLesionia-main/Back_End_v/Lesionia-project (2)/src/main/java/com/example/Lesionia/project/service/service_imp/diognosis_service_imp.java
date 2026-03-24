package com.example.Lesionia.project.service.service_imp;

import com.example.Lesionia.project.domain.diognosis;
import com.example.Lesionia.project.repo.diognosis_repo;
import com.example.Lesionia.project.service.service_interface.diognosis_service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class diognosis_service_imp implements diognosis_service {

    private final diognosis_repo diagnosis_repo;

    @Override
    public diognosis save_dig(diognosis diagnosis) {
        String new_id = diagnosis.getIDSAMPLE()+'-'+size(diagnosis.getIDSAMPLE());
        diagnosis.setIDDIAGNOSIS(new_id);
        return diagnosis_repo.save(diagnosis);
    }

@Override
    public diognosis update_dig(diognosis diagnosis) {
        return diagnosis_repo.save(diagnosis);
    }
    @Override
    public List<diognosis> get_all_by_sample(String IDSAMPLE) {
        return diagnosis_repo.all_by_sample(IDSAMPLE);
    }
    @Override
    public diognosis get_one_dig(String IDDIAGNOSIS) {
        return diagnosis_repo.findByIDDIAGNOSIS(IDDIAGNOSIS);
    }
    public  int size (String IDSAMPLE)
    {
        return  get_all_by_sample(IDSAMPLE).size()+1;
    }
    @Override
    public List get_by_name() {
        return diagnosis_repo.get_by_lab_name();
    }
    @Override
    public List get_by_TEST() {
        return diagnosis_repo.get_by_TEST();
    }
    @Override
    public List get_by_species() {
        return diagnosis_repo.get_by_species();
    }
}
