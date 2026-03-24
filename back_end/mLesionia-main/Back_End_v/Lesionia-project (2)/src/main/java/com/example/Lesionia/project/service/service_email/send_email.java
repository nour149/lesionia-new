package com.example.Lesionia.project.service.service_email;



import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
@Service
@Slf4j
public class send_email {
    public void send_user_mail(String email,String sujet) {
        log.info("sending email...");
        Properties props = new Properties();
        props.put("mail.smtp.starttls.enable","true");
        String host = "smtp.gmail.com";
        int port = 587;
        String userName = "forum.systeme.service@gmail.com";
        String password = "hxprtkggwsgsqdfh";

        String mailTo = email;
        String subject = "lesiona Notification";

        JavaMailSenderImpl sender = new JavaMailSenderImpl();
        sender.setJavaMailProperties(props);
        sender.setHost(host);
        sender.setPort(port);
        sender.setUsername(userName);
        sender.setPassword(password);

        MimeMessage message = sender.createMimeMessage();
        MimeMessageHelper helper;
        try
        {
            helper = new MimeMessageHelper(message, true);
            helper.setTo(mailTo);
            helper.setSubject(subject);
            helper.setText("<i>hello </i> ,<br> <h2> this is your verification code :  "+sujet+"</h2>", true);
        } catch(
                MessagingException e)

        {
            throw new RuntimeException(e);
        }

        sender.send(message);
    }

    public void send_register_mail(String email,String sujet ,String loginuser) {
        Properties props = new Properties();
        props.put("mail.smtp.starttls.enable","true");
        String host = "smtp.gmail.com";
        int port = 587;
        String userName = "forum.systeme.service@gmail.com";
        String password = "hxprtkggwsgsqdfh";

        String mailTo = email;
        String subject = "lesiona Notification";

        JavaMailSenderImpl sender = new JavaMailSenderImpl();
        sender.setJavaMailProperties(props);
        sender.setHost(host);
        sender.setPort(port);
        sender.setUsername(userName);
        sender.setPassword(password);

        MimeMessage message = sender.createMimeMessage();
        MimeMessageHelper helper;
        try
        {
            helper = new MimeMessageHelper(message, true);
            helper.setTo(mailTo);
            helper.setSubject(subject);
            helper.setText("<i>hello </i> ,<br> <h2> this your username for lesionia account:  "+loginuser+"</h2>"+
                    "<br> <h2> this your password for lesionia account:  "+sujet+"</h2>", true);
        } catch(
                MessagingException e)

        {
            throw new RuntimeException(e);
        }

        sender.send(message);
    }

}