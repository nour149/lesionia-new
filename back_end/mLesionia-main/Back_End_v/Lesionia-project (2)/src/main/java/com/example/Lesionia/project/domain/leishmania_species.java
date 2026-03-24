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
public class leishmania_species {
    @Id
    @Column(length = 100)
    private  String SPECIES;
    @Column(length = 100)
    private  String INFORMATION;
}
