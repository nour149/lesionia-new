package com.example.Lesionia.project.service.service_interface;

import com.example.Lesionia.project.domain.molecularl_test;

import java.util.List;

public interface molecularl_test_service {
    int save_molecularl_test( molecularl_test molecularl_test);
    int delete_molecularl_test(String TEST);
    List<molecularl_test> get_all_molecular_TEST();
    List<String> get_all_TEST();
    void update (molecularl_test molecularl_test);
}
