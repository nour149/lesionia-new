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
public class alliquot {
    @Id
    @Column(name="ID_ALLUQUOT")
    String IDALLUQUOT;
    @Column(name="ID_SAMPLE")
    String IDSAMPLE;
    String LOGINUSER;
    Float VOLUME;
    String CONSERVATION_PLACE;
}
