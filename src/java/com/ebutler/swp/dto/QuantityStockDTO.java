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
public class QuantityStockDTO {

    private Map<String, Integer> quantityStock;

    public QuantityStockDTO() {
    }

    public QuantityStockDTO(Map<String, Integer> quantityStock) {
        this.quantityStock = quantityStock;
    }

    public Map<String, Integer> getQuantityStock() {
        return quantityStock;
    }

    public void setQuantityStock(Map<String, Integer> quantityStock) {
        this.quantityStock = quantityStock;
    }

    public boolean checkExistById(ProductCartDTO product) {
        return this.quantityStock.containsKey(product.getId());
    }

    public boolean add(ProductCartDTO product) {
        boolean check = false;
        if (this.quantityStock == null) {
            this.quantityStock = new HashMap<>();
        }
        if (checkExistById(product)) {
            this.quantityStock.replace(product.getId(), product.getQuantity());
        } else {
            this.quantityStock.put(product.getId(), product.getQuantity());
        }
        check = true;
        return check;
    }
}
