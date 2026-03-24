package com.example.Lesionia.project.repo;

import com.example.Lesionia.project.domain.laboratory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface laboratory_repo extends JpaRepository<laboratory,String> {
    @Query("select l.LABORATORYNAME from laboratory l")
    List<String> all_name();
}
