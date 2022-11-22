/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author thekh
 */
public class OrderDetailDTO {
    private int id;
    private int product_detail_ID;
    private int service_detail_ID;
    private int order_ID;
    private int staff_ID;
    private int quantity;
    private double price;
    private int status;
    private String name;
    private double total;
 
    public OrderDetailDTO() {
        this.id = 0;
        this.product_detail_ID = 0;
        this.order_ID = 0;
        this.quantity = 0;
        this.price = 0;
        this.status = 0;
    }

    public OrderDetailDTO(int id, int product_detail_ID, int order_ID, int quantity, double price, int status) {
        this.id = id;
        this.product_detail_ID = product_detail_ID;
        this.order_ID = order_ID;
        this.quantity = quantity;
        this.price = price;
        this.status = status;
    }

    public OrderDetailDTO(int id, int order_ID ,int product_detail_ID , String name, int quantity, double price, double total, int status ) {
        this.id = id;
        this.order_ID = order_ID;
        this.quantity = quantity;
        this.price = price;
        this.status = status;
        this.name = name;
        this.total = total;
        this.product_detail_ID = product_detail_ID ; 
    }

    public OrderDetailDTO(int id,int order_ID, int service_detail_ID ,String name, int staff_ID, double price, int status ) {
        this.id = id;
        this.service_detail_ID = service_detail_ID;
        this.order_ID = order_ID;
        this.staff_ID = staff_ID;
        this.price = price;
        this.status = status;
        this.name = name;
    }
    
    
    public String getName() {
        return name;
    }

    public int getService_detail_ID() {
        return service_detail_ID;
    }

    public void setService_detail_ID(int service_detail_ID) {
        this.service_detail_ID = service_detail_ID;
    }

    public int getStaff_ID() {
        return staff_ID;
    }

    public void setStaff_ID(int staff_ID) {
        this.staff_ID = staff_ID;
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
    
    
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProduct_detail_ID() {
        return product_detail_ID;
    }

    public void setProduct_detail_ID(int product_detail_ID) {
        this.product_detail_ID = product_detail_ID;
    }

    public int getOrder_ID() {
        return order_ID;
    }

    public void setOrder_ID(int order_ID) {
        this.order_ID = order_ID;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "OrderDetailDTO{" + "id=" + id + ", product_detail_ID=" + product_detail_ID + ", service_detail_ID=" + service_detail_ID + ", order_ID=" + order_ID + ", staff_ID=" + staff_ID + ", quantity=" + quantity + ", price=" + price + ", status=" + status + ", name=" + name + ", total=" + total + '}';
    }
    
    
}
