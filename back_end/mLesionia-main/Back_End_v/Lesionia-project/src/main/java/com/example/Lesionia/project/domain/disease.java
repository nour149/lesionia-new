package com.example.Lesionia.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class disease {
    @Id
    @Column(name="disease_id")
    private int disease_id;
    @Column(name = "Class_ID",length = 100)
    private  String classid;
    @Column(name = "Class_Name",length = 100)
    private  String classname;

}