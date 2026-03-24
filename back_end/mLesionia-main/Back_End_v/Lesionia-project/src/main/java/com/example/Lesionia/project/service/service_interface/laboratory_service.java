package com.example.Lesionia.project.service.service_interface;

import com.example.Lesionia.project.domain.laboratory;

import java.util.List;

public interface laboratory_service {

    int save_lab ( laboratory laboratory);
    List<laboratory> all ();
    int  delete_lab (String LABORATORYNAME);
    List<String> all_name();
    void  update(laboratory laboratory);

}