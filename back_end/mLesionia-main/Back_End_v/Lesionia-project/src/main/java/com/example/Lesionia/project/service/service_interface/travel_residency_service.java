package com.example.Lesionia.project.service.service_interface;

import com.example.Lesionia.project.domain.travel_residency;

import java.util.List;

public interface travel_residency_service {
    travel_residency save (travel_residency travel_residency);
    List<travel_residency> get_travels();



    travel_residency get_one (String IDMVT);
    List<travel_residency> get_all(String PATIENTIDENTIFIER);

    travel_residency update_tr(travel_residency updatedResidency);

    int get_alltravelsbyid(String loginuser);
}
