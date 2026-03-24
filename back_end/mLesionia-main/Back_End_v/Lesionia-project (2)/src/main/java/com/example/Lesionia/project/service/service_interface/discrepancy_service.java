package com.example.Lesionia.project.service.service_interface;

import com.example.Lesionia.project.domain.discrepancy;

import java.util.List;

public interface discrepancy_service {

    discrepancy save_disc (discrepancy discrepancy);
    List<discrepancy> get_all();
    discrepancy update_disc ( discrepancy discrepancy);
    discrepancy get_one(String idDiscrepancy);
    List<discrepancy> getall_my(String PATIENTIDENTIFIER);

}