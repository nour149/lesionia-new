package com.example.Lesionia.project.api;


import com.example.Lesionia.project.domain.leishmania_species;
import com.example.Lesionia.project.service.service_interface.leishmania_species_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api/leishmania_species/")
@RequiredArgsConstructor
public class leishmania_species_ressource {

    private final leishmania_species_service leishmania_species_service;

    @GetMapping("all_species")
    public ResponseEntity<List<String>> get_all_name()
    {
        List<String> list = leishmania_species_service.get_all_leishmania_species();
        if (list.size() ==0 )
            return  ResponseEntity.status(204).body(list);
        else
            return  ResponseEntity.ok().body(list);
    }

    @GetMapping("all")
    public ResponseEntity<List<leishmania_species>> get_all()
    {
        List<leishmania_species> list = leishmania_species_service.get_all();
        if (list.size() ==0 )
            return  ResponseEntity.status(204).body(list);
        else
            return  ResponseEntity.ok().body(list);
    }

    @PostMapping("save")
    public  ResponseEntity<Integer> save(@RequestBody leishmania_species leishmania_species)
    {
        int status =  leishmania_species_service.save(leishmania_species);
        return  ResponseEntity.status(status).body(status);
    }

   // @PostMapping("update")
    //public  ResponseEntity<String> update ( @RequestBody leishmania_species leishmania_species)
    //{
      //  leishmania_species_service.update(leishmania_species);
        //return  ResponseEntity.ok().body("check status");
    //}

   // @PutMapping("update")
    //public ResponseEntity<String> update(@RequestBody leishmania_species leishmania_species) {
     //   leishmania_species_service.update(leishmania_species);
       // return ResponseEntity.ok().body("check status");
    //}



    @PutMapping("/update")
    public ResponseEntity<String> update(@RequestBody leishmania_species species) {
        try {
            leishmania_species_service.update(species);
            return ResponseEntity.ok("Mise à jour réussie.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Erreur lors de la mise à jour : " + e.getMessage());
        }
    }



   // @DeleteMapping("/delete")
    //public  ResponseEntity<String> delete( @RequestParam String id )
    //{   log.info(id);
      //  int status = leishmania_species_service.delete(id);
       // return  ResponseEntity.status(status).body("check status");
    //}

    @DeleteMapping("/delete")
    public ResponseEntity<String> delete(@RequestBody leishmania_species species) {
        String speciesId = species.getSPECIES();
        if (speciesId == null || speciesId.isEmpty()) {
            return ResponseEntity.badRequest().body("Le champ 'SPECIES' est requis.");
        }

        int status = leishmania_species_service.delete(speciesId);
        return ResponseEntity.status(status).body("check status");
    }





}
