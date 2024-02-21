package com.wify.erp.NewPojo;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collection = "Quotation List")
public class Quotation {

    String id;
    String qNum;
    String clientId;
    String extraDiscount;
    String orderQuantity;
    String roomName;
    int boardCount;

    public Quotation() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getqNum() {
        return qNum;
    }

    public void setqNum(String qNum) {
        this.qNum = qNum;
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public String getExtraDiscount() {
        return extraDiscount;
    }

    public void setExtraDiscount(String extraDiscount) {
        this.extraDiscount = extraDiscount;
    }

    public String getOrderQuantity() {
        return orderQuantity;
    }

    public void setOrderQuantity(String orderQuantity) {
        this.orderQuantity = orderQuantity;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public int getBoardCount() {
        return boardCount;
    }

    public void setBoardCount(int boardCount) {
        this.boardCount = boardCount;
    }

    public Quotation(String id, String qNum, String clientId, String extraDiscount, String orderQuantity, String roomName, int boardCount) {
        this.id = id;
        this.qNum = qNum;
        this.clientId = clientId;
        this.extraDiscount = extraDiscount;
        this.orderQuantity = orderQuantity;
        this.roomName = roomName;
        this.boardCount = boardCount;
    }
}
