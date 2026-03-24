package com.example.Lesionia.project.service.service_interface;


import com.example.Lesionia.project.domain.medical_checkup;


import java.util.List;

public interface medical_checkup_service {
    medical_checkup save_medical_checkup(medical_checkup medical_checkup);
    medical_checkup get_one_medical_checkup(String IDMED);
    medical_checkup update_medical_checkup(medical_checkup medical_checkup);
    List<medical_checkup> get_checkups();
    List<medical_checkup> get_medical_checkup(String PATIENTIDENTIFIER);
    List<String> get_all_date(String PATIENTIDENTIFIER);
    List checkup_date(String loginuser);
    int get_allchecks(String loginuser);
}
