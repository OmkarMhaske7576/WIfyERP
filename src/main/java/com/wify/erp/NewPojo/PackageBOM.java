package com.wify.erp.NewPojo;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collection = "PackageBOM")
public class PackageBOM {

    String id;
    String name;
    String code;
    String price;
    String quantity;
    String packageID;

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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getPackageID() {
        return packageID;
    }

    public void setPackageID(String packageID) {
        this.packageID = packageID;
    }

    public PackageBOM() {
    }

    public PackageBOM(String id, String name, String code, String price, String quantity, String packageID) {
        this.id = id;
        this.name = name;
        this.code = code;
        this.price = price;
        this.quantity = quantity;
        this.packageID = packageID;
    }
}
