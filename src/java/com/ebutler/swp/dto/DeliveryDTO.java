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
public class DeliveryDTO {

    private int orderID;
    private String address;
    private Date order_Date;
    private String name;
    private double total;
    private int status;
    private String username_Shipper;
    private String customer_ID;

    public DeliveryDTO(int orderID, String address, String username_Shipper, Date order_Date, String customer_ID, String name, double total, int status) {
        this.orderID = orderID;
        this.address = address;
        this.order_Date = order_Date;
        this.name = name;
        this.total = total;
        this.status = status;
        this.customer_ID = customer_ID;
        this.username_Shipper = username_Shipper;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getOrder_Date() {
        return order_Date;
    }

    public void setOrder_Date(Date order_Date) {
        this.order_Date = order_Date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getCustomer_ID() {
        return customer_ID;
    }

    public void setCustomer_ID(String customer_ID) {
        this.customer_ID = customer_ID;
    }

    public String getUsername_Shipper() {
        return username_Shipper;
    }

    public void setUsername_Shipper(String username_Shipper) {
        this.username_Shipper = username_Shipper;
    }

//    @Override
//    public String toString() {
//        return "DeliveryDTO{" + "orderID=" + orderID + ", address=" + address + ", order_Date=" + order_Date + ", name=" + name + ", total=" + total + ", status=" + status + '}';
//    }

}
