package com.example.demo.service;


import com.example.demo.domian.HealthCheck;
import com.example.demo.domian.Vaccine;
import com.example.demo.repository.HealthCheckRepository;
import com.example.demo.repository.VaccineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RegisterService {

    @Autowired
    private VaccineRepository vaccineRepository;

    @Autowired
    private HealthCheckRepository healthCheckRepository;

    public Vaccine vaccineRegister(Vaccine vaccine) {
        try {
            return vaccineRepository.save(vaccine);
        } catch (Exception e) {
            e.printStackTrace();
            // 원하는 형태로 예외 처리
            throw new RuntimeException("Failed to register vaccine.", e);
        }
    }

    public HealthCheck healthCheckRegister(HealthCheck healthCheck){
        return healthCheckRepository.save(healthCheck);
    }
}
