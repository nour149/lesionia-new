package com.example.Lesionia.project.repo;

import com.example.Lesionia.project.domain.interrogator;
import com.example.Lesionia.project.domain.my_user;
import com.example.Lesionia.project.domain.patient;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface patient_repo extends JpaRepository<patient,String> {
    patient findByPatientIdentifier(String patientIdentifier);

    @Query("select t from patient t where t.LOGINUSER = ?1 order by patientIdentifier Desc")
    List<patient> get_my_patients(String LOGINUSER);

    @Query("SELECT count(u) FROM patient u WHERE u.patientIdentifier LIKE %?1")
    int get_number(String number);

    @Query("SELECT p FROM patient p WHERE p.LOGINUSER = :LOGINUSER ORDER BY p.patientIdentifier DESC")
    Page<patient> findPatientsByLogin(@Param("LOGINUSER") String login, Pageable pageable);


    @Query("SELECT p.LOGINUSER , count(p) FROM patient p group by p.LOGINUSER ")
    List<Object[]> patient_by_user(); // <--- Changed from List<String> to List<Object[]>

    @Query("SELECT p.LOGINUSER , count(p) FROM patient p group by p.LOGINUSER ")
    List<String> get_stats_year();

    @Query("SELECT count (p) from  patient p where p.GENDER=?1")
    int male_number(String gender);

    @Query("SELECT count (p) from  patient p where p.GENDER=?1")

    int female_number(String gender);

    // @Query(value = "SELECT count(*) , age ,gender from patient group by age , gender" , nativeQuery=true)
    @Query("SELECT count(p) , p.age from patient p group by p.age")
    List get_by_age_gender();

    @Query("SELECT count(p) ,p.age from  patient p where p.GENDER=?1 group by p.age")
    List male_number_group_by_age(String gender);

    @Query("SELECT count(p) ,p.age from  patient p where p.GENDER=?1 group by p.age")

    List female_number_group_by_age(String gender);


    @Query("SELECT count(p) ,p.age from  patient p where p.GENDER=?1 group by p.age")
    List n_a_number_group_by_age(String gender);

    @Query("SELECT DISTINCT age FROM patient ORDER by age")
    List age_list();

    @Query("SELECT p FROM patient p , my_user u WHERE u.LOGINUSER=p.LOGINUSER and u.FROMINST=?1 order by patientIdentifier Desc")
    Page<patient> get_all_by_inst(String frominsit, Pageable pageable);
}
