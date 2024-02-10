package com.example.demo.controller;


import com.example.demo.domian.User;
import com.example.demo.service.JoinService;
import com.example.demo.service.LoginService;
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

    @PostMapping("/login")
    public ResponseEntity<String> authenticateUser(@RequestBody User user) {
        boolean isAuthenticated = loginService.login(user);

        if (isAuthenticated) {
            return ResponseEntity.ok("Login successful!");
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
        }
    }

        @PostMapping("/register")
        @CrossOrigin(origins = "http://localhost:8081")
        public User addUser (@RequestBody User user){
            System.out.println("InsertDB");
            return joinService.addUser(user);
        }
    }

