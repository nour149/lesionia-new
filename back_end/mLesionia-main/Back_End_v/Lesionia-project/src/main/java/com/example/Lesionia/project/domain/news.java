package com.example.Lesionia.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class news {
    @Id
    @Column(name="NEWS_IDENTIFIER ")
    private  int NEWSIDENTIFIER;
  //  @ManyToOne
  //  @JoinColumn(name="my_user",referencedColumnName = "user_id")
  //  my_user my_user;
    @Column(length = 100)
    private  String LOGINUSER;
    private  String NEWS_CONTENT;
    private Date PUBLICATION_DATE;
}
