/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class CustomerDTO {

    private String username;
    private String password;
    private String role_id;
    private String phone;
    private String email;
    private String name;
    private int gender;
    private String dob;
    private String avatar;
    private double point;
    private int status;

    private ArrayList<AddressDTO> address_list = new ArrayList<AddressDTO>();

    public CustomerDTO() {
        this.username = "";
        this.password = "";
        this.role_id = "";
        this.phone = "";
        this.email = "";
        this.name = "";
        this.gender = 1;
        this.dob = "";
        this.avatar = "";
        this.point = 0.0f;
        this.status = 1;
    }

    public CustomerDTO(String username, String password, String role_id, String phone, String email, String name, int gender, String dob, String avatar, double point, int status) {
        this.username = username;
        this.password = password;
        this.role_id = role_id;
        this.phone = phone;
        this.email = email;
        this.name = name;
        this.gender = gender;
        this.dob = dob;
        this.avatar = avatar;
        this.point = point;
        this.status = status;
    }

    public CustomerDTO(String username, String password, String role_id, String phone, String email, String name, int gender, String dob, String avatar, int status) {
        this.username = username;
        this.password = password;
        this.role_id = role_id;
        this.phone = phone;
        this.email = email;
        this.name = name;
        this.gender = gender;
        this.dob = dob;
        this.avatar = avatar;
        this.point = 0.0f;
        this.status = status;
    }

    public ArrayList<AddressDTO> getAddress_list() {
        return address_list;
    }

    public void setAddress_list(ArrayList<AddressDTO> address_list) {
        this.address_list = address_list;
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

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public double getPoint() {
        return point;
    }

    public void setPoint(double point) {
        this.point = point;
    }

    public AddressDTO getAddressDefault() {
        AddressDTO address_default = null;

        for (AddressDTO address : this.getAddress_list()) {
            if (address.getStatus() == 1) {
                address_default = address;
                break;
            }
        }

        return address_default;
    }

    @Override
    public String toString() {
        return "CustomerDTO{" + "username=" + username + ", password=" + password + ", role_id=" + role_id + ", phone=" + phone + ", email=" + email + ", name=" + name + ", gender=" + gender + ", dob=" + dob + ", avatar=" + avatar + ", point=" + point + ", status=" + status + ", address_list=" + address_list + '}';
    }

}
