package com.example.Lesionia.project.service.service_imp;


import com.example.Lesionia.project.domain.leishmania_species;
import com.example.Lesionia.project.repo.leishmania_species_repo;
import com.example.Lesionia.project.service.service_interface.leishmania_species_service;
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
public class leishmania_species_service_imp implements leishmania_species_service {

    private  final leishmania_species_repo leishmania_species_repo;

    @Override
    public int save(leishmania_species leishmania_species) {
        String id=leishmania_species.getSPECIES();
        Optional<leishmania_species> l = leishmania_species_repo.findById(id);
        if ( l.isEmpty())
        {
            leishmania_species_repo.save(leishmania_species);
            return  201;
        }
        else
            return  200;
    }

    @Override
    public int delete(String id) {
        Optional<leishmania_species> l = leishmania_species_repo.findById(id);
        if ( l.isEmpty())
            return  404 ;
        else
        {
            leishmania_species_repo.deleteById(id);
            return  200;
        }
    }

    @Override
    public List<leishmania_species> get_all() {
        return leishmania_species_repo.findAll();
    }

    @Override
    public List<String> get_all_leishmania_species() {
        return leishmania_species_repo.get_all_name();
    }

    @Override
    public void update(leishmania_species leishmania_species) {
        leishmania_species_repo.save(leishmania_species);
    }
}
