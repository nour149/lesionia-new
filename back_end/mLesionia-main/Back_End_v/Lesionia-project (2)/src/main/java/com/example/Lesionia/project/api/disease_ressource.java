package com.example.Lesionia.project.api;
import com.example.Lesionia.project.domain.disease;
import com.example.Lesionia.project.service.service_interface.disease_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/disease")
@RequiredArgsConstructor
public class disease_ressource {
    private final disease_service disease_service;



    @GetMapping("all")
    public ResponseEntity<List<disease>> get_all()
    {
        List<disease> list = disease_service.get_all();
        if (list.size() ==0 )
            return  ResponseEntity.status(204).body(list);
        else
            return  ResponseEntity.ok().body(list);
    }

    @PostMapping("save")
    public  ResponseEntity<Integer> save(@RequestBody disease disease)
    {
        int status =  disease_service.save(disease);
        return  ResponseEntity.status(status).body(status);
    }

    @PostMapping("update")
    public  ResponseEntity<String> update ( @RequestBody disease disease)
    {
        disease_service.update(disease);
        return  ResponseEntity.ok().body("check status");
    }

    @DeleteMapping("")
    public  ResponseEntity<String> delete( @RequestParam String id )
    {   log.info(id);
        int status = disease_service.delete(id);
        return  ResponseEntity.status(status).body("check status");
    }
}