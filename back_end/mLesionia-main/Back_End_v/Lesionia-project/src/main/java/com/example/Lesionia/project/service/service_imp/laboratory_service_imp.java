package com.example.Lesionia.project.service.service_imp;

import com.example.Lesionia.project.domain.laboratory;
import com.example.Lesionia.project.repo.laboratory_repo;
import com.example.Lesionia.project.service.service_interface.laboratory_service;
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
public class laboratory_service_imp implements laboratory_service {
    private final laboratory_repo laboratory_repo;
    @Override
    public List<String> all_name() {return laboratory_repo.all_name();}

    @Override
    public void update(laboratory laboratory) {
        laboratory_repo.save(laboratory);
    }

    @Override
    public int save_lab(laboratory laboratory) {
        log.info(laboratory.getLABORATORYNAME());
        Optional<laboratory> l = laboratory_repo.findById(laboratory.getLABORATORYNAME());
        if (l.isEmpty()) {
            laboratory_repo.save(laboratory);
            return  201;
        }
        else
        {
            return 200;

        }
    }

    @Override
    public List<laboratory> all() {
        return laboratory_repo.findAll();
    }



    @Override
    public int delete_lab(String LABORATORYNAME) {
        Optional<laboratory> l = laboratory_repo.findById(LABORATORYNAME);
        if (l.isEmpty()) {
            return 404;
        }
        else
        {
            laboratory_repo.deleteById(LABORATORYNAME);
            return 200;
        }
    }

}

