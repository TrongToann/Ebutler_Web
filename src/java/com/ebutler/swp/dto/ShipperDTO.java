/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author thekh
 */
public class ShipperDTO {
    private String username;
    private String password;
    private String name;
    private String phone;
    private String MRC;
    private int status;
    private double wallet;
    
    private double income;

    public ShipperDTO(String name, String phone) {
        this.name = name;
        this.phone = phone;
    }

    

    
    
    public ShipperDTO() {
        this.username = "";
        this.password = "";
        this.name = "";
        this.status = 0;
        this.wallet = 0;
        this.income = 0;
    }

    public ShipperDTO(String username, String password, String name, int status, double wallet) {
        this.username = username;
        this.password = password;
        this.name = name;
        this.status = status;
        this.wallet = wallet;
        this.income = 0;
    }

    public double getIncome() {
        return income;
    }

    public void setIncome(double income) {
        this.income = income;
    }

    public String getUsername() {
        return username;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public double getWallet() {
        return wallet;
    }

    public void setWallet(double wallet) {
        this.wallet = wallet;
    }

   
    
}
