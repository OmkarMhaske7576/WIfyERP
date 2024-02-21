package com.wify.erp.pojo;

public class InstallerImage {

    String aadhar_url_frontPage;
    String aadhar_url_backPage;
    String pan_url;

    public InstallerImage(String aadhar_url_frontPage, String aadhar_url_backPage, String pan_url) {
        this.aadhar_url_frontPage = aadhar_url_frontPage;
        this.aadhar_url_backPage = aadhar_url_backPage;
        this.pan_url = pan_url;
    }

    public InstallerImage() {
        this.aadhar_url_frontPage = "";
        this.aadhar_url_backPage = "";
        this.pan_url = "";
    }

    public String getAadhar_url_frontPage() {
        return aadhar_url_frontPage;
    }

    public void setAadhar_url_frontPage(String aadhar_url_frontPage) {
        this.aadhar_url_frontPage = aadhar_url_frontPage;
    }

    public String getAadhar_url_backPage() {
        return aadhar_url_backPage;
    }

    public void setAadhar_url_backPage(String aadhar_url_backPage) {
        this.aadhar_url_backPage = aadhar_url_backPage;
    }

    public String getPan_url() {
        return pan_url;
    }

    public void setPan_url(String pan_url) {
        this.pan_url = pan_url;
    }
}
