package com.wify.erp.NewPojo;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collection = "Employee")
public class Employee {
    String id;
    String name;
    String bgroup;
    String gender;
    String address;
    String designation;
    String email;
    String mobile;
    String altmobile;
    String join_date;
    String dob;

    public Employee(String id, String name, String bgroup, String gender, String address, String designation, String email, String mobile, String altmobile, String join_date, String dob) {
        this.id = id;
        this.name = name;
        this.bgroup = bgroup;
        this.gender = gender;
        this.address = address;
        this.designation = designation;
        this.email = email;
        this.mobile = mobile;
        this.altmobile = altmobile;
        this.join_date = join_date;
        this.dob = dob;
    }

    public Employee() {
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

    public String getBgroup() {
        return bgroup;
    }

    public void setBgroup(String bgroup) {
        this.bgroup = bgroup;
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

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
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

    public String getAltmobile() {
        return altmobile;
    }

    public void setAltmobile(String altmobile) {
        this.altmobile = altmobile;
    }

    public String getJoin_date() {
        return join_date;
    }

    public void setJoin_date(String join_date) {
        this.join_date = join_date;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }
}
