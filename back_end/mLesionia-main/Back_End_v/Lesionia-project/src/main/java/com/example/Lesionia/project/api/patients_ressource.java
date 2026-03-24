package com.example.Lesionia.project.api;

import com.example.Lesionia.project.domain.PostResponse;
import com.example.Lesionia.project.domain.molecularl_test;
import com.example.Lesionia.project.domain.patient;
import com.example.Lesionia.project.service.service_interface.patient_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/patient")
@RequiredArgsConstructor
public class patients_ressource {

    private final patient_service patient_service;


    @GetMapping("/all")
    public ResponseEntity<List<patient>> getpatients() {
        log.info("called patients");
        List<patient> list = patient_service.get_patients();
        if (list.size() == 0)
            return ResponseEntity.status(204).body(list);
        return ResponseEntity.ok().body(list);
    }

    @GetMapping("/all_my/{LOGINUSER}")
    public ResponseEntity<List<patient>> get_my_patients(@PathVariable String LOGINUSER) {
        log.info("called patients " + LOGINUSER);
        List<patient> list = patient_service.get_my_patients(LOGINUSER);
        if (list.size() == 0)
            return ResponseEntity.status(204).body(list);
        return ResponseEntity.ok().body(list);
    }


    @GetMapping("/my_patient/{PATIENTIDENTIFIER}")
    public ResponseEntity<patient> get_my_patient(@PathVariable String PATIENTIDENTIFIER) {
        log.info("called my patient");
        patient p = patient_service.get_one_patient(PATIENTIDENTIFIER);
        if (p == null)
            return ResponseEntity.status(404).body(p);
        return ResponseEntity.ok().body(p);
    }


    @PostMapping("/save")
    public ResponseEntity<patient> save_patient(@RequestBody patient patient) {
        log.info("save new patient");
        URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath().path("/api/patient/save").toUriString());
        return ResponseEntity.created(uri).body(patient_service.save_patient(patient));
    }


   // @PostMapping("/update")
   // public ResponseEntity<patient> update_patient(@RequestBody patient patient) {
     //   log.info("update patient");
       // return ResponseEntity.ok().body(patient_service.update_patient(patient));
    //}



     @PutMapping("/update")
     public ResponseEntity<String> update (@RequestBody patient patient) {
       patient_service.update_patient(patient);
     return ResponseEntity.ok().body("Patient is well updated");
    }




    @GetMapping("/number/{num}")

    public int get_number(@PathVariable String num) {
        return patient_service.get_number(num);
    }

    @GetMapping("/allpage/{x}")
    public ResponseEntity<PostResponse> page(@PathVariable int x) {
        log.info("called patients");
        PostResponse p = patient_service.get_patients_pagination(x, 5);

        return ResponseEntity.ok().body(p);
    }

    @GetMapping("/allpage/{x}/{y}")
    public ResponseEntity<PostResponse> page2(@PathVariable int x, @PathVariable String y) {
        log.info("called patients");
        PostResponse p = patient_service.get_my_patients_pagination(y, x, 5);

        return ResponseEntity.ok().body(p);
    }
    @GetMapping("/patients_frominst/{frominst}/{pageNo}")
    public ResponseEntity patients_frominst(@PathVariable String frominst,@PathVariable int pageNo)
    {
        PostResponse p =patient_service.get_all_by_inst(frominst,pageNo);
        return  ResponseEntity.ok().body(p);
    }


    @GetMapping("/count_by_user")
    public ResponseEntity<List<?>> getPatientCountByLoginUser() {
        log.info("Called patient count by login user");
        List<?> list = patient_service.getPatientCountByLoginUser();

        if (list.isEmpty()) {
            return ResponseEntity.status(204).body(list);
        }
        return ResponseEntity.ok().body(list);
    }
    }



