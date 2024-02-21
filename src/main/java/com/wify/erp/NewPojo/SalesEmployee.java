package com.wify.erp.NewPojo;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collection = "Sales Employee")
public class SalesEmployee {

    String id;
    String name;
    String gender;
    String address;
    String email;
    String mobile;
    String reg_date;
    String dob;
    String companyName;
    String companyId;
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

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
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

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getReg_date() {
        return reg_date;
    }

    public void setReg_date(String reg_date) {
        this.reg_date = reg_date;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public SalesEmployee() {
    }

    public SalesEmployee(String id, String name, String gender, String address, String email, String mobile, String reg_date, String dob, String companyName, String companyId, String status, String comment) {
        this.id = id;
        this.name = name;
        this.gender = gender;
        this.address = address;
        this.email = email;
        this.mobile = mobile;
        this.reg_date = reg_date;
        this.dob = dob;
        this.companyName = companyName;
        this.companyId = companyId;
        this.status = status;
        this.comment = comment;
    }
}
