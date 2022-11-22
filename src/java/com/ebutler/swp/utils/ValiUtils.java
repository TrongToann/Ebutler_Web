/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.utils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author Admin
 */
public class ValiUtils {

    private static final String PHONE_PATTERN = "^(0?)(3[1-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$";
    private static final String USERNAME_PATTERN = "^(?=[a-zA-Z0-9._]{7,20}$)(?!.*[_.]{2})[^_.].*[^_.]$";
    private static final String PASSWORD_PATTERN = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#&()–[{}]:;',?/*~$^+=<>]).{8,20}$";
    private static final String CUSTOMER_NAME_PATTERN = "[a-zA-Z ]{2,30}";
    private static final String PROVIDER_NAME_PATTERN = "[a-zA-Z0-9 ]{2,30}";
    private static final String PRODUCT_NAME_PATTERN = "^[A-Za-z0-9 _-]{2,30}";
    private static final String SERVICE_NAME_PATTERN = "^[A-Za-z0-9 _-]{2,30}";
    private static final String EMAIL_PATTERN_TYPE_1 = "^[A-Za-z0-9+_.-]+@gmail.com";
    private static final String EMAIL_PATTERN_TYPE_2 = "^[A-Za-z0-9+_.-]+@fpt.edu.vn";
    private static final String QUANTITY_PATTERN = "[0-9]+";
    private static final String PRICE_PATTERN = "[0-9]+.[0-9]+$";

    public static boolean isPhone(String phone) {
        return phone.trim().matches(PHONE_PATTERN);
    }

    public static boolean isValidUsername(String parameter) {
        return !parameter.matches(USERNAME_PATTERN);
    }

    public static boolean isValidPassword(String parameter) {
        return parameter.matches(PASSWORD_PATTERN);
    }

    public static boolean isValidCustomerName(String parameter) {
        return parameter.matches(CUSTOMER_NAME_PATTERN);
    }
    
    public static boolean isValidProviderName(String parameter) {
        return parameter.matches(PROVIDER_NAME_PATTERN);
    }
    
    public static boolean isValidProductName(String parameter) {
        return (parameter.matches(PRODUCT_NAME_PATTERN) && !parameter.trim().isEmpty());
    }
    
    public static boolean isValidServiceName(String parameter) {
        return (parameter.matches(SERVICE_NAME_PATTERN) && !parameter.trim().isEmpty());
    }

    public static boolean isValidEmail(String parameter) {
        return (parameter.matches(EMAIL_PATTERN_TYPE_1) || parameter.matches(EMAIL_PATTERN_TYPE_2));
    }
    
    public static boolean isValidQuantity(String parameter) {
        return parameter.matches(QUANTITY_PATTERN);
    }
    
    public static boolean isValidPrice(String parameter) {
        return parameter.matches(PRICE_PATTERN);
    }

    public static boolean isValidDob(String parameter) {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDateTime now = LocalDateTime.now();
        String currentDate = dtf.format(now);
        
        return currentDate.compareTo(parameter) > 0;
    }
}
