package com.example.Lesionia.project.repo;

import com.example.Lesionia.project.domain.sample;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface sample_repo extends JpaRepository<sample,String> {

    sample findByIDSAMPLE(String IDSAMPLE);

    @Query("select s from sample s where  s.PATIENTIDENTIFIER = ?1")
    List<sample> get_all_my(String PATIENTIDENTIFIER);

    @Query("select s.IDSAMPLE from sample s where s.PATIENTIDENTIFIER = ?1")
    List<String> get_all_id(String PATIENTIDENTIFIER);
    @Query(value ="SELECT COUNT(*) FROM sample WHERE loginuser = ?1",nativeQuery = true)
    int get_allsamples(String loginuser);
}
