package com.example.demo.controller;

import com.example.demo.domian.HealthCheck;
import com.example.demo.domian.Vaccine;
import com.example.demo.service.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/")
@CrossOrigin(origins = "http://localhost:8081")
public class registercontroller {

    @Autowired
    private RegisterService registerService;

    @PostMapping("/vaccine")
    public ResponseEntity<String> vaccineRegister(@RequestBody Vaccine vaccine) {
        Vaccine registeredVaccine = registerService.vaccineRegister(vaccine);
        if (registeredVaccine != null) {
            return ResponseEntity.ok("신청이 완료되었습니다.");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("신청이 실패하였습니다.");
        }
    }

    @PostMapping("/health-check")
    public ResponseEntity<String> healthCheckRegister(@RequestBody HealthCheck healthCheck) {
        HealthCheck registeredHealthCheck = registerService.healthCheckRegister(healthCheck);
        if (registeredHealthCheck != null) {
            return ResponseEntity.ok("신청이 완료되었습니다.");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("신청이 실패하였습니다.");
        }
    }
}
