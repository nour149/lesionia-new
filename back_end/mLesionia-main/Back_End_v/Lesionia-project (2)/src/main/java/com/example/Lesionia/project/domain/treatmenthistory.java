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
public class treatmenthistory  implements Serializable {

    @Id
    @Column(length=40)
    private String IDTREATMENT;

    @Column(length = 50 , name="PATIENT_IDENTIFIER")
    private String PATIENTIDENTIFIER;

    @Column(length = 100)
    private String TREATMENT_TYPE;

    @Column(length=20)
    private String PRESCRIBEDFOR;

    @Column
    Date START_DATE;

    @Column(length = 100)
    private String POSOLOGY;

    @Column(length = 100)
    private String ADMINROUTE;

    @Column(length = 11)
    private int INJECTION_NUMBER;

    @Column(length = 20)
    private String DURATIONN;

    @Column(length=50)
    private String HEALING_DATE;

}
