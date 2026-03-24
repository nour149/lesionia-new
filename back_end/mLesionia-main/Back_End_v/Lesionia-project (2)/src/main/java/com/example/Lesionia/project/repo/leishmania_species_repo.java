package com.example.Lesionia.project.repo;

import com.example.Lesionia.project.domain.leishmania_species;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface leishmania_species_repo extends JpaRepository<leishmania_species,String> {

    @Query("select SPECIES from leishmania_species")
    List<String> get_all_name();
}