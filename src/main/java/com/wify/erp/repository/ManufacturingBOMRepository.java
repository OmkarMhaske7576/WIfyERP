package com.wify.erp.repository;

import com.wify.erp.NewPojo.ManufacturingBOM;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ManufacturingBOMRepository extends MongoRepository<ManufacturingBOM,Integer> {

    public List<ManufacturingBOM> findAllByProductCode(String productCode);

    public String deleteByProductCode(String ProductCode);

    public String deleteByCode(String ProductCode);

    public ManufacturingBOM findById (String id);

    public String deleteById(String id);
}
