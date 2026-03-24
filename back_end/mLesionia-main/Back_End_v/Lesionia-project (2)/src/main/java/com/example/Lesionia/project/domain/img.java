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
public class img {
    @Id
    private String id;
    @Column(name="idpatient")
    private String idpatient;
    @Column(name ="idsample")
    private String idsample;
    private String user;
    @Column(name ="DATE_MED")
    private Date DATE_MED;
    @Column(length = 100)
    private String path;

    private String classid;
    private float accuarcy;
}
