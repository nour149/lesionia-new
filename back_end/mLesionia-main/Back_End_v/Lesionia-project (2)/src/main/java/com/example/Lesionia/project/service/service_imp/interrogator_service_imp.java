package com.example.Lesionia.project.service.service_imp;

import com.example.Lesionia.project.domain.interrogator;
import com.example.Lesionia.project.repo.interrogator_repo;
import com.example.Lesionia.project.service.service_interface.interrogator_service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;


@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class interrogator_service_imp implements interrogator_service {

    private  final interrogator_repo interrogator_repo;

    @Override
    public interrogator get_interrogator(String LOGINUSER) {
        return interrogator_repo.findByLOGINUSER(LOGINUSER);
    }
}
