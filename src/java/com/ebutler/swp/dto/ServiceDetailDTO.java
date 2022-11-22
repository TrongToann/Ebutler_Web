/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author Dang Viet
 */
public class ServiceDetailDTO {
    private int id;
    private String provider_ID;
    private String service_ID;
    private int staff_ID;
    private String name;
    private double price;
    private String description;
    private int status;

    public ServiceDetailDTO() {
        this.id = 0;
        this.provider_ID = "";
        this.service_ID = "";
        this.staff_ID = 0;
        this.name = "";
        this.price = 0;
        this.description = "";
        this.status = 0;
    }
    
    public ServiceDetailDTO(int id ,String provider_ID, String service_ID, int staff_ID, String name, double price, String description, int status) {
        this.id = id;
        this.provider_ID = provider_ID;
        this.service_ID = service_ID;
        this.staff_ID = staff_ID;
        this.name = name;
        this.price = price;
        this.description = description;
        this.status = status;
    }

    public ServiceDetailDTO(String provider_ID, String service_ID, int staff_ID, String name, double price, String description, int status) {
        this.provider_ID = provider_ID;
        this.service_ID = service_ID;
        this.staff_ID = staff_ID;
        this.name = name;
        this.price = price;
        this.description = description;
        this.status = status;
    }

    public int getId() {
        return id;
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

    public int getStaff_ID() {
        return staff_ID;
    }

    public void setStaff_ID(int staff_ID) {
        this.staff_ID = staff_ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
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

    @Override
    public String toString() {
        return "ServiceDetailDTO{" + "id=" + id + ", provider_ID=" + provider_ID + ", service_ID=" + service_ID + ", staff_ID=" + staff_ID + ", name=" + name + ", price=" + price + ", description=" + description + ", status=" + status + '}';
    }
    
    
}
