package com.wify.erp.NewPojo;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collection = "ManufacturingBOM")
public class ManufacturingBOM {

    String id;
    String name;
    String code;
    String quantity;
    String productCode;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public ManufacturingBOM() {
    }

    public ManufacturingBOM(String id, String name, String code, String quantity,String productCode) {
        this.id = id;
        this.name = name;
        this.code = code;
        this.quantity = quantity;
        this.productCode = productCode;
    }

}
