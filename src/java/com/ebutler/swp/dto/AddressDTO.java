/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author Admin
 */
public class AddressDTO {
    private int id;
    private String district_id;
    private String district_name;
    private String province_id;
    private String province_name;
    private String street;
    private String user_id;
    private int status;

    public AddressDTO(String district_id, String street, String user_id, int status) {
        this.district_id = district_id;
        this.street = street;
        this.user_id = user_id;
        this.status = status;
    }

    public AddressDTO() {
        this.district_id = "";
        this.district_name = "";
        this.province_name = "";
        this.street = "";
        this.user_id = "";
        this.status = 0;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProvince_id() {
        return province_id;
    }

    public void setProvince_id(String province_id) {
        this.province_id = province_id;
    }

    public String getDistrict_name() {
        return district_name;
    }

    public void setDistrict_name(String district_name) {
        this.district_name = district_name;
    }

    public String getProvince_name() {
        return province_name;
    }

    public void setProvince_name(String province_name) {
        this.province_name = province_name;
    }

    public String getDistrict_id() {
        return district_id;
    }

    public void setDistrict_id(String district_id) {
        this.district_id = district_id;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        if(this.getStreet().isEmpty() || this.getDistrict_name().isEmpty() || this.getProvince_name().isEmpty()) return "";
 
        return (this.getStreet() + ", " + this.getDistrict_name() + ", " + this.getProvince_name());
    }
    
    
}
