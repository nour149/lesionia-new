package com.example.Lesionia.project.domain;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.io.Serializable;
import java.sql.Date;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class travel_residency  {

    @Id
    @Column(length=20)
    private String 	IDMVT ;

    @Column(length = 100)
    private String 	CITY;

    @Column(length = 100)
    private String LOGINUSER ;

    @Column(length=50 , name ="PATIENT_IDENTIFIER")
    private String PATIENTIDENTIFIER;

    @Column
    private Date FROMDATE ;

    @Column
    private float TODATE;

    @Column
    private String BYTENOT;

    @Column
    private String RESIDENCY;

    @Column
    private String TYPE;
}
