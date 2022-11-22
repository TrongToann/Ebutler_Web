/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dto;

/**
 *
 * @author Admin
 */
public class NotificationDTO {
    private int id;
    private String time;
    private String username;
    private String message;
    private String avatar;
    
    public NotificationDTO() {
        this.id = 0;
        this.time = "";
        this.username = "";
        this.message = "";
        this.avatar = "";
    }

    public NotificationDTO(int id, String time, String username, String message, String avatar) {
        this.id = id;
        this.time = time;
        this.username = username;
        this.message = message;
        this.avatar = avatar;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    
    
}
