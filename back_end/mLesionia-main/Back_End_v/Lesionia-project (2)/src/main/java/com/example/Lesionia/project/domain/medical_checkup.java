package com.example.Lesionia.project.domain;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class medical_checkup implements Serializable {

    @Id
    @Column(length = 20 ,name ="ID_MED")
    private String IDMED;

    private Date DATE_MED;

    @Column(length = 20)
    private String ID_INTERROGATOR;

    @Column(length = 50 , name ="PATIENT_IDENTIFIER")
    private String PATIENTIDENTIFIER;

    @Column(length = 100)
    private String LOGINUSER;

    @Column(length = 50)
    private String HOSPITAL;

    @Column(length = 50)
    private String PHYSICIAN;

    @Column(length = 50)
    private String SAMPLER;

    @Column(length = 200)
    private String ANIMAL_AROUND;

    @Column(length = 200)
    private String POSSIBLE_HUMAN_HOSTS;

    @Column(length = 200)
    private String LINK_HUMAN_HOSTS;

    @Column
    private String CLINICAL_STATE;

    @Column(length = 3)
    private int LESNUM;

    @Column(length = 200)
    private String LESPOSSS;

    @Column(length = 200)
    private String  GENDESC;




}
