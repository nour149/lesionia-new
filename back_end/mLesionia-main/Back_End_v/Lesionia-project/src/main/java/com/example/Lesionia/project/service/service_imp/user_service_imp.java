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
        authorities.add(new SimpleGrantedAuthority(u.getLevelsecure()));
        return new org.springframework.security.core.userdetails.User(u.getLOGINUSER(),u.getMOTDPASS(),authorities );
    }

    @Override
    public my_user savemy_user(my_user my_user) {
        // Get the plain password from the request body (Insomnia)
        String plainPassword = my_user.getMOTDPASS();

        // Encrypt the password
        my_user.setMOTDPASS(passwordEncoder.encode(plainPassword));

        return my_userRepo.save(my_user);
    }



    @Override
    public my_user getmy_user(String LOGINUSER)
    { return my_userRepo.findByLOGINUSER(LOGINUSER);}

    @Override
    public List<my_user> getusers()
    { return my_userRepo.findAll(); }


   // @Override
   // public Boolean verif_mdp(String loginuser , String mdp)
  //  {
      //  my_user u =my_userRepo.findByLOGINUSER(loginuser);
       // return passwordEncoder.matches(mdp,u.getMOTDPASS()) ;
  //  }

    @Override
    public Boolean verif_mdp(String loginuser, String mdp) {
        if (loginuser == null || mdp == null) {
            System.err.println("Login or password is null.");
            return false;
        }

        mdp = mdp.trim();

        my_user u = my_userRepo.findByLOGINUSER(loginuser);

        if (u == null) {
            System.err.println("User not found: " + loginuser);
            return false;
        }

        String storedHash = u.getMOTDPASS();
        if (storedHash == null || storedHash.isEmpty()) {
            System.err.println("Stored password hash is null or empty.");
            return false;
        }

        System.out.println("Verifying password for user: " + loginuser);
        System.out.println("Provided password: [" + mdp + "]");
        System.out.println("Stored hash: [" + storedHash + "]");

        try {
            boolean matches = passwordEncoder.matches(mdp, storedHash);
            System.out.println("Password match: " + matches);
            return matches;
        } catch (Exception e) {
            System.err.println("Error during password verification: " + e.getMessage());
            return false;
        }
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
    public String code_verification(String email) {
        my_user user = my_userRepo.findbyEMAIL(email);
        if (user == null) return null;

        String code = UUID.randomUUID().toString().substring(0, 6);
        user.setCodeVerification(code); // <-- enregistrer le code en DB
        my_userRepo.save(user); // <-- persister la mise à jour

        send_email.send_user_mail(email, code); // <-- envoyer par mail

        return code;
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
        int user_id = objet_add.getUserId();
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
                my_user new_user=new my_user(user_id,loginuser,USE_LOGINUSER,"",objet_add.getLevelsecure(),objet_add.getFrominst(),email,code_verification(email));
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
    //@Override
    //public void update(objet_add objet_add) {
       // String loginuser = objet_add.getLoginuser();
        //update data user
     //   my_user u =my_userRepo.findByLOGINUSER(loginuser);

     //   my_user my_user =my_userRepo.findByLOGINUSER(loginuser);
      //  my_user.setLevelsecure(objet_add.getLevelsecure());
       // my_user.setFROMINST(objet_add.getFrominst());
      //  my_userRepo.save(u);
        //update data interrogator
    //    interrogator interrogator = interrogator_repo.findByLOGINUSER(loginuser);
     //   interrogator.setFIRST_NAME_INTERROGATOR(objet_add.getFirstname());
  //      interrogator.setLAST_NAME_INTERROGATOR(objet_add.getLastname());
       // interrogator.setQUALITY(objet_add.getQuality());
     //   interrogator_repo.save(interrogator);
    //}



    @Override
    public void update(objet_add objet_add) {
        String loginuser = objet_add.getLoginuser();

        // Récupérer l'utilisateur
        my_user u = my_userRepo.findByLOGINUSER(loginuser);

        if (u == null) {
            throw new IllegalArgumentException("Utilisateur avec login '" + loginuser + "' introuvable.");
        }

        // Mettre à jour les champs nécessaires
        //u.setEmail(objet_add.getEmail());
        u.setFROMINST(objet_add.getFrominst());

        // Sauvegarder l'utilisateur mis à jour
        my_userRepo.save(u);
    }




}

