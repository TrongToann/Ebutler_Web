/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author DELL
 */
public class ProviderOrderDTO {
    private String orderID ; 
    private String orderDate ; 
    private String customerName ; 
    private int price_Total ; 
    private int status ; 

    public ProviderOrderDTO(String orderID, String orderDate, String customerName, int price_Total, int status) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.customerName = customerName;
        this.price_Total = price_Total;
        this.status = status;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public int getPrice_Total() {
        return price_Total;
    }

    public void setPrice_Total(int price_Total) {
        this.price_Total = price_Total;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    
    
}
