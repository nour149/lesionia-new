package com.example.Lesionia.project.service.service_interface;

import com.example.Lesionia.project.domain.treatmenthistory;

import java.util.List;

public interface treatmenthistory_service {
    treatmenthistory save (treatmenthistory treatmenthistory);
    treatmenthistory update(treatmenthistory treatmenthistory);
    List<treatmenthistory> get_all(String PATIENTIDENTIFIER);
    List<treatmenthistory> get_treatments();
    treatmenthistory get_one(String IDTREATMENT);
}
