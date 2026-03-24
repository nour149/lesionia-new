package com.example.Lesionia.project.service.service_image;

import com.example.Lesionia.project.domain.img;
import com.example.Lesionia.project.repo.img_repo;
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
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;


import java.io.BufferedReader;
import java.io.IOException;

@Service
@RequiredArgsConstructor
@Slf4j
public class image_service {


    private final img_repo img_repo;
    @Async
    public void saveImage(MultipartFile imageFile , String id_patient , String LOGINUSER , String idSample, Date DATE_MED) throws IOException {
        log.info("image  "+imageFile);
        Path currentPath = Paths.get(".");
        Path absolutePath = currentPath.toAbsolutePath();
        /*photo.setPath(absolutePath + "/src/main/resources/static/photos/");*/
        byte[] bytes = imageFile.getBytes();
        //String newpath="C:/Users/msi/Documents/new_lesionia_project/image/"+id_patient+"/";
        String newpath="C:/ImageStorage/"+id_patient+"/";

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

    public void test(String path, String id) throws IOException {
        String[] arguments = new String[] {
                "C:/Users/msi/AppData/Local/Programs/Python/Python38/python.exe",
                "C:/Users/msi/Documents/back_end_test2/mLesionia-main/DeepLearning/test_folder/predict.py",
                path,
                "C:/Users/msi/Documents/back_end_test2/mLesionia-main/DeepLearning/test_folder/weight/vgg16.h5"
        };

        log.info("Starting script with image path: " + path);
        log.info("Command to execute: " + Arrays.toString(arguments));

        Process proc;
        try {
            proc = Runtime.getRuntime().exec(arguments);

            // Log output from Python
            BufferedReader in = new BufferedReader(new InputStreamReader(proc.getInputStream()));
            BufferedReader err = new BufferedReader(new InputStreamReader(proc.getErrorStream()));

            String line;
            String classid = "";
            float accuracy = 0;

            while ((line = in.readLine()) != null) {
                log.info("PYTHON OUTPUT: " + line);
                if (line.contains("Class Name : ")) {
                    List<String> list = List.of(line.split(":"));
                    if (list.size() > 1) {
                        classid = list.get(1).trim();
                        log.info("Detected class: " + classid);
                    }
                    line = in.readLine();
                    if (line != null) {
                        log.info("Accuracy line: " + line);
                        accuracy = Float.parseFloat(line.trim());
                    }
                }
            }

            // Log errors from Python
            String errorLine;
            while ((errorLine = err.readLine()) != null) {
                log.error("PYTHON ERROR: " + errorLine);
            }

            in.close();
            err.close();

            int re = proc.waitFor();
            log.info("Python process exited with code: " + re);

            aaa(classid, accuracy, id);

        } catch (IOException | InterruptedException e) {
            log.error("Exception during script execution", e);
        }
    }

    @Transactional
    public void aaa(String classid , float acc ,String id) {
        log.info("Updating image id: " + id + " with classid=" + classid + ", accuracy=" + acc);

        img img = img_repo.getById(id);
        img.setAccuarcy(acc);
        img.setClassid(classid);
        img_repo.save(img);

        log.info("Saved image update to database.");
    }



}
