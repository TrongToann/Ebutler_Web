/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author thekh
 */
public class ProductCartDTO {

    private String id;
    private String provider_name;
    private String product_ID;
    private String product_name;
    private int quantity;
    private double price;
    private String image;
    private String description;
    private int status;

    public ProductCartDTO() {
        this.id = "";
        this.provider_name = "";
        this.product_ID = "";
        this.product_name = "";
        this.quantity = 0;
        this.price = 0;
        this.image = "";
        this.description = "";
        this.status = 0;
    }

    public ProductCartDTO(String id, String provider_name, String product_ID, String product_name, int quantity, double price, String image, String description, int status) {
        this.id = id;
        this.provider_name = provider_name;
        this.product_ID = product_ID;
        this.product_name = product_name;
        this.quantity = quantity;
        this.price = price;
        this.image = image;
        this.description = description;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProvider_name() {
        return provider_name;
    }

    public void setProvider_name(String provider_name) {
        this.provider_name = provider_name;
    }

    public String getProduct_ID() {
        return product_ID;
    }

    public void setProduct_ID(String product_ID) {
        this.product_ID = product_ID;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
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
    
    

}
