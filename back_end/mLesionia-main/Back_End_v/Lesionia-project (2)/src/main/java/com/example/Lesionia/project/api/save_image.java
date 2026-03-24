package com.example.Lesionia.project.api;

import com.example.Lesionia.project.domain.img;
import com.example.Lesionia.project.service.service_image.image_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/image")
@RequiredArgsConstructor
public class save_image {


@Autowired
image_service image_sevice;

    @PostMapping("/upload")
    public ResponseEntity<String> uploadFile(@RequestParam("file") MultipartFile file , @RequestParam("id_patient") String id_patient ,  @RequestParam("loginuser") String loginuser , @RequestParam("idsample") String idsample, @RequestParam("DATE_MED") Date DATE_MED) {
       log.info(id_patient);
       log.info(idsample);
       log.info(loginuser);
        String message = "";

        try {
            log.info(file.getName()+"   "+file.getOriginalFilename());
            message = "Uploaded the file successfully: " + file.getOriginalFilename();
            image_sevice.saveImage(file,id_patient , loginuser,idsample,DATE_MED);
            return ResponseEntity.status(HttpStatus.OK).body(message);
        } catch (Exception e) {
            message = "Could not upload the file: " + file.getOriginalFilename() + "!";
            return ResponseEntity.status(HttpStatus.EXPECTATION_FAILED).body(message);
        }
    }
    @GetMapping("/Getimage")
    public byte[] getImage(@RequestParam("path") String path) throws IOException {

     /*   String aa = "D:\\projet_spring\\image_uploaded\\ipt220001\\ipt220001_4.jpg";

      */
        log.info(path);
        Path path2 = Paths.get(path);
        byte[] bytes =Files.readAllBytes(path2);
        return bytes;
    }
    @GetMapping("/all/{id_patient}")
    public  ResponseEntity<List<img>> get_all_id(@PathVariable String id_patient)
    {    List<img> liste =image_sevice.getbyid(id_patient);
        if (liste.size()==0)
            return  ResponseEntity.status(204).body(liste);
        else
            return ResponseEntity.ok().body(liste);
    }
}
