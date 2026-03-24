package com.example.Lesionia.project.domain;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Date;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class sample {

    @Id
    @Column(length = 50 , name="ID_SAMPLE")
    private String IDSAMPLE;

    @Column(length=50 , name ="PATIENT_IDENTIFIER")
    private String PATIENTIDENTIFIER;

    @Column(length = 100)
    private String SPECIES;

    @Column(length = 100)
    private String LOGINUSER;

    @Column(length = 50)
    private String LESION_SITE_SAMPLED;

    @Column(length = 30)
    private String SAMPLING_METHOD;

    @Column(length = 30)
    private String TYPE_OF_SAMPLE_SUPPORT_;

    @Column(length = 20)
    private String DIRECT_EXAMINATION;

    @Column(length = 6)
    private String ABUDANCE_ON_THE_SMEAR;

    @Column
    private Date Date_First_Apeard;

    @Column
    private int Lesion_Age;

    @Column
    private int DIAMETREMax;

    @Column
    private int DIAMETREMin;

    @Column int HIGHT;

    @Column(length = 20)
    private String LOCALISATION;

    @Column
    private String DESCRIPTION;

    @Column
    private Date DATE_EXTRACTION;
}
