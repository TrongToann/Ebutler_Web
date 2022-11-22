/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

import java.sql.Date;

/**
 *
 * @author thekh
 */
public class OrderDTO {
    private int order_ID;
    private Date order_date;
    private String customer_ID;
    private int status;
    private double total;
    private String providerID ; 
    private String shipping ; 
    
    public OrderDTO() {
        this.order_ID = 0;
        this.order_date = null;
        this.customer_ID = "";
        this.status = 0;
        this.total = 0;
    }

    public OrderDTO(int order_ID, Date order_date, String customer_ID, int status, double total) {
        this.order_ID = order_ID;
        this.order_date = order_date;
        this.customer_ID = customer_ID;
        this.status = status;
        this.total = total;
    }

    public OrderDTO(int order_ID, Date order_date, String customer_ID, int status, double total , String providerID) {
        this.order_ID = order_ID;
        this.order_date = order_date;
        this.customer_ID = customer_ID;
        this.status = status;
        this.total = total;
        this.providerID = providerID;
    }

    public String getProviderID() {
        return providerID;
    }

    public void setProviderID(String providerID) {
        this.providerID = providerID;
    }
    
    
    public int getOrder_ID() {
        return order_ID;
    }

    public String getShipping() {
        return shipping;
    }

    public void setShipping(String shipping) {
        this.shipping = shipping;
    }

    public void setOrder_ID(int order_ID) {
        this.order_ID = order_ID;
    }

    public Date getOrder_date() {
        return order_date;
    }

    public void setOrder_date(Date order_date) {
        this.order_date = order_date;
    }

    public String getCustomer_ID() {
        return customer_ID;
    }

    public void setCustomer_ID(String customer_ID) {
        this.customer_ID = customer_ID;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
    
    public void add(OrderDTO order) {
        
    }
}
