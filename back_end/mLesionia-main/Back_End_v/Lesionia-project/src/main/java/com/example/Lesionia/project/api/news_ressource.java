package com.example.Lesionia.project.api;

import com.example.Lesionia.project.domain.news;
import com.example.Lesionia.project.service.service_interface.news_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api/news")
@RequiredArgsConstructor
public class news_ressource {

    private final news_service news_service;

    @PostMapping("/save")
    public ResponseEntity save_news(@RequestBody news news)
    {  news_service.save(news);
        Map<String,String> result= new HashMap<>();
        result.put("result","Ok");
        return  ResponseEntity.status(201).body(result);
    }

    @GetMapping("")
    public ResponseEntity<List<news>> get_all_news()
    {   List<news> list = news_service.get_all();
        if (list.size()==0) {
            return ResponseEntity.status(204).body(list);
        }
        else
        {
            return  ResponseEntity.ok().body(list);
        }
    }

    @DeleteMapping("/{id}")
    public  ResponseEntity delete_news (@PathVariable int id)
    {
        Map<String,String> result= new HashMap<>();
        result.put("result","Ok");
        news_service.delete(id);
        return  ResponseEntity.ok().body(result);
    }
}