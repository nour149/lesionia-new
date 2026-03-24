package com.example.Lesionia.project.service.service_imp;

import com.example.Lesionia.project.domain.news;
import com.example.Lesionia.project.repo.news_repo;
import com.example.Lesionia.project.service.service_interface.news_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Calendar;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class news_service_imp implements news_service {

    private  final news_repo news_repo;
    @Override
    public void save(news news) {
        java.sql.Date date = new java.sql.Date(Calendar.getInstance().getTime().getTime());
        news.setPUBLICATION_DATE(date);
        news_repo.save(news);

    }

    @Override
    public List<news> get_all() {
        return news_repo.findAllByOrderByNEWSIDENTIFIERAsc();
    }

    @Override
    public void delete(int id) {
        news_repo.deleteById(id);
    }
}
