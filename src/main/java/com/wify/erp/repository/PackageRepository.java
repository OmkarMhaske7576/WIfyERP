package com.wify.erp.repository;

import com.wify.erp.NewPojo.Packages;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PackageRepository extends MongoRepository<Packages, Integer> {

    public Packages findByName(String name);

    public Packages findById(String id);

    public String deleteById(String id);

}
