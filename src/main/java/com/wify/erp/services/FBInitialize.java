package com.wify.erp.services;


import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.database.FirebaseDatabase;
import com.wify.erp.ErpApplication;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.io.InputStream;

@Service
public class FBInitialize {

    @PostConstruct
    public void initialize() {
        try {

//            FileInputStream serviceAccount =
//                    new FileInputStream("src/main/resources/wifyERP_Firebase.json");

            InputStream serviceAccount = this.getClass().getResourceAsStream("/wifyERP_Firebase.json");

            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .setDatabaseUrl("https://wifyerp-1febf-default-rtdb.firebaseio.com")
                    .build();

            FirebaseApp.initializeApp(options);

            FirebaseApp FirebaseApp = com.google.firebase.FirebaseApp.getInstance();

            ErpApplication.firebaseDatabase = FirebaseDatabase.getInstance(FirebaseApp);

           // FirebaseUtility.getInventory();

        }
        catch (Exception e) {

            e.printStackTrace();
        }
    }

}

