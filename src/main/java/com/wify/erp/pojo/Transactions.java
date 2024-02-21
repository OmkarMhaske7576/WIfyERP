package com.wify.erp.pojo;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collection = "Transactions")
public class Transactions {

    String id;
    String quotationId;
    String payment_type;
    String payment_mode;
    String amount;
    String transaction_id;
    String transaction_date;

    public Transactions() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getQuotationId() {
        return quotationId;
    }

    public void setQuotationId(String quotationId) {
        this.quotationId = quotationId;
    }

    public String getPayment_type() {
        return payment_type;
    }

    public void setPayment_type(String payment_type) {
        this.payment_type = payment_type;
    }

    public String getPayment_mode() {
        return payment_mode;
    }

    public void setPayment_mode(String payment_mode) {
        this.payment_mode = payment_mode;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getTransaction_id() {
        return transaction_id;
    }

    public void setTransaction_id(String transaction_id) {
        this.transaction_id = transaction_id;
    }

    public String getTransaction_date() {
        return transaction_date;
    }

    public void setTransaction_date(String transaction_date) {
        this.transaction_date = transaction_date;
    }

    public Transactions(String id, String quotationId, String payment_type, String payment_mode, String amount, String transaction_id, String transaction_date) {
        this.id = id;
        this.quotationId = quotationId;
        this.payment_type = payment_type;
        this.payment_mode = payment_mode;
        this.amount = amount;
        this.transaction_id = transaction_id;
        this.transaction_date = transaction_date;
    }
}
