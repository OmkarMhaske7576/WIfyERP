package com.wify.erp.NewController;

import com.wify.erp.repository.ClientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class SalesAppController {

    @Autowired
    private ClientRepository clientRepository;

    @ResponseBody
    @RequestMapping("/employeeSpecificClients")
    public List employeeSpecificClients(){

        try{

            System.out.println("Inside employeeSpecificClients >> ");

        }
        catch (Exception e){

            e.printStackTrace();
        }

        return clientRepository.findAllByEmpId("6426ad1b1f7fbe253b774f08");
    }
}
