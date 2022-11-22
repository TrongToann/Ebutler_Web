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
public class ServiceDTO {

    private String service_ID;
    private String category_ID;
    private String name;
    private String image;
    private int status;
    
//    thêm staff_list
    private ArrayList<StaffDTO> staff_list;

    public ServiceDTO() {
        this.service_ID = "";
        this.category_ID = "";
        this.name = "";
        this.image = "";
        this.status = 0;
        this.staff_list = new ArrayList<StaffDTO>();
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public ServiceDTO(String service_ID, String category_ID, String name, String image, int status, ArrayList<StaffDTO> staff_list) {
        this.service_ID = service_ID;
        this.category_ID = category_ID;
        this.name = name;
        this.image = image;
        this.status = status;
        this.staff_list = staff_list;
    }

    
    public ServiceDTO(String service_ID, String category_ID, String name, String image, ArrayList<StaffDTO> staff_list) {
        this.service_ID = service_ID;
        this.category_ID = category_ID;
        this.name = name;
        this.image = image;
        this.staff_list = staff_list;
    }


    public ArrayList<StaffDTO> getStaff_list() {
        return staff_list;
    }

    public void setStaff_list(ArrayList<StaffDTO> staff_list) {
        this.staff_list = staff_list;
    }

    

    public String getService_ID() {
        return service_ID;
    }

    public void setService_ID(String service_ID) {
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

    @Override
    public String toString() {
        return "ServiceDTO{" + "service_ID=" + service_ID + ", category_ID=" + category_ID + ", name=" + name + ", image=" + image + '}';
    }
    
    

}
