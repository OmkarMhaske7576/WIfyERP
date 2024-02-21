package com.wify.erp.NewPojo;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collection = "Packages")
public class Packages {

    String id;
    String name;
    String discount;
    String total;
    String finalTotal;

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
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

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    public String getFinalTotal() {
        return finalTotal;
    }

    public void setFinalTotal(String finalTotal) {
        this.finalTotal = finalTotal;
    }

    public Packages() {
    }

    public Packages(String id, String name, String discount, String total,String finalTotal) {
        this.id = id;
        this.name = name;
        this.discount = discount;
        this.total = total;
        this.finalTotal = finalTotal;
    }

}
