package com.wify.erp.repository;

import com.wify.erp.NewPojo.Client;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ClientRepository extends MongoRepository<Client,Integer> {

    public List<Client> findAllByCompanyID(String id);

    public List<Client> findAllByCompanyIDNot (String id);

    public Client deleteById (String id);

    public Client findById(String id);

    public Boolean existsById(String id);

    public List<Client> findAllByEmpId (String id);
}
