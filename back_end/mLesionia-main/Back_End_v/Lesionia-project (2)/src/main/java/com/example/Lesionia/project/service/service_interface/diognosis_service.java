package com.example.Lesionia.project.service.service_interface;


import com.example.Lesionia.project.domain.diognosis;

import java.util.List;

public interface diognosis_service {

    diognosis save_dig (diognosis diagnosis);
    diognosis update_dig(diognosis diagnosis);
    List<diognosis> get_all_by_sample(String IDSAMPLE);
    diognosis get_one_dig (String IDDIAGNOSIS);
    List get_by_name();
    List get_by_TEST();
    List get_by_species();
}
