package com.example.Lesionia.project.api;


import com.example.Lesionia.project.domain.sample;
import com.example.Lesionia.project.service.service_interface.sample_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/sample")
@RequiredArgsConstructor
public class sample_ressource {

    private final sample_service sample_service;

    @GetMapping("/all")
    public ResponseEntity<List<sample>> get_all()
    {
        List<sample> list =sample_service.getall();
        if (list.size()==0)
           return  ResponseEntity.status(204).body(list);
        return  ResponseEntity.ok().body(list);
    }

    @PostMapping("/save")
    public ResponseEntity<String>  save (@RequestBody sample sample )
    {return ResponseEntity.status(201).body(sample_service.save(sample));}


    @GetMapping("/get_one/{IDSAMPLE}")
    public ResponseEntity<sample> get_one(@PathVariable String IDSAMPLE)
    {
        sample sample =sample_service.get_one(IDSAMPLE);
        if (sample==null)
           return  ResponseEntity.status(404).body(sample);
        return  ResponseEntity.ok().body(sample);
    }

    @GetMapping("/all_my/{PATIENTIDENTIFIER}")
    public ResponseEntity<List<sample>> get_all_my(@PathVariable String PATIENTIDENTIFIER)
    {
        List<sample> list =sample_service.getall_my(PATIENTIDENTIFIER);
        if (list.size()==0)
           return  ResponseEntity.status(204).body(list);
        return  ResponseEntity.ok().body(list);
    }
    @PostMapping("/update")
    public ResponseEntity<sample> update(@RequestBody sample sample){
        return ResponseEntity.ok().body(sample_service.update(sample));
    }
    @GetMapping("/all_id/{PATIENTIDENTIFIER}")
    public  ResponseEntity<List<String>> get_all_id(@PathVariable String PATIENTIDENTIFIER)
    {    List<String> liste =sample_service.get_all_id(PATIENTIDENTIFIER);
        if (liste.size()==0)
            return  ResponseEntity.status(204).body(liste);
        else
            return ResponseEntity.ok().body(liste);
    }
 @GetMapping("/getsamples/{LOGINUSER}")
    public ResponseEntity<Integer> get_allsamples(@PathVariable String LOGINUSER)
 {
     return ResponseEntity.ok().body(sample_service.get_allsamples(LOGINUSER));
 }
}
