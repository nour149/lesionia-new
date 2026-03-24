package com.example.Lesionia.project.repo;

import com.example.Lesionia.project.domain.travel_residency;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface travel_residency_repo  extends JpaRepository<travel_residency,String> {

    travel_residency findByIDMVT (String IDMVT);

    @Query("select t from travel_residency t where  t.PATIENTIDENTIFIER = ?1")
    List<travel_residency> get_all(String PATIENTIDENTIFIER);
    @Query(value ="SELECT COUNT(*) FROM travel_residency WHERE loginuser = ?1",nativeQuery = true)
    int get_alltravelsbyid(String loginuser);
}
