package com.example.Lesionia.project.service.service_interface;


import com.example.Lesionia.project.domain.disease;

import java.util.List;

public interface disease_service {

    int save(disease disease);
    int delete(String id);
    List<disease> get_all();
    void update(disease disease);
    disease get_by_id (String id);
}