package com.example.Lesionia.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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
    @Column(length = 100)
    private String LOGINUSER;
    private String USE_LOGINUSER;
    private String MOTDPASS;
    private String LEVELSECURE;
    private String FROMINST;
    private String EMAIL;


}
