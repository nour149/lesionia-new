package com.example.Lesionia.project.security;

import com.example.Lesionia.project.filter.CustmorAuthorizatonfilter;
import com.example.Lesionia.project.filter.CustomerAuthentificationFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import static org.springframework.http.HttpMethod.*;
import static org.springframework.http.HttpMethod.POST;
import static org.springframework.security.config.http.SessionCreationPolicy.STATELESS;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class security_config extends WebSecurityConfigurerAdapter {
    private final UserDetailsService userDetailsService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    // Create BCryptPasswordEncoder Bean
    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(bCryptPasswordEncoder);

    }
   @Override
   protected void configure(HttpSecurity http) throws Exception {
        CustomerAuthentificationFilter customerAuthentificationFilter = new CustomerAuthentificationFilter(authenticationManagerBean());
      customerAuthentificationFilter.setFilterProcessesUrl("/api/login");
        http.cors().and().csrf().disable();
        /* http.cors().configurationSource(corsConfigurationSource());*/
       http.sessionManagement().sessionCreationPolicy(STATELESS);
        http.authorizeRequests().antMatchers("/api/login/**").permitAll();
      http.authorizeHttpRequests().antMatchers("/free/**").permitAll();
       http.authorizeHttpRequests().antMatchers(GET, "/api/**").permitAll();
        http.authorizeHttpRequests().antMatchers(DELETE, "/api/**").permitAll();
        http.authorizeHttpRequests().antMatchers(PUT, "/api/**").permitAll();
       http.authorizeHttpRequests().antMatchers(POST, "/api/**").permitAll();
      // http.authorizeHttpRequests().antMatchers(PUT, "/api/molecularl_test/update").permitAll();
       http.authorizeHttpRequests().anyRequest().authenticated();
        http.addFilter(customerAuthentificationFilter);
      http.addFilterBefore(new CustmorAuthorizatonfilter(), UsernamePasswordAuthenticationFilter.class);
    //    Permit access to /api/user/save without authentication
        http.authorizeRequests().antMatchers("/api/user/save").permitAll();
        /* new added 18/03/2025 */
      // http.authorizeRequests()
           //    .antMatchers("/Getimage").permitAll()
             //  .anyRequest().authenticated();
    }




    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }
}