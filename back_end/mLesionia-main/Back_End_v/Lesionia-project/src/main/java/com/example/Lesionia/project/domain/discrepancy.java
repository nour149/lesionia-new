package com.example.Lesionia.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class discrepancy {

    @Id
    @Column(name="iddiscrepancy" )
    private String iddiscrepancy;
    @Column(length=50 , name ="PATIENT_IDENTIFIER")
    private String PATIENTIDENTIFIER;

    @Column(name="DATE_MED")
    private Date DATEMED;

    @Column
    private  String Description;

    @Column(length = 50)
    private String user;

    @Column(name="date_disc")
    private Date date_disc ;
}