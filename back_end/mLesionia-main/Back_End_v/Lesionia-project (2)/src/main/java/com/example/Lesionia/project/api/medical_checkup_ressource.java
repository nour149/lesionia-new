package com.example.Lesionia.project.api;

import com.example.Lesionia.project.domain.medical_checkup;
import com.example.Lesionia.project.domain.treatmenthistory;
import com.example.Lesionia.project.service.service_interface.medical_checkup_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/medical_checkup")
@RequiredArgsConstructor
public class medical_checkup_ressource {

    private final medical_checkup_service medical_checkup_service ;

    @PostMapping("/save")
    public ResponseEntity<medical_checkup> save_medical_checkup(@RequestBody medical_checkup medical_checkup )
    {
        URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath().path("/api/medical_checkup/save").toUriString());
        return  ResponseEntity.created(uri).body(medical_checkup_service.save_medical_checkup(medical_checkup));
    }

    @PostMapping("/update")
    public ResponseEntity<medical_checkup> update_medical_checkup(@RequestBody medical_checkup medical_checkup )
    {
        return  ResponseEntity.ok().body(medical_checkup_service.update_medical_checkup(medical_checkup));
    }

    @GetMapping("/my_medical_checkup/{IDMED}")
    public ResponseEntity<medical_checkup>get_my_patient(@PathVariable String IDMED)
    {
       medical_checkup medical_checkup=medical_checkup_service.get_one_medical_checkup(IDMED);
       if ( medical_checkup==null)
           return  ResponseEntity.status(404).body(medical_checkup);
        return  ResponseEntity.ok().body(medical_checkup);
    }
    @GetMapping("/all")
    public ResponseEntity<List<medical_checkup>> get_checkups()
    {    log.info("called all medical checkups");
        List<medical_checkup> list = medical_checkup_service.get_checkups();
        if (list.size()==0)
            return ResponseEntity.status(204).body(list);
        return  ResponseEntity.ok().body(list);
    }

    @GetMapping("/all/{PATIENTIDENTIFIER}")
    public ResponseEntity<List<medical_checkup>> get_my_medical_checkups(@PathVariable String PATIENTIDENTIFIER)
    { List<medical_checkup> list = medical_checkup_service.get_medical_checkup(PATIENTIDENTIFIER);
        if (list.size()==0)
            return  ResponseEntity.status(204).body(list);
        return ResponseEntity.ok().body(list);
    }
    @GetMapping("/all_date/{PATIENTIDENTIFIER}")
    public ResponseEntity<List<String>> get_all_date(@PathVariable String PATIENTIDENTIFIER)
    { List<String> list = medical_checkup_service.get_all_date(PATIENTIDENTIFIER);
        if (list.size()==0)
            return  ResponseEntity.status(204).body(list);
        return ResponseEntity.ok().body(list);
    }
    @GetMapping("/allcheckups/{LOGINUSER}")
    public   ResponseEntity<Integer> get_all_checkups(@PathVariable String LOGINUSER)
    {
        return ResponseEntity.ok().body(medical_checkup_service.get_allchecks(LOGINUSER));
    }

}
