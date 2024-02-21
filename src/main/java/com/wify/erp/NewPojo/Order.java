package com.wify.erp.NewPojo;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collection = "Orders")
public class Order {
    String id;
    String clientId;
    String clientName;
    String quotationId;
    String installerName;
    String installerID;
    String salesEmpID;
    String status;
    String estDate;
    String shipDate;
    String warrPeriod;
    String orderDate;
    String payStatus;
    String transType;
    String courierName;
    String trackingNo;
    String companyID;
    String host;
    String comment;

    public Order() {
    }

    public Order(String id, String clientId, String clientName, String quotationId, String installerName, String installerID, String salesEmpID, String status, String estDate, String shipDate, String warrPeriod, String orderDate, String payStatus, String transType, String courierName, String trackingNo, String companyID,String host, String comment) {
        this.id = id;
        this.clientId = clientId;
        this.clientName = clientName;
        this.quotationId = quotationId;
        this.installerName = installerName;
        this.installerID = installerID;
        this.salesEmpID = salesEmpID;
        this.status = status;
        this.estDate = estDate;
        this.shipDate = shipDate;
        this.warrPeriod = warrPeriod;
        this.orderDate = orderDate;
        this.payStatus = payStatus;
        this.transType = transType;
        this.courierName = courierName;
        this.trackingNo = trackingNo;
        this.companyID = companyID;
        this.host = host;
        this.comment = comment;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public String getClientName() {
        return clientName;
    }

    public void setClientName(String clientName) {
        this.clientName = clientName;
    }

    public String getQuotationId() {
        return quotationId;
    }

    public void setQuotationId(String quotationId) {
        this.quotationId = quotationId;
    }

    public String getInstallerName() {
        return installerName;
    }

    public void setInstallerName(String installerName) {
        this.installerName = installerName;
    }

    public String getInstallerID() {
        return installerID;
    }

    public void setInstallerID(String installerID) {
        this.installerID = installerID;
    }

    public String getSalesEmpID() {
        return salesEmpID;
    }

    public void setSalesEmpID(String salesEmpID) {
        this.salesEmpID = salesEmpID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getEstDate() {
        return estDate;
    }

    public void setEstDate(String estDate) {
        this.estDate = estDate;
    }

    public String getShipDate() {
        return shipDate;
    }

    public void setShipDate(String shipDate) {
        this.shipDate = shipDate;
    }

    public String getWarrPeriod() {
        return warrPeriod;
    }

    public void setWarrPeriod(String warrPeriod) {
        this.warrPeriod = warrPeriod;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getPayStatus() {
        return payStatus;
    }

    public void setPayStatus(String payStatus) {
        this.payStatus = payStatus;
    }

    public String getTransType() {
        return transType;
    }

    public void setTransType(String transType) {
        this.transType = transType;
    }

    public String getCourierName() {
        return courierName;
    }

    public void setCourierName(String courierName) {
        this.courierName = courierName;
    }

    public String getTrackingNo() {
        return trackingNo;
    }

    public void setTrackingNo(String trackingNo) {
        this.trackingNo = trackingNo;
    }

    public String getCompanyID() {
        return companyID;
    }

    public void setCompanyID(String companyID) {
        this.companyID = companyID;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id='" + id + '\'' +
                ", clientId='" + clientId + '\'' +
                ", clientName='" + clientName + '\'' +
                ", quotationId='" + quotationId + '\'' +
                ", installerName='" + installerName + '\'' +
                ", installerID='" + installerID + '\'' +
                ", salesEmpID='" + salesEmpID + '\'' +
                ", status='" + status + '\'' +
                ", estDate='" + estDate + '\'' +
                ", shipDate='" + shipDate + '\'' +
                ", warrPeriod='" + warrPeriod + '\'' +
                ", orderDate='" + orderDate + '\'' +
                ", payStatus='" + payStatus + '\'' +
                ", transType='" + transType + '\'' +
                ", courierName='" + courierName + '\'' +
                ", trackingNo='" + trackingNo + '\'' +
                ", companyID='" + companyID + '\'' +
                ", host='" + host + '\'' +
                ", comment='" + comment + '\'' +
                '}';
    }
}

