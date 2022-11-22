/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author Dang Viet
 */
public class ProductOrderHistoryDTO {
    private int id;
    private int order_id;
    private String username;
    private String order_Date;
    private String payment;
    private String productName;
    private double price;
    private int quantity;
    private String image;
    private String provider_name;
    private String product_category;
    private int status;

    public ProductOrderHistoryDTO() {
        this.username = "";
        this.order_Date = "";
        this.payment = "";
        this.productName = "";
        this.price = 0;
        this.quantity = 0;
        this.image = "";
        this.provider_name = "";
        this.product_category = "";
        this.status = 0;
    }

    public ProductOrderHistoryDTO(int order_id ,String username, String order_Date, String payment, String productName, double price, int quantity, String image, String provider_name, String product_category, int status) {
        this.order_id = order_id;
        this.username = username;
        this.order_Date = order_Date;
        this.payment = payment;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.image = image;
        this.provider_name = provider_name;
        this.product_category = product_category;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }
    
    

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getOrder_Date() {
        return order_Date;
    }

    public void setOrder_Date(String order_Date) {
        this.order_Date = order_Date;
    }

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getProvider_name() {
        return provider_name;
    }

    public void setProvider_name(String provider_name) {
        this.provider_name = provider_name;
    }

    public String getProduct_category() {
        return product_category;
    }

    public void setProduct_category(String product_category) {
        this.product_category = product_category;
    }

    @Override
    public String toString() {
        return "ProductOrderHistoryDTO{" + "username=" + username + ", order_Date=" + order_Date + ", payment=" + payment + ", productName=" + productName + ", price=" + price + ", quantity=" + quantity + ", image=" + image + ", status=" + status + '}';
    }

}
