package com.wify.erp.services;

import com.wify.erp.NewPojo.Photo;
import com.wify.erp.repository.PhotoRepository;
import org.bson.BsonBinarySubType;
import org.bson.types.Binary;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Service
public class PhotoService {



    public String addPhoto(String title, MultipartFile file) throws IOException {



        return null;
    }
}
