package com.example.Lesionia.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class alliquot {
    @GeneratedValue(strategy = GenerationType.IDENTITY) // ou AUTO, SEQUENCE selon la DB
    @Id
    @Column(name="ID_ALLUQUOT")
    String IDALLUQUOT;
    @Column(name="ID_SAMPLE")
    String IDSAMPLE;
    String LOGINUSER;
    Float VOLUME;
    String CONSERVATION_PLACE;
}
