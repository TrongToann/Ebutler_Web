/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author thekh
 */
public class OrderPayPalDetail {
    private float subtotal;
    private float shipping;
    private float total;
 
    public OrderPayPalDetail( String subtotal,
            String shipping, String total) {
        this.subtotal = Float.parseFloat(subtotal);
        this.shipping = Float.parseFloat(shipping);
        this.total = Float.parseFloat(total);
    }
 
    public String getSubtotal() {
        return String.format("%.2f", subtotal);
    }
 
    public String getShipping() {
        return String.format("%.2f", shipping);
    }
 
     
    public String getTotal() {
        return String.format("%.2f", total);
    }
}
