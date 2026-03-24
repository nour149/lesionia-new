package com.example.Lesionia.project.api;


import com.example.Lesionia.project.domain.interrogator;
import com.example.Lesionia.project.domain.my_user;
import com.example.Lesionia.project.domain.objet_add;
import com.example.Lesionia.project.service.service_interface.interrogator_service;
import com.example.Lesionia.project.service.service_interface.my_userService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class my_user_ressource {

    private final my_userService my_userService;
    private final interrogator_service interrogator_service;


    @GetMapping("/all")
    public ResponseEntity<List<my_user>> getusers()
    {    log.info("called users");
        return  ResponseEntity.ok().body(my_userService.getusers());
    }



    @GetMapping("/{LOGINUSER}")
    public ResponseEntity<my_user>get_my_user(@PathVariable String LOGINUSER)
    {   log.info("called my user");
        return  ResponseEntity.ok().body(my_userService.getmy_user(LOGINUSER));
    }



    @PostMapping("/save")
    public ResponseEntity <my_user> save_user(@RequestBody my_user my_user)
    {
        URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath().path("/api/user/save").toUriString());
        return  ResponseEntity.created(uri).body(my_userService.savemy_user(my_user));
    }

    @GetMapping("/interrogator/{LOGINUSER}")
    public ResponseEntity<interrogator>get_my_interrogator(@PathVariable String LOGINUSER)
    {   log.info("called for interrogator  "+ LOGINUSER);
        return  ResponseEntity.ok().body(interrogator_service.get_interrogator(LOGINUSER));
    }

    @PostMapping("verif/pass/{LOGINUSER}/{mdp}")
    public boolean verif(@PathVariable String LOGINUSER , @PathVariable String mdp)
    {   log.info("called for verif   "+ LOGINUSER +"  "+ mdp);
        return  my_userService.verif_mdp(LOGINUSER,mdp);
    }

    @PutMapping("/update/pw/{LOGINUSER}/{mdp}")
    public ResponseEntity update_pw(@PathVariable String LOGINUSER , @PathVariable String mdp){
        log.info("called for update password  "+mdp);
        my_userService.change_mdp(LOGINUSER,mdp);
        Map<String,String> result= new HashMap<>();
        result.put("result","Password Changed successfully");
        return ResponseEntity.status(200).body(result);
    }
    @PostMapping("register/{loginuser}")
    public ResponseEntity  savee(@RequestBody objet_add xx , @PathVariable String loginuser)
    {
        log.info(xx.toString());
        log.info(loginuser);
        Map<String,String> result= new HashMap<>();
        result.put("result",my_userService.register(xx, loginuser));
        return  ResponseEntity.status(200).body(result);
    }
    @PutMapping()
    public ResponseEntity update(@RequestBody objet_add objet_add)
    {
        my_userService.update(objet_add);
        Map<String,String> result= new HashMap<>();
        result.put("result","user updated successfully");
        return  ResponseEntity.status(200).body(result);
    }

    @DeleteMapping("/{loginuser}")
    public ResponseEntity delete(@PathVariable String loginuser)
    {
        my_userService.delete(loginuser);
        Map<String,String> result= new HashMap<>();
        result.put("result","user deleted successfully");
        return  ResponseEntity.status(200).body(result);
    }
}