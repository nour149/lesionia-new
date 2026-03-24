package com.example.Lesionia.project.api;


import com.example.Lesionia.project.domain.interrogator;
import com.example.Lesionia.project.domain.my_user;
import com.example.Lesionia.project.domain.objet_add;
import com.example.Lesionia.project.domain.patient;
import com.example.Lesionia.project.service.service_interface.interrogator_service;
import com.example.Lesionia.project.service.service_interface.my_userService;
//import com.example.
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;


    @GetMapping("/all")
    public ResponseEntity<List<my_user>> getusers()
    {    log.info("called users");
        return  ResponseEntity.ok().body(my_userService.getusers());
    }

    @GetMapping("/test-hash")
    public void testBCrypt() {
        String plain = "mouna";
        String hashed = passwordEncoder.encode(plain);

        System.out.println("Generated new hash: " + hashed);
        System.out.println("Matches (self-check): " + passwordEncoder.matches(plain, hashed));
    }

    @GetMapping("/{LOGINUSER}")
    public ResponseEntity<my_user>get_my_user(@PathVariable String LOGINUSER)
    {   log.info("called my user");
        return  ResponseEntity.ok().body(my_userService.getmy_user(LOGINUSER));
    }


    @PostMapping("/login")
    public ResponseEntity<Map<String, String>> login(@RequestBody Map<String, String> credentials) {
        String loginuser = credentials.get("loginuser");
        String motdpass = credentials.get("motdpass");

        log.info("Login attempt for user: {}", loginuser);

        my_user user = my_userService.getmy_user(loginuser);
        if (user == null) {
            log.error("User not found: {}", loginuser);
            Map<String, String> response = new HashMap<>();
            response.put("result", "Invalid username or password");
            return ResponseEntity.status(401).body(response);
        }

        log.info("User found: {}", user.getLOGINUSER());

        boolean isAuthenticated = my_userService.verif_mdp(loginuser, motdpass);
        log.info("Password verification result: {}", isAuthenticated);

        Map<String, String> response = new HashMap<>();
        if (isAuthenticated) {
            response.put("result", "Well connected");

            // ✅ Add the email to the response
            response.put("email", user.getEMAIL()); // Ensure user.getEMAIL() is not null
            response.put("levelsecure", user.getLevelsecure()); // ← ADD THIS LINE

        } else {
            log.error("Invalid credentials for user: {}", loginuser);
            response.put("result", "Invalid username or password");
        }

        log.info("Final response map before returning: {}", response);

        return ResponseEntity.status(isAuthenticated ? 200 : 401).body(response);
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
    @PostMapping("/modify/{loginuser}")
    public ResponseEntity <String> update(@RequestBody objet_add xx1,@PathVariable String loginuser)
    {  //  log.info(xx1.toString());
        //my_user myUser = my_user_repo.findByLOGINUSER(loginuser);
        my_userService.update(xx1);
        Map<String,String> result= new HashMap<>();
        result.put("result","user updated successfully");
        return  ResponseEntity.status(200).body(result.toString());
    }






    @DeleteMapping("/{loginuser}")
    public ResponseEntity delete(@PathVariable String loginuser)
    {   my_user user = my_userService.getmy_user(loginuser);
        if (user == null) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(Map.of("error", "User not found"));
    }


        my_userService.delete(loginuser);
        Map<String,String> result= new HashMap<>();
        result.put("result","user deleted successfully");
        return  ResponseEntity.status(200).body(result);
    }

    @GetMapping("/email/{loginuser}")
    public ResponseEntity<Map<String, String>> getEmailByLoginUser(@PathVariable String loginuser) {
        log.info("Fetching email for user: {}", loginuser);
        my_user user = my_userService.getmy_user(loginuser);

        if (user == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("error", "User not found"));
        }

        Map<String, String> response = new HashMap<>();
        response.put("email", user.getEMAIL());

        return ResponseEntity.ok(response);
    }













}