package com.example.Lesionia.project.repo;

import com.example.Lesionia.project.domain.alliquot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface alliquot_repo extends JpaRepository<alliquot,String> {

    @Query("select a from alliquot a where a.IDSAMPLE =?1")
    alliquot get_by_id_sample(String sample_id);
}
