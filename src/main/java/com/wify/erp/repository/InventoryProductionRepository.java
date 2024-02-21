package com.wify.erp.repository;

import com.wify.erp.NewPojo.Inventory_production;
import org.springframework.data.mongodb.core.MongoAdminOperations;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InventoryProductionRepository extends MongoRepository<Inventory_production,Integer> {

    public List<Inventory_production> findAllByCategory(String category);

    public Inventory_production findByRequest(String request);

    public Inventory_production findById(String id);

    public String deleteById(String id);

    public String deleteByRequest(String request);

    public String deleteByCode(String code);

}
