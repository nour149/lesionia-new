package com.example.Lesionia.project.service.service_interface;

import com.example.Lesionia.project.domain.leishmania_species;

import java.util.List;

public interface leishmania_species_service {

    int save(leishmania_species leishmania_species);
    int delete(String id);
    List<leishmania_species> get_all();
    List<String> get_all_leishmania_species();
    void update(leishmania_species leishmania_species);
}