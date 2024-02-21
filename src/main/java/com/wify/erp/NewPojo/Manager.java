package com.wify.erp.NewPojo;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collection = "Managers")
public class Manager {

    String id;
    String name;
    String mobile;
    String address;
    String email;
    String date;
    String level;
    String companyID;
    String status;
    String comment;

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

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getCompanyID() {
        return companyID;
    }

    public void setCompanyID(String companyID) {
        this.companyID = companyID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Manager() {
    }

    public Manager(String id, String name, String mobile, String address, String email, String date, String level,String companyID, String status, String comment) {
        this.id = id;
        this.name = name;
        this.mobile = mobile;
        this.address = address;
        this.email = email;
        this.date = date;
        this.level = level;
        this.companyID = companyID;
        this.status = status;
        this.comment = comment;
    }


}
