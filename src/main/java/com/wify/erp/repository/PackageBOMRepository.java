package com.wify.erp.repository;

import com.wify.erp.NewPojo.PackageBOM;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PackageBOMRepository extends MongoRepository<PackageBOM, Integer> {

    public List<PackageBOM> findAllByPackageID(String name);

//    public PackageBOM findByPackageIDAndId(String packageID, String id);

    public PackageBOM findById(String id);

    public String deleteByCode(String code);

    public String deleteById(String id);

    public String deleteByPackageID(String id);
}
