package com.example.Lesionia.project.repo;

import com.example.Lesionia.project.domain.discrepancy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface discrepancy_repo extends JpaRepository<discrepancy,String> {

    @Query("select d from discrepancy d where d.PATIENTIDENTIFIER = ?1")
    List<discrepancy> get_all_my(String PATIENTIDENTIFIER);

    discrepancy findByiddiscrepancy(String iddiscrepancy);
}