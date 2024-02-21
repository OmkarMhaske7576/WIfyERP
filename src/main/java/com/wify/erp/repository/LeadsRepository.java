package com.wify.erp.repository;

import com.wify.erp.NewPojo.Leads;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LeadsRepository extends MongoRepository<Leads,Integer> {

    public List<Leads> findAllByLeadBy (String id);

    public List<Leads> findAllByLeadByAndCategory (String id,String category);

    public List<Leads> findAllBySalesEmpIDAndCategory (String salesID,String category);

    public List<Leads> findAllByCategory (String id);

    public List<Leads> findAllByCategoryAndCaptureBy(String id,String capture);

    public List<Leads> findAllByLeadByAndCategoryOrCaptureBy (String id,String category,String capture);

    public Leads findById (String id);

    public String deleteById(String id);

    public Boolean existsById(String id);

    public List<Leads> findAllBySalesEmpID(String id);

}
