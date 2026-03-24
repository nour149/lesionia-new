package com.example.Lesionia.project.repo;

import com.example.Lesionia.project.domain.treatmenthistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface treatmenthistory_repo extends JpaRepository<treatmenthistory,String>
{
    treatmenthistory findByIDTREATMENT(String IDTREATMENT);

    @Query("select t from treatmenthistory t where  t.PATIENTIDENTIFIER = ?1")
    List<treatmenthistory> get_all(String PATIENTIDENTIFIER);

}

