package com.example.Lesionia.project.api;

import com.example.Lesionia.project.domain.alliquot;
import com.example.Lesionia.project.service.service_interface.alliquot_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/api/alliquot/")
@RequiredArgsConstructor
public class alliquot_ressource {

    private final alliquot_service alliquot_service;

    @PostMapping("save")
    public ResponseEntity<String> save(@RequestBody alliquot alliquot)
    {alliquot_service.save_alliquot(alliquot);
        return  ResponseEntity.status(201).body("aliquot saved successfully");
    }

    @GetMapping("{idsample}")
    public ResponseEntity<alliquot> get(@PathVariable String idsample)
    {  alliquot alliquot = alliquot_service.get_by_id_sample(idsample);
        if (alliquot == null)
               return  ResponseEntity.status(204).body(alliquot_service.get_by_id_sample(idsample));
        else
            return  ResponseEntity.ok().body(alliquot_service.get_by_id_sample(idsample));
    }

    @PostMapping("update")
    public ResponseEntity<String> update(@RequestBody alliquot alliquot)
    {   alliquot_service.update_alliquot(alliquot);
        return  ResponseEntity.ok().body("aliquot updated successfully");
    }
}
