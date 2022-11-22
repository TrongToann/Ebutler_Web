/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author Dang Viet
 */
public class ProductCategoryDTO {
   private String category_ID;
   private String name;
   private String image;

    public ProductCategoryDTO() {
        this.category_ID = "";
        this.name = "";
        this.image = "";
    }

    public ProductCategoryDTO(String category_ID, String name, String image) {
        this.category_ID = category_ID;
        this.name = name;
        this.image = image;
    }

    public String getCategory_ID() {
        return category_ID;
    }

    public void setCategory_ID(String category_ID) {
        this.category_ID = category_ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "ProductCategoryDTO{" + "category_ID=" + category_ID + ", name=" + name + ", image=" + image + '}';
    }

  
    
}
