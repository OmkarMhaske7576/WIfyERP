package com.wify.erp.repository;

import com.wify.erp.NewPojo.Quotation;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuotationRepository extends MongoRepository<Quotation,Integer> {

    public List<Quotation> findAllByClientId(String id);

    public Quotation findByClientId(String id);

    public Quotation findById(String id);

}
