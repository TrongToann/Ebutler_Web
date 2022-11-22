
package com.ebutler.swp.dto;


public class ProviderServiceDTO1 {
    private String serviceID ;
    private String categoryID ;
    private String serviceName ; 
    private String serviceCategoryName ; 
    private String serviceDetailName ; 
    private String image ; 
    private int price ; 
    private String description ; 
    private int status ; 

    public ProviderServiceDTO1(String serviceName, String serviceCategoryName, String image,String serviceDetailName, int price, String description, int status) {
        this.serviceName = serviceName;
        this.serviceCategoryName = serviceCategoryName;
        this.image = image;
        this.serviceDetailName = serviceDetailName; 
        this.price = price;
        this.description = description;
        this.status = status;
    }

    public ProviderServiceDTO1(String serviceID, String serviceName, String image) {
        this.serviceID = serviceID;
        this.serviceName = serviceName;
        this.image = image;
    }

    public ProviderServiceDTO1(String serviceID, String categoryID , String serviceName, String serviceCategoryName) {
        this.serviceID = serviceID;
        this.serviceName = categoryID;
        this.serviceCategoryName = serviceName;
        this.image = serviceCategoryName;
    }

    public String getServiceDetailName() {
        return serviceDetailName;
    }

    public void setServiceDetailName(String serviceDetailName) {
        this.serviceDetailName = serviceDetailName;
    }

    public String getServiceID() {
        return serviceID;
    }

    public void setServiceID(String serviceID) {
        this.serviceID = serviceID;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }
    
    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getServiceCategoryName() {
        return serviceCategoryName;
    }

    public void setServiceCategoryName(String serviceCategoryName) {
        this.serviceCategoryName = serviceCategoryName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    
    

   
}
