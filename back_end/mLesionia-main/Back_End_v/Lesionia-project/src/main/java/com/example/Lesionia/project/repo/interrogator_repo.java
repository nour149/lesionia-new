package com.example.Lesionia.project.repo;

import com.example.Lesionia.project.domain.interrogator;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface interrogator_repo extends JpaRepository<interrogator,String> {
    interrogator  findByLOGINUSER (String LOGINUSER) ;


}
