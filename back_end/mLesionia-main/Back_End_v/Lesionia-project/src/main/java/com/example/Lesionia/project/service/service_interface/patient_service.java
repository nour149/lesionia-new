package com.example.Lesionia.project.service.service_interface;

import com.example.Lesionia.project.domain.PostResponse;
import com.example.Lesionia.project.domain.my_user;
import com.example.Lesionia.project.domain.patient;

import java.util.List;

public interface patient_service {
    patient update_patient (patient patient);
    patient save_patient (patient patient);
    patient get_one_patient(String PATIENTIDENTIFIER);
    List<patient> get_patients();
    List<patient> get_my_patients(String LOGINUSER);
    int get_number(String number);
    PostResponse get_patients_pagination(int pageNo , int pageSize);
    PostResponse get_my_patients_pagination(String loginuser,int pageNo , int pageSize);
    int male_number();
    int female_number();
    List get_by_age();
    List<Object[]> patient_by_user();
    List male_number_by_age();
    List female_number_by_age();
    List n_a_number_by_age();
    List list_age();
    PostResponse get_all_by_inst(String FROMINST,int pageNo);
    List<Object[]> getPatientCountByLoginUser();
}
