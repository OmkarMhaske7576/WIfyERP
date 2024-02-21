package com.wify.erp.repository;

import com.wify.erp.NewPojo.Employee;
import com.wify.erp.NewPojo.SalesEmployee;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmployeeRepository extends MongoRepository<Employee,Integer> {

    public Employee findById(String id);

    public Employee findByName(String id);

    public String deleteById(String id);

    public Boolean existsByEmail(String email);

    public Employee findByEmail(String email);

}
