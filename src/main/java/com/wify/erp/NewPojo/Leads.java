package com.wify.erp.NewPojo;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collection = "Leads")
public class Leads {
    String id;
    String name;
    String address;
    String mobile;
    String stage;
    String captureBy;
    String followDate;
    String registration;
    String leadType;
    String leadBy;
    String category;
    String salesEmpID;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getStage() {
        return stage;
    }

    public void setStage(String stage) {
        this.stage = stage;
    }

    public String getCaptureBy() {
        return captureBy;
    }

    public void setCaptureBy(String captureBy) {
        this.captureBy = captureBy;
    }

    public String getFollowDate() {
        return followDate;
    }

    public void setFollowDate(String followDate) {
        this.followDate = followDate;
    }

    public String getRegistration() {
        return registration;
    }

    public void setRegistration(String registration) {
        this.registration = registration;
    }

    public String getLeadType() {
        return leadType;
    }

    public void setLeadType(String leadType) {
        this.leadType = leadType;
    }

    public String getLeadBy() {
        return leadBy;
    }

    public void setLeadBy(String leadBy) {
        this.leadBy = leadBy;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getSalesEmpID() {
        return salesEmpID;
    }

    public void setSalesEmpID(String salesEmpID) {
        this.salesEmpID = salesEmpID;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Leads(String id, String name, String address, String mobile, String stage, String captureBy, String followDate, String registration, String leadType, String leadBy,String category,String salesEmpID, String comment) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.mobile = mobile;
        this.stage = stage;
        this.captureBy = captureBy;
        this.followDate = followDate;
        this.registration = registration;
        this.leadType = leadType;
        this.leadBy = leadBy;
        this.category = category;
        this.salesEmpID = salesEmpID;
        this.comment = comment;
    }

    public Leads() {
    }
}
