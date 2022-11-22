/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author Admin
 */
public class CityDTO {
    private String id;
    private String name;
    private String province_id;

    public CityDTO() {
        this.id = "";
        this.name = "";
        this.province_id = "";
    }

    public CityDTO(String id, String name, String province_id) {
        this.id = id;
        this.name = name;
        this.province_id = province_id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProvince_id() {
        return province_id;
    }

    public void setProvince_id(String province_id) {
        this.province_id = province_id;
    }
    
    
}
