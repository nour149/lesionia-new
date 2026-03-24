package com.example.Lesionia.project.api;

import com.example.Lesionia.project.domain.leishmania_species;
import com.example.Lesionia.project.domain.molecularl_test;
import com.example.Lesionia.project.service.service_interface.molecularl_test_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/molecularl_test/")
@Slf4j
@RequiredArgsConstructor
public class molecularl_test_ressource {

    private final molecularl_test_service molecularl_test_service;
    @PostMapping("save")
    public ResponseEntity<Integer> save (@RequestBody molecularl_test molecularl_test)
    {
        int status = molecularl_test_service.save_molecularl_test(molecularl_test);
        return  ResponseEntity.status(status).body(status);
    }
    @GetMapping("all")
    public  ResponseEntity<List<molecularl_test>> get_all()
    {
        List<molecularl_test> list = molecularl_test_service.get_all_molecular_TEST();
        if (list.size() ==0 )
            return  ResponseEntity.status(204).body(list);
        else
            return  ResponseEntity.ok().body(list);
    }

    @GetMapping("all_test")
    public  ResponseEntity <List<String>> get_all_test()
    {
        List<String> list = molecularl_test_service.get_all_TEST();
        if (list.size() ==0 )
            return  ResponseEntity.status(204).body(list);
        else
            return  ResponseEntity.ok().body(list);
    }

    @DeleteMapping("")
    public ResponseEntity<String> delete (@RequestParam String id)
    {
        int status = molecularl_test_service.delete_molecularl_test(id);
        return  ResponseEntity.status(status).body("check status");
    }

    //@PostMapping("update")
    //public ResponseEntity<String> update (@RequestBody molecularl_test molecularl_test)
    //{
     //   molecularl_test_service.update(molecularl_test);
       // return  ResponseEntity.ok().body("molecularl_test updated");
    //}


@PutMapping("/updatetest")
public ResponseEntity<String> update (@RequestBody molecularl_test molecularl_test)

{
    molecularl_test_service.update(molecularl_test);
    return ResponseEntity.ok().body("molecular_test updated");
}





}