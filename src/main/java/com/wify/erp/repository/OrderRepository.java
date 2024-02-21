package com.wify.erp.repository;

import com.wify.erp.NewPojo.Order;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends MongoRepository<Order,Integer> {

    public Boolean existsByQuotationId(String id);

    public Boolean existsByClientId(String id);

    public Boolean existsByQuotationIdAndStatus(String id,String status);

    public Order findById(String id);

    public Order findByQuotationId(String quotationId);

    public List<Order> findAllByStatus(String status);

    public List<Order> findAllByStatusOrStatusOrStatusOrStatus(String status,String status1,String status2, String status3);

    public List<Order> findAllByCompanyIDAndStatus (String id,String status);

    public List<Order> findAllByCompanyIDAndStatusNot (String id,String status);

    public List<Order> findAllByStatusNotContains(String status);

    public List<Order> findAllByCompanyID (String id);

    public List<Order> findAllByCompanyIDNot (String id);

    public List<Order> findAllByCompanyIDNotAndStatusNot (String id,String status);

    public List<Order> findAllBySalesEmpID(String id);

    public List<Order> findAllBySalesEmpIDAndStatus(String id,String status);

    public List<Order> findAllByOrderDateBetweenAndStatus(String first,String second,String status);

    public List<Order> findAllByOrderDateBetweenAndStatusAndCompanyID(String first,String second,String status,String id);

    public List<Order> findAllByClientId(String clientId);

    public List<Order> findAllByInstallerID (String id);
}
