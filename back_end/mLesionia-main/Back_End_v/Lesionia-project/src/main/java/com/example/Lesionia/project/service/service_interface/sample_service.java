package com.example.Lesionia.project.service.service_interface;

import com.example.Lesionia.project.domain.sample;

import java.util.List;

public interface sample_service {

    List<sample> getall();
    sample update(sample sample);
    sample get_one(String IDSAMPLE);
    String save(sample sample);
    List<sample> getall_my(String PATIENTIDENTIFIER);
    List<String> get_all_id(String PATIENTIDENTIFIER);
    int get_allsamples(String LOGINUSER);
}
