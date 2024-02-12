package com.example.demo.controller;


import com.example.demo.domian.HealthCheck;
import com.example.demo.domian.Vaccine;
import com.example.demo.domian.User;
import com.example.demo.service.JoinService;
import com.example.demo.service.LoginService;
import com.example.demo.service.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/login")
@CrossOrigin(origins = "http://localhost:8081")
public class indexcontroller {

    @Autowired
    private LoginService loginService;

    @Autowired
    private JoinService joinService;

    @Autowired
    private RegisterService registerService;

    @PostMapping("/login")
    public ResponseEntity<String> authenticateUser(@RequestBody User user) {
        boolean isAuthenticated = loginService.login(user);

        if (isAuthenticated) {
            return ResponseEntity.ok("Login successful!");
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
        }
    }

    @PostMapping("/join")
    public User addUser (@RequestBody User user){
        return joinService.addUser(user);
    }


}

