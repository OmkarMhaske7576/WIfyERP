package com.wify.erp.repository;

import com.wify.erp.NewPojo.SalesPartner;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SalesPartnerRepository extends MongoRepository<SalesPartner,Integer> {

    public SalesPartner findById(String id);

    public SalesPartner findByName(String name);

    public SalesPartner findByLevel(String id);

    public SalesPartner findByEmail(String id);

    public List<SalesPartner> findAllByLevelGreaterThan(String level);

    public Boolean existsByEmail(String email);


}
