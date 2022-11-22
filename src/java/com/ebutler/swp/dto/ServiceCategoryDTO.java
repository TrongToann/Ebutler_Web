/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author Dang Viet
 */
public class ServiceCategoryDTO {
    private String category_ID;
    private String name;
    private String image;
    private String service_ID;
    

    public ServiceCategoryDTO() {
        this.category_ID = "";
        this.name = "";
        this.image = "";
        this.service_ID = "";
    }

    public ServiceCategoryDTO(String category_ID, String name, String image) {
        this.category_ID = category_ID;
        this.name = name;
        this.image = image;
    }
    public ServiceCategoryDTO(String category_ID, String name, String image, String service_ID) {
        this.category_ID = category_ID;
        this.name = name;
        this.image = image;
        this.service_ID = service_ID;
    }
     public ServiceCategoryDTO(String service_ID) {
        this.service_ID = service_ID;
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

    public String getService_ID() {
        return service_ID;
    }

    public void setService_ID(String service_ID) {
        this.service_ID = service_ID;
    }

    @Override
    public String toString() {
        return "ServiceCategoryDTO{" + "category_ID=" + category_ID + ", name=" + name + ", image=" + image + ", service_ID=" + service_ID + '}';
    }
    

  
    

    
    
    

}
