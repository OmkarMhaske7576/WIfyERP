package com.wify.erp.NewPojo;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collection = "Inventory Production")
public class Inventory_production {

    String id;
    String request;
    String name;
    String code;
    String quantity;
    String status;
    String date;
    String category;
    String comment;

    public String getRequest() {
        return request;
    }

    public void setRequest(String request) {
        this.request = request;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Inventory_production() {
    }

    public Inventory_production(String id,String request, String name, String code, String quantity, String status, String date, String category, String comment) {

        this.id = id;
        this.request = request;
        this.name = name;
        this.code = code;
        this.quantity = quantity;
        this.status = status;
        this.date = date;
        this.category = category;
        this.comment = comment;
    }
}

