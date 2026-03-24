package com.example.Lesionia.project.service.service_imp;

import com.example.Lesionia.project.domain.alliquot;
import com.example.Lesionia.project.repo.alliquot_repo;
import com.example.Lesionia.project.service.service_interface.alliquot_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class alliquot_service_imp implements alliquot_service {
    private final alliquot_repo alliquot_repo;

    @Override
    public void save_alliquot(alliquot alliquot) {
        String new_id = Integer.toString(alliquot_repo.findAll().size() + 1) + "-" + alliquot.getIDSAMPLE();
        alliquot.setIDALLUQUOT(new_id);
        alliquot_repo.save(alliquot);
    }
    @Override
    public void update_alliquot(alliquot alliquot) {
        alliquot_repo.save(alliquot);
    }

    @Override
    public alliquot get_by_id_sample(String idsample) {
        return alliquot_repo.get_by_id_sample(idsample);
    }

}
