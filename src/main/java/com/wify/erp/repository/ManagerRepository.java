package com.wify.erp.repository;

import com.wify.erp.NewPojo.Manager;
import com.wify.erp.NewPojo.SalesPartner;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ManagerRepository extends MongoRepository<Manager, Integer> {

    public Manager findById(String id);

    public List<Manager> findAllByCompanyID(String companyID);

    public Manager findByEmail(String email);

    public Boolean existsByEmail(String email);
}
