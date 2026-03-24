package com.example.Lesionia.project.service.service_imp;

import com.example.Lesionia.project.domain.travel_residency;
import com.example.Lesionia.project.repo.travel_residency_repo;
import com.example.Lesionia.project.service.service_interface.travel_residency_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class travel_residency_service_imp implements travel_residency_service {

    private  final travel_residency_repo travel_residency_repo;

    @Override
    public travel_residency save(travel_residency travel_residency) {
        travel_residency.setIDMVT(travel_residency.getPATIENTIDENTIFIER()+'-'+0+size(travel_residency.getPATIENTIDENTIFIER()));
        return travel_residency_repo.save(travel_residency);
    }

    public int size(String PATIENTIDENTIFIER)
    {
        return get_all(PATIENTIDENTIFIER).size()+1;
    }

    @Override
    public travel_residency get_one(String IDMVT) {
        return travel_residency_repo.findByIDMVT(IDMVT);
    }

    @Override
    public List<travel_residency> get_all(String PATIENTIDENTIFIER) {
        return  travel_residency_repo.get_all(PATIENTIDENTIFIER);
    }
    @Override
    public List<travel_residency> get_travels()
    { return travel_residency_repo.findAll(); }
    @Override
    public travel_residency update_tr(travel_residency travel_residency) {
        return travel_residency_repo.save(travel_residency);
    }
    @Override
    public int get_alltravelsbyid(String LOGINUSER){
        return travel_residency_repo.get_alltravelsbyid(LOGINUSER);
    }
}
