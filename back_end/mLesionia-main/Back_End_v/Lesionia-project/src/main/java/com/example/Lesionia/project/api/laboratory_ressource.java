package com.example.Lesionia.project.api;

import com.example.Lesionia.project.domain.laboratory;
import com.example.Lesionia.project.service.service_interface.laboratory_service;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.coyote.Response;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/laboratory")
@Slf4j
@AllArgsConstructor
public class laboratory_ressource {
    private  final laboratory_service  laboratory_service;

   // @PostMapping("/save")
    //public ResponseEntity<Integer> save_lab (@RequestBody  laboratory laboratory)
   // {   int sta= laboratory_service.save_lab(laboratory);
     //   return  ResponseEntity.status(sta).body(sta);
   // }

    @PostMapping("/save")
    public ResponseEntity<Integer> save_lab (@RequestBody laboratory laboratory) {
        log.info("Received laboratory object: {}", laboratory);
        int sta = laboratory_service.save_lab(laboratory);
        return ResponseEntity.ok(sta);
    }

    @PostMapping("update")
    public ResponseEntity<String> update (@RequestBody  laboratory laboratory)
    {    laboratory_service.update(laboratory);
        return  ResponseEntity.ok().body("laboratory updated");
    }

    @GetMapping("/all")
    public ResponseEntity<List<laboratory>> get_all ()
    {
        List<laboratory> liste = laboratory_service.all();
        if ( liste.size()==0)
            return ResponseEntity.status(204).body(liste);
        else
            return ResponseEntity.status(200).body(liste);
    }

    @DeleteMapping("")
    public ResponseEntity<String> delete_lab (@RequestParam String LABORATORYNAME)
    {
        int sta= laboratory_service.delete_lab(LABORATORYNAME);
        return  ResponseEntity.status(sta).body("check status");
    }

    @GetMapping("/all_name")
    public ResponseEntity<List<String>> get_all_name ()
    {
        List<String> liste = laboratory_service.all_name();
        if ( liste.size()==0)
            return ResponseEntity.status(204).body(liste);
        else
            return ResponseEntity.status(200).body(liste);
    }
}

