package com.example.Lesionia.project.repo;

import com.example.Lesionia.project.domain.my_user;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;



public interface my_user_repo extends JpaRepository<my_user,String> {

    my_user findByLOGINUSER(String LOGINUSER);

    @Query("select t from my_user t where t.EMAIL = ?1")
    my_user findbyEMAIL(String EMAIL);
}