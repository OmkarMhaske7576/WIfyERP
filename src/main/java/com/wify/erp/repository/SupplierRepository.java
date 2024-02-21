package com.wify.erp.repository;

import com.wify.erp.NewPojo.Employee;
import com.wify.erp.NewPojo.Supplier;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SupplierRepository extends MongoRepository<Supplier, Integer> {

    public Supplier findById(String id);

    public String deleteById(String id);

    public List<Supplier> findAllByName(String name);

//    public List<Supplier findFirst10ByName(String name);

}
