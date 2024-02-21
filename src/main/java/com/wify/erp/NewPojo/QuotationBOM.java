package com.wify.erp.NewPojo;

import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.mapping.Document;


@Data
@Document(collection = "Quotation BOM")
public class QuotationBOM {

    String id;
    String pname;
    String pcode;
    String quantity;
    String price;
//    String availableStatus;
//    String discount;
    String packageName;
    String quotationID;
    String roomName;

    public QuotationBOM() {
    }

    public QuotationBOM(String id, String pname, String pcode, String quantity, String price, /*String availableStatus, String discount,*/ String packageName,String quotationID, String roomName) {
        this.id = id;
        this.pname = pname;
        this.pcode = pcode;
        this.quantity = quantity;
        this.price = price;
//        this.availableStatus = availableStatus;
//        this.discount = discount;
        this.packageName = packageName;
        this.quotationID = quotationID;
        this.roomName = roomName;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getPcode() {
        return pcode;
    }

    public void setPcode(String pcode) {
        this.pcode = pcode;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

//    public String getAvailableStatus() {
//        return availableStatus;
//    }
//
//    public void setAvailableStatus(String availableStatus) {
//        this.availableStatus = availableStatus;
//    }

//    public String getDiscount() {
//        return discount;
//    }
//
//    public void setDiscount(String discount) {
//        this.discount = discount;
//    }


    public String getQuotationID() {
        return quotationID;
    }

    public void setQuotationID(String quotationID) {
        this.quotationID = quotationID;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    @Override
    public String toString() {
        return "QuotationBOM{" +
                "id='" + id + '\'' +
                ", pname='" + pname + '\'' +
                ", pcode='" + pcode + '\'' +
                ", quantity='" + quantity + '\'' +
                ", price='" + price + '\'' +
                ", packageName='" + packageName + '\'' +
                ", quotationID='" + quotationID + '\'' +
                ", roomName='" + roomName + '\'' +
                '}';
    }
}
