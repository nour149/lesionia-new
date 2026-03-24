package com.example.Lesionia.project.service.service_imp;
import com.example.Lesionia.project.domain.treatmenthistory;
import com.example.Lesionia.project.repo.treatmenthistory_repo;
import com.example.Lesionia.project.service.service_interface.treatmenthistory_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class treatmenthistory_service_imp implements treatmenthistory_service {

    private final treatmenthistory_repo treatmenthistory_repo;

   // @Override
 //   public treatmenthistory save(treatmenthistory treatmenthistory) {
      //  treatmenthistory.setIDTREATMENT(treatmenthistory.getPATIENTIDENTIFIER()+'-'+0+size(treatmenthistory.getPATIENTIDENTIFIER()));
       // if(treatmenthistory.getTREATMENT_TYPE().equals("")){
      //      treatmenthistory.setTREATMENT_TYPE("N/A");
      //  }
       // return treatmenthistory_repo.save(treatmenthistory);
   // }

    @Override
    public treatmenthistory update(treatmenthistory treatmenthistory){

        // Handle null or empty TREATMENT_TYPE
        String treatmentType = treatmenthistory.getTREATMENT_TYPE();
        if (treatmentType == null || treatmentType.trim().isEmpty()) {
            treatmenthistory.setTREATMENT_TYPE("N/A");
        }
        return treatmenthistory_repo.save(treatmenthistory);
    }

    @Override
    public treatmenthistory save(treatmenthistory treatmenthistory) {
        // Ensure PATIENTIDENTIFIER is not null
        if (treatmenthistory.getPATIENTIDENTIFIER() == null) {
            throw new IllegalArgumentException("PATIENTIDENTIFIER cannot be null");
        }

        // Generate IDTREATMENT
        String patientIdentifier = treatmenthistory.getPATIENTIDENTIFIER();
        int size = size(patientIdentifier); // Ensure this method is defined and works correctly
        String idTreatment = patientIdentifier + "-" + 0 + size;
        treatmenthistory.setIDTREATMENT(idTreatment);

        // Handle null or empty TREATMENT_TYPE
        String treatmentType = treatmenthistory.getTREATMENT_TYPE();
        if (treatmentType == null || treatmentType.trim().isEmpty()) {
            treatmenthistory.setTREATMENT_TYPE("N/A");
        }

        // Save the entity
        return treatmenthistory_repo.save(treatmenthistory);
    }





public int size( String PATIENTIDENTIFIER)
{
    return  get_all(PATIENTIDENTIFIER).size() +1;}

    @Override
    public List<treatmenthistory> get_all(String PATIENTIDENTIFIER) {
        return treatmenthistory_repo.get_all(PATIENTIDENTIFIER);
    }
    @Override
    public List<treatmenthistory> get_treatments()
    { return treatmenthistory_repo.findAll(); }
    @Override
    public treatmenthistory get_one(String IDTREATMENT) {
        return treatmenthistory_repo.findByIDTREATMENT(IDTREATMENT);
    }


}
