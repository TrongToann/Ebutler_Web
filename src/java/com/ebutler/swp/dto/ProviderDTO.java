/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author Admin
 */
public class ProviderDTO {
    private String username;
    private String password;
    private String role_id;
    private String phone;
    private String email;
    private String name;
    private String logo;
    private int status;

    public ProviderDTO() {
        this.username = "";
        this.password = "";
        this.role_id = "";
        this.phone = "";
        this.email = "";
        this.name = "";
        this.status = 1;
    }

    public ProviderDTO(String username, String password, String role_id, String phone, String email, String name, String logo, int status) {
        this.username = username;
        this.password = password;
        this.role_id = role_id;
        this.phone = phone;
        this.email = email;
        this.name = name;
        this.logo = logo;
        this.status = status;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole_id() {
        return role_id;
    }

    public void setRole_id(String role_id) {
        this.role_id = role_id;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
}
