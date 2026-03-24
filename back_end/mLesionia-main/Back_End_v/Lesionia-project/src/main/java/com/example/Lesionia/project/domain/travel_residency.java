package com.example.Lesionia.project.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date; // java.sql.Date is already a reference type (nullable)

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class travel_residency  {
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "org.hibernate.id.UUIDGenerator")
    @Column(name = "IDMVT", length = 50, nullable = false, unique = true)
    @Id
    @JsonProperty("IDMVT")
    private String IDMVT;


    @Column(name = "CITY", nullable = false)
    private String CITY;

    @Column(length = 100)
    private String LOGINUSER ;

    @Column
    private Date FROMDATE ; // OK: java.sql.Date is an Object and can be null

    // *** CRITICAL CHANGE: Use Float wrapper for null support ***
    @Column
    private Float TODATE;

    @Column
    private String BYTENOT; // OK: String is an Object and can be null

    @Column
    private String RESIDENCY; // OK: String is an Object and can be null

    @Column
    private String TYPE; // OK: String is an Object and can be null

    @Column(name = "PATIENTIDENTIFIER", nullable = true)
    private String PATIENTIDENTIFIER ; // OK: String is an Object and can be null

}