package com.example.Lesionia.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class molecularl_test {

    @Id
    private int Test_id;

    @Column(length = 20)
    private String TEST;



    @Column(length=20)
    private String LOGINUSER;

    @Column (length = 20)
    private String TEST_TYPE;

  //  @ManyToOne
  //  @JoinColumn(name="my_user",referencedColumnName = "user_id")
   // my_user my_user;
}
