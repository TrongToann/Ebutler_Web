/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author thekh
 */
public class ServiceCartDTO {
    private int id;
    private String providerName;
    private String serviceName;
    private String staffName;
    private double price;
    private String avatar;
    private String description;
    private int status;

    public ServiceCartDTO() {
        this.id = 0;
        this.providerName = "";
        this.serviceName = "";
        this.staffName = "";
        this.price = 0;
        this.avatar = "";
        this.description = "";
        this.status = 0;
    }

    public ServiceCartDTO(int id, String providerName, String serviceName, String staffName, double price, String avatar, String description, int status) {
        this.id = id;
        this.providerName = providerName;
        this.serviceName = serviceName;
        this.staffName = staffName;
        this.price = price;
        this.avatar = avatar;
        this.description = description;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProviderName() {
        return providerName;
    }

    public void setProviderName(String providerName) {
        this.providerName = providerName;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    
    
}
