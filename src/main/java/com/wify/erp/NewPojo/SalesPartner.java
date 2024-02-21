package com.wify.erp.NewPojo;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collection = "Sales Partner")
public class SalesPartner {

    String id;
    String name;
    String mobile;
    String address;
    String address1;
    String state;
    String gst;
    String email;
    String date;
    String level;
    String percentage;
    String ordersCount;
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

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getGst() {
        return gst;
    }

    public void setGst(String gst) {
        this.gst = gst;
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

    public String getPercentage() {
        return percentage;
    }

    public void setPercentage(String percentage) {
        this.percentage = percentage;
    }

    public String getOrdersCount() {
        return ordersCount;
    }

    public void setOrdersCount(String ordersCount) {
        this.ordersCount = ordersCount;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public SalesPartner() {
    }

    public SalesPartner(String id,String name, String mobile, String address,String address1, String state, String gst, String email, String date, String level, String percentage, String ordersCount, String comment) {
        this.id = id;
        this.name = name;
        this.mobile = mobile;
        this.address = address;
        this.address1 = address1;
        this.state = state;
        this.gst = gst;
        this.email = email;
        this.date = date;
        this.level = level;
        this.percentage = percentage;
        this.ordersCount = ordersCount;
        this.comment = comment;
    }


}
