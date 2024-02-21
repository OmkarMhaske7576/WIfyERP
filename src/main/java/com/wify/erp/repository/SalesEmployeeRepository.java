package com.wify.erp.repository;

import com.wify.erp.NewPojo.Inventory_production;
import com.wify.erp.NewPojo.SalesEmployee;
import com.wify.erp.NewPojo.SalesPartner;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SalesEmployeeRepository extends MongoRepository<SalesEmployee,Integer> {

    public List<SalesEmployee> findAllByCompanyId (String id);

    public SalesEmployee findById(String id);

    public SalesEmployee findByName(String name);

    public SalesEmployee findByEmail(String email);

    public Boolean existsByEmail(String email);

}