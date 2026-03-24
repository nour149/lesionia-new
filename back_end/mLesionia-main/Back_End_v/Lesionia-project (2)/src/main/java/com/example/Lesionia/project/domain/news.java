package com.example.Lesionia.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.sql.Date;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class news {
    @Id
    @Column(name="NEWS_IDENTIFIER ")
    private  int NEWSIDENTIFIER;
    @Column(length = 100)
    private  String LOGINUSER;
    private  String NEWS_CONTENT;
    private Date PUBLICATION_DATE;
}
