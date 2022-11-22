/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author Dang Viet
 */
public class ServiceOrderedHistoryDTO {
    private int order_id;
    private String username;
    private String order_Date;
    private String payment;
    private String staff_name;
    private String service_name;
    private String image;
    private double price;
    private String provider_name;
    private int status;

    public ServiceOrderedHistoryDTO() {
         this.username = "";
        this.order_Date = "";
        this.payment = "";
        this.staff_name = "";
        this.service_name = "";
        this.image = "";
        this.price = 0;
        this.provider_name = "";
        this.status = 0;
    }

    public ServiceOrderedHistoryDTO(int order_id,String username, String order_Date, String payment, String staff_name, String service_name, String image, double price, String provider_name,int status) {
        this.order_id = order_id;
        this.username = username;
        this.order_Date = order_Date;
        this.payment = payment;
        this.staff_name = staff_name;
        this.service_name = service_name;
        this.image = image;
        this.price = price;
        this.provider_name = provider_name;
        this.status = status;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getOrder_Date() {
        return order_Date;
    }

    public void setOrder_Date(String order_Date) {
        this.order_Date = order_Date;
    }

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }

    public String getStaff_name() {
        return staff_name;
    }

    public void setStaff_name(String staff_name) {
        this.staff_name = staff_name;
    }

    public String getService_name() {
        return service_name;
    }

    public void setService_name(String service_name) {
        this.service_name = service_name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getProvider_name() {
        return provider_name;
    }

    public void setProvider_name(String provider_name) {
        this.provider_name = provider_name;
    }

    @Override
    public String toString() {
        return "ServiceOrderedHistoryDTO{" + "username=" + username + ", order_Date=" + order_Date + ", payment=" + payment + ", staff_name=" + staff_name + ", service_name=" + service_name + ", image=" + image + ", price=" + price + ", status=" + status + '}';
    }
    
    
}
