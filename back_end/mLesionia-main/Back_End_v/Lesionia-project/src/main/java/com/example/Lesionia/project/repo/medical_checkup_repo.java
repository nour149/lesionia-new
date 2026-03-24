package com.example.Lesionia.project.repo;

import com.example.Lesionia.project.domain.medical_checkup;
import com.example.Lesionia.project.domain.patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.sql.Date;
import java.util.List;

public interface medical_checkup_repo extends JpaRepository<medical_checkup,String>{

    medical_checkup findByIDMED(String IDMED);

    @Query("select t from medical_checkup t where t.PATIENTIDENTIFIER = ?1  order by t.DATE_MED DESC")
    List<medical_checkup> get_my_medical_checkups(String PATIENTIDENTIFIER);

    @Query("select DISTINCT m.DATE_MED from medical_checkup m where m.PATIENTIDENTIFIER = ?1 ")
    List<String> get_all_date(String PATIENTIDENTIFIER);

    @Query(value="SELECT DATE_MED, COUNT(*)  from medical_checkup WHERE(( loginuser = ?1) and ( DATE_MED >CURRENT_DATE -010000) ) group BY DATE_MED ORDER by DATE_MED DESC" , nativeQuery = true)
    List get_chekup_date(String loginuser);


    //Test with  < CURRENT_DATE __>> Display all dates for a loginuser.
  //  @Query(value="SELECT DATE_MED, COUNT(*)  from medical_checkup WHERE(( loginuser = ?1) and ( DATE_MED >CURRENT_DATE -010000) ) group BY DATE_MED ORDER by DATE_MED DESC" , nativeQuery = true)
  //  List get_chekup_date(String loginuser);
//
    @Query(value ="SELECT COUNT(*) FROM medical_checkup WHERE loginuser = ?1",nativeQuery = true)
    int get_allchecks(String loginuser);
}
