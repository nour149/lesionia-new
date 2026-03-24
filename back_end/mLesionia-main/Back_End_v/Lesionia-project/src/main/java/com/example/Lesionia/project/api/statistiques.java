package com.example.Lesionia.project.api;

import com.example.Lesionia.project.domain.PostResponse;
import com.example.Lesionia.project.service.service_interface.diognosis_service;
import com.example.Lesionia.project.service.service_interface.medical_checkup_service;
import com.example.Lesionia.project.service.service_interface.patient_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api/stats")
@RequiredArgsConstructor
public class statistiques {

    private final patient_service patient_service;
    private final diognosis_service diognosis_service;
    private final medical_checkup_service medical_checkup_service;
    @GetMapping("/gender")
    public ResponseEntity gender()
    {
        Map<String,String> result= new HashMap<>();
        result.put("Male",Integer.toString(patient_service.male_number()));
        result.put("Female",Integer.toString(patient_service.female_number()));
        return  ResponseEntity.ok().body(result);
    }

    @GetMapping("/age")
    public ResponseEntity age()
    {
        List list = patient_service.get_by_age();
        return  ResponseEntity.ok().body(list);
    }

    @GetMapping("/lab_name")
    public ResponseEntity lab_name()
    {
        List list = diognosis_service.get_by_name();
        return  ResponseEntity.ok().body(list);
    }


    @GetMapping("/species")
    public ResponseEntity species()
    {
        List list = diognosis_service.get_by_species();
        return  ResponseEntity.ok().body(list);
    }

    @GetMapping("/test")
    public ResponseEntity test()
    {
        List list = diognosis_service.get_by_TEST();
        return  ResponseEntity.ok().body(list);
    }

    @GetMapping("/patient_by_user")
    public List<Object[]> stats()
    {
        return patient_service.patient_by_user();
    }

    @GetMapping("/group_by_age")
    public ResponseEntity group_by_age ()
    {
        Map<String,List> result= new HashMap<>();
        result.put("Male",patient_service.male_number_by_age());
        result.put("Female",patient_service.female_number_by_age());
        result.put("N/A",patient_service.n_a_number_by_age());
        result.put("age",patient_service.list_age());
        return  ResponseEntity.ok().body(result);
    }

    @GetMapping("/date_checkup/{loginuser}")
    public ResponseEntity date_checkup(@PathVariable String loginuser)
    {
        List list = medical_checkup_service.checkup_date(loginuser);
        return  ResponseEntity.ok().body(list);
    }
}

