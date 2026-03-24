package com.example.Lesionia.project.api;

import com.example.Lesionia.project.domain.diognosis;
import com.example.Lesionia.project.service.service_interface.diognosis_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/diognosis")
@RequiredArgsConstructor
public class diognosis_ressource {

    private final diognosis_service diagnosis_service;

    @PostMapping("/save")
    public ResponseEntity<diognosis> save_dig(@RequestBody diognosis diagnosis)
    {
        log.info("  "+diagnosis);
        return  ResponseEntity.status(201).body(diagnosis_service.save_dig(diagnosis));
    }

    @GetMapping("/one/{IDDIAGNOSIS}")
    public ResponseEntity <diognosis> get_one_dig (@PathVariable String IDDIAGNOSIS)
    {
        diognosis dig = diagnosis_service.get_one_dig(IDDIAGNOSIS);
        if ( dig == null)
            return ResponseEntity.status(404).body(dig);
        return  ResponseEntity.ok().body(dig);
    }

    @GetMapping("/all_by_sample/{IDSAMPLE}")
    public ResponseEntity<List<diognosis>> all_by_sample(@PathVariable String IDSAMPLE)
    {
        List<diognosis> list = diagnosis_service.get_all_by_sample(IDSAMPLE);
        if (list.size() == 0)
            return  ResponseEntity.status(204).body(list);
        return  ResponseEntity.ok().body(list);
    }

    @PostMapping("/update")
    public ResponseEntity<diognosis> update_dig(@RequestBody diognosis diagnosis)
    {
        return  ResponseEntity.ok().body(diagnosis_service.update_dig(diagnosis));
    }
}
