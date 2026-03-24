package com.example.Lesionia.project.service.service_imp;

import com.example.Lesionia.project.domain.discrepancy;
import com.example.Lesionia.project.repo.discrepancy_repo;
import com.example.Lesionia.project.service.service_interface.discrepancy_service;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class discrepancy_service_imp implements discrepancy_service {

    private  final discrepancy_repo discrepancy_repo;

    @Override
    public discrepancy save_disc(discrepancy discrepancy) {
        String new_id =discrepancy.getPATIENTIDENTIFIER()+'-'+0+size(discrepancy.getPATIENTIDENTIFIER());
        discrepancy.setIddiscrepancy(new_id);
        return discrepancy_repo.save(discrepancy);
    }

    @Override
    public List<discrepancy> get_all() {
        return discrepancy_repo.findAll();
    }

    @Override
    public discrepancy update_disc(discrepancy discrepancy) {
        return discrepancy_repo.save(discrepancy);
    }

    @Override
    public discrepancy get_one(String idDiscrepancy) {
        return discrepancy_repo.findByiddiscrepancy(idDiscrepancy);
    }

    @Override
    public List<discrepancy> getall_my(String PATIENTIDENTIFIER) {
        return discrepancy_repo.get_all_my(PATIENTIDENTIFIER);
    }
    public  int size(String PATIENTIDENTIFIER)
    {
        return  getall_my(PATIENTIDENTIFIER).size() +1;
    }

}
