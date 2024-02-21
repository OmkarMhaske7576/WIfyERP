package com.wify.erp.NewPojo;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collection = "Inventory")
public class Inventory_Products {

    String id;
    String productCode;
    String name;
    String stock;
    String price;
    String stockAlert;
    String category;

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

    public String getStockAlert() {
        return stockAlert;
    }

    public void setStockAlert(String stockAlert) {
        this.stockAlert = stockAlert;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getStock() {
        return stock;
    }

    public void setStock(String stock) {
        this.stock = stock;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public Inventory_Products() {
    }

    public Inventory_Products(String id, String productCode,String name, String stock, String price, String stockAlert,String category) {
        this.id = id;
        this.productCode = productCode;
        this.name = name;
        this.stock = stock;
        this.price = price;
        this.stockAlert = stockAlert;
        this.category = category;
    }

    @Override
    public String toString() {
        return "Inventory_Products{" +
                "id='" + id + '\'' +
                ", productCode='" + productCode + '\'' +
                ", name='" + name + '\'' +
                ", stock='" + stock + '\'' +
                ", price='" + price + '\'' +
                ", stockAlert='" + stockAlert + '\'' +
                ", category='" + category + '\'' +
                '}';
    }
}