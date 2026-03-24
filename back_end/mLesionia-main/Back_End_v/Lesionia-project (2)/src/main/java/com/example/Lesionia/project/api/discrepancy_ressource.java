package com.example.Lesionia.project.api;

import com.example.Lesionia.project.domain.discrepancy;
import com.example.Lesionia.project.domain.medical_checkup;
import com.example.Lesionia.project.service.service_interface.discrepancy_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/discrepancy")
@RequiredArgsConstructor
public class discrepancy_ressource {

    private final discrepancy_service discrepancy_service;

    @PostMapping("/save")
    public ResponseEntity<discrepancy> save(@RequestBody discrepancy discrepancy )
    {
        URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath().path("/api/discrepancy/save").toUriString());
        return  ResponseEntity.created(uri).body(discrepancy_service.save_disc(discrepancy));
    }

    @GetMapping("/all")

    public ResponseEntity<List<discrepancy>> get_all()
    {    List<discrepancy> list = discrepancy_service.get_all();
        if (list.size()==0)
            return ResponseEntity.status(204).body(list);
        return ResponseEntity.ok().body(list);
    }

    @PostMapping("/update")
    public ResponseEntity<discrepancy> update(@RequestBody discrepancy discrepancy)
    {
        return ResponseEntity.ok().body(discrepancy_service.update_disc(discrepancy));
    }

    @GetMapping("/all_my/{PATIENTIDENTIFIER}")
    public  ResponseEntity<List<discrepancy>> get_all_my(@PathVariable String PATIENTIDENTIFIER)
    {
        List<discrepancy> list = discrepancy_service.getall_my(PATIENTIDENTIFIER);
        if (list.size()==0)
            return ResponseEntity.status(204).body(list);
        return ResponseEntity.ok().body(list);
    }

    @GetMapping("/one/{iddiscrepancy}")
    public ResponseEntity<discrepancy> get_one(@PathVariable String iddiscrepancy)
    {
        discrepancy d = discrepancy_service.get_one(iddiscrepancy);
        if ( d== null)
            return ResponseEntity.status(404).body(d);
        return ResponseEntity.ok().body(d);
    }

}
