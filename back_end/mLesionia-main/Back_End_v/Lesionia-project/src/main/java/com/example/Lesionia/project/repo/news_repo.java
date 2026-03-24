package com.example.Lesionia.project.repo;

import com.example.Lesionia.project.domain.news;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface news_repo extends JpaRepository<news,Integer> {
    public List<news> findAllByOrderByNEWSIDENTIFIERAsc();
}


