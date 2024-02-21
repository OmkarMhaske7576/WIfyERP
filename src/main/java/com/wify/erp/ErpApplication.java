package com.wify.erp;

import com.google.firebase.database.FirebaseDatabase;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

import java.util.List;

@EnableAsync
@SpringBootApplication
public class ErpApplication {

    public static FirebaseDatabase firebaseDatabase = null;

    public static void main(String[] args) {

        SpringApplication.run(ErpApplication.class, args);

//        System.out.println(">>>>>>>>>>>>>>>     Application Start    >>>>>>>>>>>");

//        FirebaseUtility.getSalesPartnerList();
//
//        FirebaseUtility.getBusinessClient();
//
//        FirebaseUtility.getBusinessInstallers();
//
//        FirebaseUtility.getBusinessInstallerClients();
//
//        FirebaseUtility.getOrder();
//
//        FirebaseUtility.getquotation();
//
//        FirebaseUtility.getpackagedata();
//
//        FirebaseUtility.getpackageBOMlist();
//
//        //FirebaseUtility.getemployees();
//
//        FirebaseUtility.getQuotationBOMlist();
//
//        FirebaseUtility.getBOMlist();
//
//        FirebaseUtility.getData();
//
//        FirebaseUtility.getInstallers();
//
//        FirebaseUtility.getInventoryProduction();

       // FirebaseUtility.getSuppliers();

//        FirebaseUtility.getInventoryItemRawMaterials();
//
//        FirebaseUtility.getWarehousestockProducts();
//
//        FirebaseUtility.getWarehouseStockAdded();
//
//        FirebaseUtility.getInventoryRawProduction();
//
//        FirebaseUtility.getFlagCount();
//
//        FirebaseUtility.getTransactions();

//        FirebaseUtility.getInstallerImageData();
    }

}