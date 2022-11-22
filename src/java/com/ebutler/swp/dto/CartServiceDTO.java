/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author thekh
 */
public class CartServiceDTO {
    private Map<String, ServiceCartDTO> cart;

    public CartServiceDTO() {
    }

    public CartServiceDTO(Map<String, ServiceCartDTO> cart) {
        this.cart = cart;
    }

    public Map<String, ServiceCartDTO> getCart() {
        return cart;
    }

    public void setCart(Map<String, ServiceCartDTO> cart) {
        this.cart = cart;
    }
    

    public boolean add(ServiceCartDTO service) {
        boolean check = false;
        if (this.cart == null) {
            this.cart = new HashMap<>();
        }
        if (service.getStatus() == 1) {
           this.cart.put(String.valueOf(service.getId()), service);
           check = true;
        }  
        return check;
    }


    public boolean remove(String id) {
        boolean check = false;
        if (this.cart != null) {
            if (this.cart.containsKey(id)) {
                this.cart.remove(id);
                check = true;
            }
        }
        return check;
    }

}
