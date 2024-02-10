package com.example.demo.service;


import com.example.demo.domian.User;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class LoginService {

    @Autowired
    private UserRepository userRepository;

    public boolean login(User user) {
        User findUser = this.userRepository.findById(user.getId());
        if (findUser == null) {
            return false;
        } else {
            return findUser.getPassword().equals(user.getPassword());
        }
    }

}
