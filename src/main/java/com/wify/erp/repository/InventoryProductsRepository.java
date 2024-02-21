package com.wify.erp.repository;

import com.wify.erp.NewPojo.Inventory_Products;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InventoryProductsRepository extends MongoRepository<Inventory_Products,Integer> {

    public List<Inventory_Products> findAllByCategory(String category);

    public String deleteByProductCode(String category);

    public Inventory_Products findByProductCode(String category);

    public Inventory_Products findByName(String name);

    public Inventory_Products findById(String id);

    public Inventory_Products findByNameContains(String name);

}