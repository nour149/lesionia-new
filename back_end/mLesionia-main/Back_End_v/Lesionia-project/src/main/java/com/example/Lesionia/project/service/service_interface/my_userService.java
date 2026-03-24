package com.example.Lesionia.project.service.service_interface;

import com.example.Lesionia.project.domain.my_user;
import com.example.Lesionia.project.domain.objet_add;
import org.json.JSONObject;

import java.util.List;
import java.util.Optional;

public interface my_userService {
    my_user savemy_user(my_user my_user);
    my_user getmy_user(String LOGINUSER);
    List<my_user> getusers();
    Boolean verif_mdp(String loginuser , String mdp);
    void change_mdp(String loginuser , String mdp);
    void change_mdp_email(String email,String mdp);
    String code_verification(String email);
    my_user get_by_email(String email);
    String register (objet_add objet_add , String USE_LOGINUSER);
    void delete(String loginuser);
    void update(objet_add objet_add);

   // my_user findByLOGINUSER();



}
