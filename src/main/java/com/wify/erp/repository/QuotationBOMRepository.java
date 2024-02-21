package com.wify.erp.repository;

import com.wify.erp.NewPojo.QuotationBOM;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuotationBOMRepository extends MongoRepository<QuotationBOM,Integer> {

    public List<QuotationBOM> findAllByQuotationID(String id);

    public List<QuotationBOM> findAllByQuotationIDAndPnameContains(String quotationId,String name);

    public QuotationBOM findById(String id);

    public Boolean existsByIdAndPnameContains(String id,String name);

    public String deleteById(String id);

    public String deleteAllByQuotationID(String quotationId);

    public List<QuotationBOM> findByQuotationID(String id);

    public Boolean existsByQuotationID(String id);

    public Boolean existsByQuotationIDAndPname(String id,String name);

    public Boolean existsByQuotationIDAndPnameAndPackageName(String id,String name,String packageName);

    public Boolean existsByQuotationIDAndRoomNameAndPnameContains(String id,String roomName,String name);

    public QuotationBOM findByQuotationIDAndPname(String id,String name);

    public String deleteByPnameContainsAndQuotationID(String name,String id);

    public List<Object> findAllByQuotationIDAndRoomNameAndPnameContains(String quotationId, String roomName, String name);

    public List<Object> findAllByQuotationIDAndRoomName(String quotationId, String roomName);

}
