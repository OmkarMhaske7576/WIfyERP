package com.wify.erp.repository;

import com.wify.erp.pojo.Transactions;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TransactionRepository extends MongoRepository<Transactions,Integer> {

    public List<Transactions> findAllByQuotationId(String quotationId);

    public Transactions findById(String id);


}
