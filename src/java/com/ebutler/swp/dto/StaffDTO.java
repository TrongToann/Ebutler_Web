/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author Dang Viet
 */
public class StaffDTO {
    private int staff_ID;
    private String provider_ID;
    private String service_ID;
    private String name;
    private String id_card;
    private String avatar;
    private int status;
    private double price;

    public StaffDTO() {
        this.staff_ID = 0;
        this.provider_ID = "";
        this.service_ID = "";
        this.name = "";
        this.id_card = "";
        this.avatar = "";
        this.status = 0;
        this.price = 0;
    }

    public StaffDTO(int staff_ID, String provider_ID, String service_ID, String name, String id_card, String avatar, int status) {
        this.staff_ID = staff_ID;
        this.provider_ID = provider_ID;
        this.service_ID = service_ID;
        this.name = name;
        this.id_card = id_card;
        this.avatar = avatar;
        this.status = status;
    }
    public StaffDTO(int staff_ID, String provider_ID, String service_ID, String name, String id_card, String avatar, int status, double price) {
        this.staff_ID = staff_ID;
        this.provider_ID = provider_ID;
        this.service_ID = service_ID;
        this.name = name;
        this.id_card = id_card;
        this.avatar = avatar;
        this.status = status;
        this.price = price;
    }

    public int getStaff_ID() {
        return staff_ID;
    }

    public void setStaff_ID(int staff_ID) {
        this.staff_ID = staff_ID;
    }

    public String getProvider_ID() {
        return provider_ID;
    }

    public void setProvider_ID(String provider_ID) {
        this.provider_ID = provider_ID;
    }

    public String getService_ID() {
        return service_ID;
    }

    public void setService_ID(String service_ID) {
        this.service_ID = service_ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getId_card() {
        return id_card;
    }

    public void setId_card(String id_card) {
        this.id_card = id_card;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "StaffDTO{" + "staff_ID=" + staff_ID + ", provider_ID=" + provider_ID + ", service_ID=" + service_ID + ", name=" + name + ", id_card=" + id_card + ", avatar=" + avatar + ", status=" + status + " ,price: "+ price +'}';
    }
    
    
}
