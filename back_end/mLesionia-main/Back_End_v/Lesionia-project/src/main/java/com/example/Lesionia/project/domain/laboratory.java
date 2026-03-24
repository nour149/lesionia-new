package com.example.Lesionia.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class laboratory {

    @Id
    private int laboratory_id;
    @Column(length = 20 , name = "LABORATORY_NAME")
    private String LABORATORYNAME;
   // @ManyToOne
//@JoinColumn(name="my_user",referencedColumnName = "user_id")
  //  my_user user;

    private String LOGINUSER;
   // @ManyToOne
//@JoinColumn(name = "LOGINUSER", referencedColumnName = "LOGINUSER") // FK sur la colonne LOGINUSER
   // private my_user my_user;
    @Column(length =20)
    private String COUNTRY;

}