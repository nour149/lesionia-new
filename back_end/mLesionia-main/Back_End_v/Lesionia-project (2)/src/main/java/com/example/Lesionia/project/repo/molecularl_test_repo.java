package com.example.Lesionia.project.repo;

import com.example.Lesionia.project.domain.molecularl_test;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface molecularl_test_repo extends JpaRepository<molecularl_test,String> {

    @Query("select TEST from molecularl_test ")
    List<String> all_Test_name();

}
