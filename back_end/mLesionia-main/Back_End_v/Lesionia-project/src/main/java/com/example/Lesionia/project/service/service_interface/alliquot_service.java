package com.example.Lesionia.project.service.service_interface;

import com.example.Lesionia.project.domain.alliquot;

public interface alliquot_service {
    void save_alliquot(alliquot alliquot);
    void update_alliquot(alliquot alliquot);
    alliquot get_by_id_sample(String idsample);
}