package com.example.Lesionia.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;


@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class interrogator {
    @Id
    @Column(length = 20)
    private String ID_INTERROGATOR;
   // @ManyToOne
    //@JoinColumn(name="my_user",referencedColumnName = "user_id")
  //  my_user my_user;
    @Column(length = 100)
    private String LOGINUSER;
    @Column(length = 50)
    private String  FIRST_NAME_INTERROGATOR;
    @Column(length = 20)
    private String LAST_NAME_INTERROGATOR;
    @Column(length = 20)
    private String QUALITY;

}
