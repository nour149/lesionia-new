package com.example.Lesionia.project.service.service_imp;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Calendar;

@Service
@Slf4j
public class public_services {

    public String get_year() {
        int year = Calendar.getInstance().getWeekYear();
        String countStr = String.valueOf(year);
        Character aa = countStr.charAt(countStr.length() - 1);
        Character aa2 = countStr.charAt(countStr.length() - 2);
        String yy = aa2.toString() + aa.toString();
        return yy;
    }
}
