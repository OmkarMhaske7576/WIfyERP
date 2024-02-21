package com.wify.erp.NewPojo;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collection = "Warehouse Stock")
public class WarehouseStock {

    int id;
    String date;
    String stocks;
    String comment;
    String productsCode;

    public WarehouseStock() {
    }

    public WarehouseStock(int id, String date, String stocks, String comment, String productsCode) {
        this.id = id;
        this.date = date;
        this.stocks = stocks;
        this.comment = comment;
        this.productsCode = productsCode;
    }
}
