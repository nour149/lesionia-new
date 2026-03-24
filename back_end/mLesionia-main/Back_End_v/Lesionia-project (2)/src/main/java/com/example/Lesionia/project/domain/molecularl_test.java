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
public class molecularl_test {

    @Id
    @Column(length = 20)
    private String TEST;
    @Column(length = 100)
    private String LOGINUSER;
    @Column (length = 20)
    private String TEST_TYPE;
}
