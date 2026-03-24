package com.example.Lesionia.project.service.service_imp;

import com.example.Lesionia.project.domain.medical_checkup;
import com.example.Lesionia.project.repo.medical_checkup_repo;
import com.example.Lesionia.project.service.service_interface.medical_checkup_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class medical_checkup_service_imp implements medical_checkup_service {


    private final medical_checkup_repo medical_checkup_repo;

    @Override
    public medical_checkup save_medical_checkup(medical_checkup medical_checkup) {
         medical_checkup.setIDMED(medical_checkup.getPATIENTIDENTIFIER()+'-'+0+size(medical_checkup.getPATIENTIDENTIFIER()));
        if(medical_checkup.getANIMAL_AROUND().equals("")){
            medical_checkup.setANIMAL_AROUND("N/A");
        }
        if(medical_checkup.getCLINICAL_STATE().equals("")){
            medical_checkup.setCLINICAL_STATE("N/A");
        }
        if(medical_checkup.getLESPOSSS().equals("")){
            medical_checkup.setLESPOSSS("N/A");
        }
        if(medical_checkup.getLINK_HUMAN_HOSTS().equals("")){
            medical_checkup.setLINK_HUMAN_HOSTS("N/A");
        }
        if(medical_checkup.getPOSSIBLE_HUMAN_HOSTS().equals("")){
            medical_checkup.setPOSSIBLE_HUMAN_HOSTS("N/A");
        }
         return medical_checkup_repo.save(medical_checkup);
    }

   public int size(String PATIENTIDENTIFIER)
   { return get_medical_checkup(PATIENTIDENTIFIER).size() +1;}


    @Override
    public medical_checkup get_one_medical_checkup(String IDMED) {
        return medical_checkup_repo.findByIDMED(IDMED);
    }

    @Override
    public List<medical_checkup> get_checkups()
    { return medical_checkup_repo.findAll(); }

    @Override
    public List<medical_checkup> get_medical_checkup(String PATIENTIDENTIFIER) {
        return medical_checkup_repo.get_my_medical_checkups(PATIENTIDENTIFIER);
    }
    @Override
    public List<String> get_all_date(String PATIENTIDENTIFIER) {
        return medical_checkup_repo.get_all_date(PATIENTIDENTIFIER);
    }
@Override
    public medical_checkup update_medical_checkup(medical_checkup medical_checkup){
    if(medical_checkup.getANIMAL_AROUND().equals("")){
        medical_checkup.setANIMAL_AROUND("N/A");
    }
    if(medical_checkup.getCLINICAL_STATE().equals("")){
        medical_checkup.setCLINICAL_STATE("N/A");
    }
    if(medical_checkup.getLESPOSSS().equals("")){
        medical_checkup.setLESPOSSS("N/A");
    }
    if(medical_checkup.getLINK_HUMAN_HOSTS().equals("")){
        medical_checkup.setLINK_HUMAN_HOSTS("N/A");
    }
    if(medical_checkup.getPOSSIBLE_HUMAN_HOSTS().equals("")){
        medical_checkup.setPOSSIBLE_HUMAN_HOSTS("N/A");
    }
        return medical_checkup_repo.save(medical_checkup);
}
    @Override
    public List checkup_date(String loginuser) {
        return medical_checkup_repo.get_chekup_date(loginuser);
    }
    @Override
    public   int get_allchecks(String loginuser){
        return medical_checkup_repo.get_allchecks(loginuser);
    }
}
