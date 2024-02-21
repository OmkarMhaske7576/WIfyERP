package com.wify.erp.pojo;

public class ProductionRequestDesign {
    String production_request;
    String pcb_production;
    String raw_component;
    String mounting;
    String node_mcu;
    String node_mcu_mounting;
    String testing;
    String box_packaging;
    String warehouse;

    public ProductionRequestDesign() {
    }

    public String getProduction_request() {
        return production_request;
    }

    public void setProduction_request(String production_request) {
        this.production_request = production_request;
    }

    public String getPcb_production() {
        return pcb_production;
    }

    public void setPcb_production(String pcb_production) {
        this.pcb_production = pcb_production;
    }

    public String getRaw_component() {
        return raw_component;
    }

    public void setRaw_component(String raw_component) {
        this.raw_component = raw_component;
    }

    public String getMounting() {
        return mounting;
    }

    public void setMounting(String mounting) {
        this.mounting = mounting;
    }

    public String getNode_mcu() {
        return node_mcu;
    }

    public void setNode_mcu(String node_mcu) {
        this.node_mcu = node_mcu;
    }

    public String getNode_mcu_mounting() {
        return node_mcu_mounting;
    }

    public void setNode_mcu_mounting(String node_mcu_mounting) {
        this.node_mcu_mounting = node_mcu_mounting;
    }

    public String getTesting() {
        return testing;
    }

    public void setTesting(String testing) {
        this.testing = testing;
    }

    public String getBox_packaging() {
        return box_packaging;
    }

    public void setBox_packaging(String box_packaging) {
        this.box_packaging = box_packaging;
    }

    public String getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(String warehouse) {
        this.warehouse = warehouse;
    }

    public ProductionRequestDesign(String production_request, String pcb_production, String raw_component, String mounting, String node_mcu, String node_mcu_mounting, String testing, String box_packaging, String warehouse) {
        this.production_request = production_request;
        this.pcb_production = pcb_production;
        this.raw_component = raw_component;
        this.mounting = mounting;
        this.node_mcu = node_mcu;
        this.node_mcu_mounting = node_mcu_mounting;
        this.testing = testing;
        this.box_packaging = box_packaging;
        this.warehouse = warehouse;
    }

}
