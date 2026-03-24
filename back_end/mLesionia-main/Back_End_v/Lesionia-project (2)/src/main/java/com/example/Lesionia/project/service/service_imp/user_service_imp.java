package com.example.Lesionia.project.service.service_imp;

import com.example.Lesionia.project.domain.interrogator;
import com.example.Lesionia.project.domain.my_user;
import com.example.Lesionia.project.domain.objet_add;
import com.example.Lesionia.project.repo.interrogator_repo;
import com.example.Lesionia.project.repo.my_user_repo;
import com.example.Lesionia.project.service.service_email.send_email;
import com.example.Lesionia.project.service.service_interface.my_userService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.*;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class user_service_imp  implements my_userService, UserDetailsService {
    private final interrogator_repo interrogator_repo;
    private final my_user_repo my_userRepo;
    private final PasswordEncoder passwordEncoder;
    private final send_email send_email;

    @Override
    public UserDetails loadUserByUsername(String LOGINUSER) throws UsernameNotFoundException {
        my_user u=  my_userRepo.findByLOGINUSER(LOGINUSER);
        if (u== null)
        {  log.error("user not found in the database");
            throw new UsernameNotFoundException("user not found in the database");
        }
        else
        {log.info("user  found in the database"); }
        Collection<SimpleGrantedAuthority> authorities  =new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority(u.getLEVELSECURE()));
        return new org.springframework.security.core.userdetails.User(u.getLOGINUSER(),u.getMOTDPASS(),authorities );
    }

    @Override
    public my_user savemy_user(my_user my_user) {
        String mdp = (UUID.randomUUID().toString().substring(0,6));
        my_user.setMOTDPASS(passwordEncoder.encode(mdp));
        return my_userRepo.save(my_user);
    }


    @Override
    public my_user getmy_user(String LOGINUSER)
    { return my_userRepo.findByLOGINUSER(LOGINUSER);}

    @Override
    public List<my_user> getusers()
    { return my_userRepo.findAll(); }


    @Override
    public Boolean verif_mdp(String loginuser , String mdp)
    {
        my_user u =my_userRepo.findByLOGINUSER(loginuser);
        return passwordEncoder.matches(mdp,u.getMOTDPASS()) ;
    }

    @Override
    public void change_mdp(String loginuser, String mdp)
    {
        my_user u = my_userRepo.findByLOGINUSER(loginuser);
        u.setMOTDPASS(passwordEncoder.encode(mdp));
    }

    @Override
    public void change_mdp_email(String email, String mdp)
    {
        my_user u = my_userRepo.findbyEMAIL(email);
        u.setMOTDPASS(passwordEncoder.encode(mdp));
    }


    @Override
    public String code_verification(String email)
    {
        String code= UUID.randomUUID().toString().substring(0,6);
        send_email.send_user_mail(email,code);
        return  code;
    }

    @Override
    public my_user get_by_email(String email) {
        return my_userRepo.findbyEMAIL(email);
    }

    public my_user save_my_user(my_user my_user) {
        String mdp = (UUID.randomUUID().toString().substring(0,6));
        my_user.setMOTDPASS(passwordEncoder.encode(mdp));
        send_email.send_register_mail(my_user.getEMAIL(),mdp,my_user.getLOGINUSER());
        return my_userRepo.save(my_user);
    }

    @Override
    public String register(objet_add objet_add , String USE_LOGINUSER) {

        String loginuser = objet_add.getLoginuser();
        String email = objet_add.getEmail();
        my_user u =my_userRepo.findByLOGINUSER(loginuser);
        String result="";
        if ( u !=null)
        {  result ="loginuser existe";log.info(u.toString());
        }
        else
        {
            my_user u2=my_userRepo.findbyEMAIL(email);
            if ( u2!= null)
            { result ="email existe"; log.info(u2.toString());}
            else
            {
                my_user new_user=new my_user(loginuser,USE_LOGINUSER,"",objet_add.getLevelsecure(),objet_add.getFrominst(),email);
                log.info(new_user.toString());
                my_user saved_user =save_my_user(new_user);
                log.info(saved_user.toString());
                String id_inter =Integer.toString(interrogator_repo.findAll().size()+1);
                interrogator interrogator = new interrogator(id_inter,loginuser,objet_add.getFirstname(),objet_add.getLastname(),objet_add.getQuality());
                log.info(interrogator.toString());
                interrogator_repo.save(interrogator);
                result ="user saved successfully";
            }
        }

        return result;
    }
    @Override
    public void delete(String loginuser)
    {
        my_user my_user = my_userRepo.findByLOGINUSER(loginuser);
        interrogator interrogator = interrogator_repo.findByLOGINUSER(loginuser);
        interrogator_repo.delete(interrogator);
        my_userRepo.delete(my_user);
    }
    @Override
    public void update(objet_add objet_add) {
        String loginuser =objet_add.getLoginuser();
        //update data user
        my_user my_user =my_userRepo.findByLOGINUSER(loginuser);
        my_user.setLEVELSECURE(objet_add.getLevelsecure());
        my_user.setFROMINST(objet_add.getFrominst());
        my_userRepo.save(my_user);
        //update data interrogator
        interrogator interrogator = interrogator_repo.findByLOGINUSER(loginuser);
        interrogator.setFIRST_NAME_INTERROGATOR(objet_add.getFirstname());
        interrogator.setLAST_NAME_INTERROGATOR(objet_add.getLastname());
        interrogator.setQUALITY(objet_add.getQuality());
        interrogator_repo.save(interrogator);
    }


}

