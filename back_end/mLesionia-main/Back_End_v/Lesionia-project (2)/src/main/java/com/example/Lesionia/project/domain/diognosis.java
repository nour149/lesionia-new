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
public class diognosis {

    @Id
    private String IDDIAGNOSIS;
    private String TEST;
    @Column(name = "LABORATORY_NAME")
    private String LABORATORYNAME;
    private String loginuser;
    @Column(name = "ID_SAMPLE ")
    private String IDSAMPLE;
    @Column(name = "DIAGNOSIS_DATE")
    private Date DIAGNOSISDATE;

    private float QUANTITE;

    private String RESULT;

    private String LEISHSUSPECT;


}