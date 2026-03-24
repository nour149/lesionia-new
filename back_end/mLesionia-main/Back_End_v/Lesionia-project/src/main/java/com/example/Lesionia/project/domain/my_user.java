package com.example.Lesionia.project.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;

import static javax.persistence.FetchType.EAGER;
import static javax.persistence.GenerationType.AUTO;

@Entity
@Table(name ="userdata")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class my_user implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int user_id;
    @Column(length = 100,unique = true)
    @JsonProperty("LOGINUSER")
    private String LOGINUSER;
    @JsonProperty("USE_LOGINUSER")
    private String USE_LOGINUSER;
    private String MOTDPASS;
    @JsonProperty("LEVELSECURE")
    private String LEVELSECURE;
    @JsonProperty("FROMINST")
    private String FROMINST;
    @Column(nullable = false, unique = true)
    @JsonProperty("EMAIL")
    private String EMAIL;
    @Setter
    @Getter
    private String codeVerification;


    @JsonProperty("MOTDPASS")
    public String getMOTDPASS() {
        return MOTDPASS;
    }

    @JsonProperty("MOTDPASS")
    public void setMOTDPASS(String MOTDPASS) {
        this.MOTDPASS = MOTDPASS;
    }

    // Other fields and methods

    // Getters and setters
 //   public String getLoginuser() {
     //   return LOGINUSER;
    //}

  //  public void setLoginuser(String loginuser) {
    //    this.LOGINUSER = loginuser;
  //  }

    //public String getMotdpass() {
   //     return MOTDPASS;
    //}

  //  public void setMotdpass(String motdpass) {
      //  this.MOTDPASS = motdpass;
   // }




    public String getLevelsecure() {
      return LEVELSECURE;
  }

    public void setLevelsecure(String levelsecure) {
        this.LEVELSECURE = levelsecure;
    }

}
