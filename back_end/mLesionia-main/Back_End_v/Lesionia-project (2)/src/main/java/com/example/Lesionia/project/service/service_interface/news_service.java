package com.example.Lesionia.project.service.service_interface;

import com.example.Lesionia.project.domain.news;

import java.util.List;

public interface news_service {

    void save(news news);
    List<news> get_all();
    void delete(int id);
}
