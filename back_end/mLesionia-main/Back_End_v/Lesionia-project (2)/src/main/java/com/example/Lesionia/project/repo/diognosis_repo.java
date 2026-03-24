package com.example.Lesionia.project.repo;

import com.example.Lesionia.project.domain.diognosis;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface diognosis_repo extends JpaRepository<diognosis,String> {

    diognosis findByIDDIAGNOSIS(String IDDIAGNOSIS);

    @Query("select d from diognosis d where d.IDSAMPLE = ?1")
    List<diognosis> all_by_sample(String IDSAMPLE);

    @Query("select count(d) , d.LABORATORYNAME from diognosis d group by d.LABORATORYNAME")
    List get_by_lab_name();

    @Query("select count(d) , d.LEISHSUSPECT from diognosis d group by d.LEISHSUSPECT")
    List get_by_species();

    @Query("select count(d) , d.TEST from diognosis d group by d.TEST")
    List get_by_TEST();
}