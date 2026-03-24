package com.example.Lesionia.project.repo;

import com.example.Lesionia.project.domain.img;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface img_repo extends JpaRepository<img,String> {
@Query("Select i from img i where i.idpatient = ?1")
List<img> getbyid(String idpatient);

}
