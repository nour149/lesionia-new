package com.example.Lesionia.project.service.service_imp;

import com.example.Lesionia.project.domain.molecularl_test;
import com.example.Lesionia.project.repo.molecularl_test_repo;
import com.example.Lesionia.project.service.service_interface.molecularl_test_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class molecularl_test_service_imp  implements molecularl_test_service {

    private final molecularl_test_repo molecularl_test_repo;
    @Override
    public int save_molecularl_test(molecularl_test molecularl_test) {
        String id = molecularl_test.getTEST();
        Optional<molecularl_test> m2 = molecularl_test_repo.findById(id);
        if ( m2.isEmpty())
        {
            molecularl_test_repo.save(molecularl_test);
            return  201;
        }
        else
            return  200;
    }
    @Override
    public int delete_molecularl_test(String TEST) {
        Optional<molecularl_test> m2 = molecularl_test_repo.findById(TEST);
        if ( m2.isEmpty())
            return 404;
        else
        {molecularl_test_repo.deleteById(TEST);
            return  200;

        }
    }
    @Override
    public List<molecularl_test> get_all_molecular_TEST() {
        return molecularl_test_repo.findAll();
    }

    @Override
    public List<String> get_all_TEST() {
        return molecularl_test_repo.all_Test_name();
    }
    @Override
    public void update(molecularl_test molecularl_test) {
        molecularl_test_repo.save(molecularl_test);
    }
}