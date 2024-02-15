package com.example.demo.domian;

import jakarta.persistence.*;

@Entity
@Table(
        name = "users"
)
public class User {
    @Id
    @GeneratedValue(
            strategy = GenerationType.IDENTITY
    )
    private int user_no;
    @Column(
            name = "id",
            nullable = false
    )
    private String id;
    @Column(
            name = "password",
            nullable = false
    )
    private String password;
    @Column(
            name = "name",
            nullable = false,
            length = 20
    )
    private String name;
    @Column(
            name = "age",
            nullable = false
    )
    private int age;
    @Column(
            name = "address",
            nullable = false,
            length = 100
    )
    private String address;
    @Column(
            name = "phone",
            nullable = false,
            length = 13
    )
    private String phone;


    public int getUser_no() {
        return this.user_no;
    }

    public String getId() {
        return this.id;
    }

    public String getPassword() {
        return this.password;
    }

    public String getName() {
        return this.name;
    }

    public int getAge() {
        return this.age;
    }

    public String getAddress() {
        return this.address;
    }

    public String getPhone() {
        return this.phone;
    }

    public void setUser_no(int user_no) {
        this.user_no = user_no;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

}
