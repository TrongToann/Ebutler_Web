/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

import java.sql.Date;

/**
 *
 * @author DELL
 */
public class OrderDetailInfoDTO {
    private int orderID ;
    private Date order_date; 
    private int status ;
    private String name ;
    private String phone ;
    private String email ;

    public OrderDetailInfoDTO(int orderID, Date order_date, int status, String name, String phone, String email) {
        this.orderID = orderID;
        this.order_date = order_date;
        this.status = status;
        this.name = name;
        this.phone = phone;
        this.email = email;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Date getOrder_date() {
        return order_date;
    }

    public void setOrder_date(Date order_date) {
        this.order_date = order_date;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    
    @Override
    public String toString() {
        return "OrderDetailInfoDTO{" + "orderID=" + orderID + ", order_date=" + order_date + ", status=" + status + ", name=" + name + ", phone=" + phone + ", email=" + email + '}';
    }
    
}
