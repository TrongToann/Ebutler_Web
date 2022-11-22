/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author Admin
 */
public class ReviewDTO {
    private int id;
    private String username;
    private String product_id;
    private String comment;
    private int rating;
    private int status;

    public ReviewDTO(String username, String product_id, String comment, int rating, int status) {
        this.username = username;
        this.product_id = product_id;
        this.comment = comment;
        this.rating = rating;
        this.status = status;
    }

    public ReviewDTO() {
        this.username = "";
        this.product_id = "";
        this.comment = "";
        this.rating = 0;
        this.status = 0;
    }

    public ReviewDTO(int id, String username, String product_id, String comment, int rating, int status) {
        this.id = id;
        this.username = username;
        this.product_id = product_id;
        this.comment = comment;
        this.rating = rating;
        this.status = status;
    }
    
    

    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getProduct_id() {
        return product_id;
    }

    public void setProduct_id(String product_id) {
        this.product_id = product_id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    
}
