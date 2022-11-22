/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

import java.util.ArrayList;

/**
 *
 * @author Dang Viet
 */
public class ProductDetailDTO {

    private String id;
    private String provider_ID;
    private String product_ID;
    private String name;
    private int quantity;
    private double price;
    private String image;
    private String description;
    private int status;

    private ArrayList<ReviewDTO> review_list = new ArrayList<ReviewDTO>();

    public ProductDetailDTO() {
        this.id = "";
        this.provider_ID = "";
        this.product_ID = "";
        this.name = "";
        this.quantity = 0;
        this.price = 0;
        this.image = "";
        this.description = "";
        this.status = 0;
    }

    
    public ProductDetailDTO(String id, String provider_ID, String product_ID, String name, int quantity, double price, String image, String description, int status) {
        this.id = id;
        this.provider_ID = provider_ID;
        this.product_ID = product_ID;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
        this.image = image;
        this.description = description;
        this.status = status;
    }

    public ProductDetailDTO(String id, String name, String image, double price, int quantity, String description, int status) {
        this.id = id;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
        this.image = image;
        this.description = description;
        this.status = status;
    }

    public ArrayList<ReviewDTO> getReview_list() {
        return review_list;
    }

    public void setReview_list(ArrayList<ReviewDTO> review_list) {
        this.review_list = review_list;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProvider_ID() {
        return provider_ID;
    }

    public void setProvider_ID(String provider_ID) {
        this.provider_ID = provider_ID;
    }

    public String getProduct_ID() {
        return product_ID;
    }

    public void setProduct_ID(String product_ID) {
        this.product_ID = product_ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    @Override
    public String toString() {
        return "ProductDetailDTO{" + "id=" + id + ", provider_ID=" + provider_ID + ", product_ID=" + product_ID + ", name=" + name + ", quantity=" + quantity + ", price=" + price + ", image=" + image + ", description=" + description + ", status=" + status + '}';
    }

}
