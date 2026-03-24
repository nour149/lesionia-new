package com.example.Lesionia.project.domain;
import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class treatmenthistory  implements Serializable {

    @Id
    @Column(length=40)
    @NotNull
    private String IDTREATMENT;



   // @ManyToOne
   // @JoinColumn(name="PATIENT_IDENTIFIER",referencedColumnName = "PATIENT_IDENTIFIER")
   //patient patient;

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
    @Column(name = "PATIENT_IDENTIFIER",nullable = true)
    private String PATIENTIDENTIFIER ;

   // public String getPATIENTIDENTIFIER() {
        //return
     //   return "";
    //}


    // public String getPATIENTIDENTIFIER() {
      //  return patient.toString();
   // }
}
