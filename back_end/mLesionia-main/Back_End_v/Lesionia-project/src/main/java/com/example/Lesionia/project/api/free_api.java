package com.example.Lesionia.project.api;


import com.example.Lesionia.project.domain.PostResponse;
import com.example.Lesionia.project.domain.my_user;
import com.example.Lesionia.project.service.service_interface.my_userService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/free")
@RequiredArgsConstructor
public class free_api {

    private final my_userService my_userService;
    private final com.example.Lesionia.project.service.service_interface.patient_service patient_service;


  @GetMapping("/verif_email/{email}")
    public ResponseEntity verif_email(@PathVariable String email)
   {
        log.info(email);
        my_user u = my_userService.get_by_email(email);
        Map<String,String> result= new HashMap<>();
        if (u ==null)
           result.put("result","not found");
     else
          result.put("result", my_userService.code_verification(email));
      return  ResponseEntity.ok().body(result);
   }

    @PostMapping("/verif_code")
    public ResponseEntity<?> verifyEmailCode(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        String code = request.get("code");

        my_user user = my_userService.get_by_email(email);

        if (user == null) {
            return ResponseEntity.badRequest().body(Map.of("error", "User not found"));
        }

        if (code.equals(user.getCodeVerification())) {
            return ResponseEntity.ok(Map.of("result", "Code verified successfully"));
        } else {
            return ResponseEntity.badRequest().body(Map.of("error", "Invalid code"));
        }
    }

    @PostMapping("/change_pw/{email}/{pw}")
    public ResponseEntity change_pwd(@PathVariable String email , @PathVariable String pw)
    {
        log.info(email);
        my_userService.change_mdp_email(email, pw);
        Map<String,String> result= new HashMap<>();
        result.put("result","Password Changed successfully");
        return ResponseEntity.ok().body(result);
    }




}
