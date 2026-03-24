package com.example.Lesionia.project.service.service_imp;


import com.example.Lesionia.project.domain.disease;
import com.example.Lesionia.project.domain.molecularl_test;
import com.example.Lesionia.project.repo.disease_repo;
import com.example.Lesionia.project.service.service_interface.disease_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class disease_service_imp implements disease_service {

    private final disease_repo disease_repo;

    @Override
    public int save(disease disease)
    {
        String id = disease.getClassid();
        Optional<disease> d2 = disease_repo.findById(id);
        if ( d2.isEmpty())
        {
            disease_repo.save(disease);
            return  201;
        }
        else
            return  200;
    }

    @Override
    public int delete(String id) {
        Optional<disease> d2 = disease_repo.findById(id);
        if ( d2.isEmpty())
        {  return  404; }
        else
        {   disease_repo.deleteById(id);
            return  200;
        }
    }

    @Override
    public List<disease> get_all() {
        return disease_repo.findAll();
    }

    @Override
    public void update(disease disease) {
        disease_repo.save(disease);
    }

    @Override
    public disease get_by_id(String id) {
        return disease_repo.getById(id);
    }
}