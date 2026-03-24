package com.example.Lesionia.project.service.service_imp;


import com.example.Lesionia.project.domain.sample;
import com.example.Lesionia.project.repo.sample_repo;
import com.example.Lesionia.project.service.service_interface.sample_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class sample_service_imp implements sample_service {

    private final sample_repo sample_repo;

    @Autowired
    private final public_services public_services;

    @Override
    public List<sample> getall() {
        return sample_repo.findAll();
    }

    @Override
    public sample get_one(String IDSAMPLE) {
        return sample_repo.findByIDSAMPLE(IDSAMPLE);
    }

    @Override
    public String save(sample sample) {
        String new_id=sample.getPATIENTIDENTIFIER()+'-'+0+size(sample.getPATIENTIDENTIFIER());
        sample.setIDSAMPLE(new_id);

        //if(sample.getDESCRIPTION().equals("")){
        //    sample.setDESCRIPTION("N/A") ;
       // }
        if(sample.getDESCRIPTION() == null || sample.getDESCRIPTION().equals(""))
        {
            sample.setDESCRIPTION("N/A");
        }
      //  if(sample.getTYPE_OF_SAMPLE_SUPPORT_().equals("") || sample.getTYPE_OF_SAMPLE_SUPPORT_() == null ){
        if(sample.getTYPE_OF_SAMPLE_SUPPORT_() == null || sample.getTYPE_OF_SAMPLE_SUPPORT_().equals(""))
        {

            sample.setTYPE_OF_SAMPLE_SUPPORT_("N/A");
        }

       // if(sample.getSAMPLING_METHOD().equals("")){
        if(sample.getSAMPLING_METHOD() == null || sample.getSAMPLING_METHOD().equals(""))
        {
            sample.setSAMPLING_METHOD("N/A");
        }
        sample_repo.save(sample);
        return new_id;    }

    public  int size(String PATIENTIDENTIFIER)
    {
      return  getall_my(PATIENTIDENTIFIER).size() +1;
    }

    @Override
    public List<sample> getall_my(String PATIENTIDENTIFIER) {
        return sample_repo.get_all_my(PATIENTIDENTIFIER);
    }
    @Override
    public sample update(sample sample){
        if(sample.getDESCRIPTION().equals("")){
            sample.setDESCRIPTION("N/A");
        }
        if(sample.getTYPE_OF_SAMPLE_SUPPORT_().equals("")){
            sample.setTYPE_OF_SAMPLE_SUPPORT_("N/A");
        }
        if(sample.getSAMPLING_METHOD().equals("")){
            sample.setSAMPLING_METHOD("N/A");
        }
        return sample_repo.save(sample);
    }
    @Override
    public List<String> get_all_id(String PATIENTIDENTIFIER) {
        return sample_repo.get_all_id(PATIENTIDENTIFIER);
    }
    @Override
    public  int get_allsamples(String LOGINUSER){
        return sample_repo.get_allsamples(LOGINUSER);
    }
}
