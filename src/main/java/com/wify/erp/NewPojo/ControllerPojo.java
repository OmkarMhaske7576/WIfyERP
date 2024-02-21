package com.wify.erp.NewPojo;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collection = "Quotation BOM")
public class ControllerPojo extends QuotationBOM{

    int generic;
    int power;

    public int getGeneric() {
        return generic;
    }

    public void setGeneric(int generic) {
        this.generic = generic;
    }

    public int getPower() {
        return power;
    }

    public void setPower(int power) {
        this.power = power;
    }

    public ControllerPojo() {
    }

    public ControllerPojo(int generic, int power, String id, String pname, String pcode, String quantity, String price, String packageName, String quotationID) {
        this.generic = generic;
        this.power = power;
        this.id = id;
        this.pname = pname;
        this.pcode = pcode;
        this.quantity = quantity;
        this.price = price;
        this.packageName = packageName;
        this.quotationID = quotationID;
    }

    @Override
    public String toString() {
        return "ControllerPojo{" +
                "generic=" + generic +
                ", power=" + power +
                ", id='" + id + '\'' +
                ", pname='" + pname + '\'' +
                ", pcode='" + pcode + '\'' +
                ", quantity='" + quantity + '\'' +
                ", price='" + price + '\'' +
                ", packageName='" + packageName + '\'' +
                ", quotationID='" + quotationID + '\'' +
                '}';
    }
}
