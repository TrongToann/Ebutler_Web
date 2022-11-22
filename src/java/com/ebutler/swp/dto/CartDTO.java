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
public class CartDTO {

    private Map<String, ProductCartDTO> cart;

    public CartDTO() {
    }

    public CartDTO(Map<String, ProductCartDTO> cart) {
        this.cart = cart;
    }

    public Map<String, ProductCartDTO> getCart() {
        return cart;
    }

    public void setCart(Map<String, ProductCartDTO> cart) {
        this.cart = cart;
    }

    public boolean add(ProductCartDTO product) {
        boolean check = false;
        if (this.cart == null) {
            this.cart = new HashMap<>();
        }
        if (checkExistById(product)) {
            int currentQuantity = this.cart.get(product.getId()).getQuantity();
            this.cart.get(product.getId()).setQuantity(currentQuantity + product.getQuantity());
        } else {
            this.cart.put(product.getId(), product);
        }
        check = true;
        return check;
    }

    public boolean checkExistById(ProductCartDTO product) {
        return this.cart.containsKey(product.getId());
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

    public boolean update(String id, ProductCartDTO product) {
        boolean check = false;
        if (this.cart != null) {
            if (this.cart.containsKey(id)) {
                this.cart.replace(id, product);
                check = true;
            }
        }
        return check;
    }

    public int getQuantity(int quantity) {
        return 0;
    }
}
