package com.wify.erp.repository;

import com.wify.erp.NewPojo.WarehouseStock;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WarehouseStockRepository extends MongoRepository<WarehouseStock,Integer> {

    public List<WarehouseStock> findByProductsCode(String productsCode);

    public String deleteByProductsCode(String productsCode);
}
