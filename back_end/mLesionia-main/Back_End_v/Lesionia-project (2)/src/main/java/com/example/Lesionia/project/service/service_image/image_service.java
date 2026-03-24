package com.example.Lesionia.project.service.service_image;

import com.example.Lesionia.project.domain.discrepancy;
import com.example.Lesionia.project.domain.img;
import com.example.Lesionia.project.repo.img_repo;
import com.example.Lesionia.project.service.service_interface.alliquot_service;
import com.example.Lesionia.project.service.service_interface.disease_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;


import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Arrays;

@Service
@RequiredArgsConstructor
@Slf4j
public class image_service {
    private final img_repo img_repo;
    @Async
    public void saveImage(MultipartFile imageFile , String id_patient , String LOGINUSER , String idSample, Date DATE_MED) throws IOException {
        Path currentPath = Paths.get(".");
        Path absolutePath = currentPath.toAbsolutePath();
        /*photo.setPath(absolutePath + "/src/main/resources/static/photos/");*/
        byte[] bytes = imageFile.getBytes();
        String newpath="/home/lesionia/mobileApp/image/"+id_patient+"/";

        File pathAsFile = new File(newpath);


        if (!Files.exists(Paths.get(newpath))) {
            pathAsFile.mkdir();
        }
        String type = imageFile.getContentType();
        String str = imageFile.getOriginalFilename();
        String[] parts = str.split("\\.");
        File directoryPath = new File(newpath);
        String contents[] = directoryPath.list();
        int l = contents.length+1;
        Path path = Paths.get(newpath +id_patient+"_"+l+"."+parts[1]);
        Files.write(path, bytes);
        String path2 = path.toString();
        img image = new img(id_patient+"-"+l,id_patient,idSample,LOGINUSER,DATE_MED,path2,"loading",0);
        img_repo.save(image);
        try {

             // script(image.getPath());
test(image.getPath() ,image.getId());
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    public List getbyid(String idpatient){
        return img_repo.getbyid(idpatient);

    }


   /* public void  script(String path)
    {
        String value="";
        try {
            TimeUnit.SECONDS.sleep(2);
            log.info("begin");
            log.info(path);
            log.info("run script");
            ProcessBuilder pb = new ProcessBuilder("python3", "/home/lesionia/back_end/mLesionia-main/DeepLearning/test_folder/test.py", "" + path);
            Process p = pb.start();

            TimeUnit.SECONDS.sleep(2);
            log.info("begin read");
            BufferedReader in = new BufferedReader(new InputStreamReader(p.getInputStream()));
            log.info(String.valueOf(p.isAlive()));
            value = in.readLine();
            log.info(String.valueOf(p.isAlive()));
            System.out.println("value is ===   "+value);

        } catch (Exception e) {
            System.out.println(e);
        }
    }
*/

    public void  test(String path,String id)  throws IOException
    {


// The first half is in the local environment python Boot file address , The latter half is to be executed python Script address
        String[] arguments = new String[] {
                "/home/lesionia/anaconda3/bin/python3.8", "/home/lesionia/back_end/mLesionia-main/DeepLearning/test_folder/predict.py","" + path ,"" + "/home/lesionia/back_end/mLesionia-main/DeepLearning/test_folder/weight/vgg16-local.h5"};
        Process proc;
        try {

            proc = Runtime.getRuntime().exec(arguments);// perform py file
// Intercept the result with the input / output stream

            BufferedReader in = new BufferedReader(new InputStreamReader(proc.getInputStream()));
            new InputStreamReader(proc.getInputStream());
            String line = null;
            String classid="";
            float accuarcy=0;
            while (((line = in.readLine())) != null) {
                if (line.contains("Class Name : "))
                {

                    List<String> list = List.of(line.split(":"));
                    for (String a : list)
                    {    log.info(a);
                        classid= a;
                    }
                    log.info("list ! "+list);
                    line = in.readLine();
                    log.info(line);
                   accuarcy=Float.parseFloat(line);
                   log.info("acuarcy  "+accuarcy);
                }
                }
            aaa(classid,accuarcy,id);

            in.close();
//waitFor Is used to display whether the script runs successfully ,1 It means failure ,0 It means success , There are others that indicate other errors
            int re = proc.waitFor();
            System.out.println(re);
        } catch (IOException e) {

            e.printStackTrace();
        } catch (InterruptedException e) {

            e.printStackTrace();
        }
    }


    public  void aaa(String classid , float acc ,String id)
    {
        img img = img_repo.getById(id);
        img.setAccuarcy(acc);
        img.setClassid(classid);
        img_repo.save(img);
    }

}
