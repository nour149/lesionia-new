package com.example.Lesionia.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.sql.Date;


@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class patient {
    @Id
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "org.hibernate.id.UUIDGenerator")
    @Column(name = "patient_identifier", length = 50, nullable = false, unique = true)
    private String patientIdentifier;

  //  @ManyToOne
  //  @JoinColumn(name="my_user",referencedColumnName = "user_id")
   // my_user my_user;

    @Column(length=100)
    private String LOGINUSER;

    @Column(length =50)
    private String MEDICAL_FILE_NUMBER;

    @Column(length=20)
    private String FIRST_NAME;

    @Column(length = 20)
    private String LAST_NAME;

    @Column
    private Date BIRTH_DATE;

    @Column
    private int age ;

    @Column(length = 6)
    private String NATIONALITY;

    @Column (length = 10)
    private String GENDER;

    @Column(length = 3)
    private String CONSENT;

    @Column (length = 15)
    private String PHONE_NUMBER;


}
