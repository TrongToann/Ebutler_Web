/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author DELL
 */
public class ProviderStaffDTO {
    private int staffID ; 
    private String ServiceName ; 
    private String staff_Name ;
    private String staff_IDCard ; 
    private String image ;
    private int status ; 

    public ProviderStaffDTO(int staffID, String ServiceName, String staff_Name, String staff_IDCard, String image, int status) {
        this.staffID = staffID;
        this.ServiceName = ServiceName;
        this.staff_Name = staff_Name;
        this.staff_IDCard = staff_IDCard;
        this.image = image;
        this.status = status;
    }

    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public String getServiceName() {
        return ServiceName;
    }

    public void setServiceName(String ServiceName) {
        this.ServiceName = ServiceName;
    }

    public String getStaff_Name() {
        return staff_Name;
    }

    public void setStaff_Name(String staff_Name) {
        this.staff_Name = staff_Name;
    }

    public String getStaff_IDCard() {
        return staff_IDCard;
    }

    public void setStaff_IDCard(String staff_IDCard) {
        this.staff_IDCard = staff_IDCard;
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

    
    
    
}
