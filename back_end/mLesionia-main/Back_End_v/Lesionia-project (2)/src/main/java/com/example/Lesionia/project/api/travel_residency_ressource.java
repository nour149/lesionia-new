package com.example.Lesionia.project.api;


import com.example.Lesionia.project.domain.patient;
import com.example.Lesionia.project.domain.travel_residency;
import com.example.Lesionia.project.service.service_interface.travel_residency_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/travel_residency")
@RequiredArgsConstructor
public class travel_residency_ressource {

    private final travel_residency_service travel_residency_service;

    @PostMapping("/save")
    public ResponseEntity<travel_residency> save(@RequestBody travel_residency travel_residency)
    {return ResponseEntity.status(201).body(travel_residency_service.save(travel_residency));}


    @PostMapping("/update")
    public ResponseEntity<travel_residency> update(@RequestBody travel_residency travel_residency)
    {return ResponseEntity.status(200).body(travel_residency_service.update_tr(travel_residency));}

    @GetMapping("/all")
    public ResponseEntity<List<travel_residency>> get_travels()
    {    log.info("called travels");
        List<travel_residency> list = travel_residency_service.get_travels();
        if (list.size()==0)
            return ResponseEntity.status(204).body(list);
        return  ResponseEntity.ok().body(list);
    }

    @GetMapping("get_one/{IDMVT}")
    public ResponseEntity<travel_residency> get_one(@PathVariable String IDMVT)
    {   travel_residency travel_residency =travel_residency_service.get_one(IDMVT);
        if (travel_residency == null)
            return  ResponseEntity.status(404).body(travel_residency);
        return ResponseEntity.ok().body(travel_residency);
    }


    @GetMapping("/get_all/{PATIENTIDENTIFIER}")
    public ResponseEntity<List<travel_residency>> get_all(@PathVariable String PATIENTIDENTIFIER)
    {
        List<travel_residency> list = travel_residency_service.get_all(PATIENTIDENTIFIER);
        if (list.size()==0)
            return  ResponseEntity.status(204).body(list);
        return ResponseEntity.ok().body(list);
    }
 @GetMapping("/gettravels/{LOGINUSER}")
    public ResponseEntity<Integer> get_alltravelsbyid(@PathVariable String LOGINUSER)
 {
     return ResponseEntity.ok().body(travel_residency_service.get_alltravelsbyid(LOGINUSER));
 }
}
