package com.example.Lesionia.project.api;


import com.example.Lesionia.project.domain.travel_residency;
import com.example.Lesionia.project.domain.treatmenthistory;
import com.example.Lesionia.project.service.service_interface.treatmenthistory_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/treatmenthistory")
@RequiredArgsConstructor
public class treatmenthistory_ressource {

    private final treatmenthistory_service treatmenthistory_service;

    @PostMapping("/save")
    public ResponseEntity<treatmenthistory> save (@RequestBody treatmenthistory treatmenthistory)
    {
        return ResponseEntity.status(201).body(treatmenthistory_service.save(treatmenthistory));
    }
    @PostMapping("/update")
    public ResponseEntity<treatmenthistory> update (@RequestBody  treatmenthistory treatmenthistory)
    {
        log.info("Received treatment history: " + treatmenthistory);
        // Ensure IDTREATMENT is not null
        if (treatmenthistory.getIDTREATMENT()== null) {
            throw new IllegalArgumentException("IDTREATMENT cannot be null for update");
        }

        return ResponseEntity.status(200).body(treatmenthistory_service.update(treatmenthistory));
    }

    @GetMapping("get_one/{IDTREATMENT}")
    public ResponseEntity<treatmenthistory> get_one(@PathVariable String IDTREATMENT)
    {
      treatmenthistory treatmenthistory= treatmenthistory_service.get_one(IDTREATMENT);
      if (treatmenthistory ==null)
          return  ResponseEntity.status(404).body(treatmenthistory);
      return ResponseEntity.ok().body(treatmenthistory);
    }
    @GetMapping("/all")
    public ResponseEntity<List<treatmenthistory>> get_treatments()
    {    log.info("called treatment histories");
        List<treatmenthistory> list = treatmenthistory_service.get_treatments();
        if (list.size()==0)
            return ResponseEntity.status(204).body(list);
        return  ResponseEntity.ok().body(list);
    }
    @GetMapping("/all/{PATIENTIDENTIFIER}")
    public ResponseEntity<List<treatmenthistory>> get_all_patient(@PathVariable String PATIENTIDENTIFIER)
    {   List<treatmenthistory> list = treatmenthistory_service.get_all(PATIENTIDENTIFIER);
        if (list.size()==0)
            return  ResponseEntity.status(204).body(list);
        return ResponseEntity.ok().body(list);
    }


}
