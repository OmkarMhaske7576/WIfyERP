package com.wify.erp.NewPojo;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "RoomBoards")
public class RoomBoards {

    String id;
    String roomName;
    String boardName;
    String quotationID;
    int lightPoint;
    int rgb;
    int fan;
    int power;

    public RoomBoards() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getBoardName() {
        return boardName;
    }

    public void setBoardName(String boardName) {
        this.boardName = boardName;
    }

    public String getQuotationID() {
        return quotationID;
    }

    public void setQuotationID(String quotationID) {
        this.quotationID = quotationID;
    }

    public int getLightPoint() {
        return lightPoint;
    }

    public void setLightPoint(int lightPoint) {
        this.lightPoint = lightPoint;
    }

    public int getRgb() {
        return rgb;
    }

    public void setRgb(int rgb) {
        this.rgb = rgb;
    }

    public int getFan() {
        return fan;
    }

    public void setFan(int fan) {
        this.fan = fan;
    }

    public int getPower() {
        return power;
    }

    public void setPower(int power) {
        this.power = power;
    }

    public RoomBoards(String id, String roomName, String boardName, String quotationID, int lightPoint, int rgb, int fan, int power) {
        this.id = id;
        this.roomName = roomName;
        this.boardName = boardName;
        this.quotationID = quotationID;
        this.lightPoint = lightPoint;
        this.rgb = rgb;
        this.fan = fan;
        this.power = power;
    }

    @Override
    public String toString() {
        return "RoomBoards{" +
                "id='" + id + '\'' +
                ", roomName='" + roomName + '\'' +
                ", boardName='" + boardName + '\'' +
                ", quotationID='" + quotationID + '\'' +
                ", lightPoint=" + lightPoint +
                ", rgb=" + rgb +
                ", fan=" + fan +
                ", power=" + power +
                '}';
    }
}
