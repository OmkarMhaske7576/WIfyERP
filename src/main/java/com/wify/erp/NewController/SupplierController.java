package com.wify.erp.NewController;


import com.wify.erp.NewPojo.Supplier;
import com.wify.erp.repository.SupplierRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Optional;
import java.util.Random;
import java.util.stream.Collectors;

@Controller
public class SupplierController {

    @Autowired
    private SupplierRepository supplierRepository;

    @RequestMapping("/supplierlist")
    public String supplierlist(ModelMap model) {

        try {

            model.addAttribute("suppliers", supplierRepository.findAll());

//            addMultipleSuppliers();

        }
        catch (Exception e) {

            e.printStackTrace();
        }

        return "/supplierlist";
    }

    @RequestMapping("/addSupplier/{type}/{updatekey}")
    public String addclient(ModelMap model, @PathVariable String type, @PathVariable String updatekey) {

        int suppliercnt;

        try {

            if (type.equals("add")) {

                model.addAttribute("type", "add");

                model.addAttribute("supplier" , new Supplier());

                suppliercnt = supplierRepository.findAll().size();

                suppliercnt++;

                model.addAttribute("size",suppliercnt);

            }

            if (type.equals("edit")) {

                model.addAttribute("type", "edit");

                model.addAttribute("supplier" ,supplierRepository.findById(updatekey));

            }
        }
        catch (Exception e) {

            e.printStackTrace();
        }

        return "addSupplier";
    }

    @RequestMapping("/addSupplierForm")
    public String addsupplier(@RequestParam MultiValueMap<String, String> parameters){

        try {

            String id = ObjectId.get().toString();

            Supplier supplier =new Supplier(id,
                    parameters.get("name").get(0),
                    parameters.get("mobile").get(0),
                    parameters.get("address").get(0),
                    parameters.get("pincode").get(0),
                    parameters.get("city").get(0),
                    parameters.get("state").get(0),
                    parameters.get("country").get(0),
                    parameters.get("goods").get(0));

            supplierRepository.save(supplier);
        }
        catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/supplierlist";
    }

    @RequestMapping("/updateSupplierForm/{updatekey}")
    public String updatesupplier(@RequestParam MultiValueMap<String, String> parameters,@PathVariable String updatekey){

        try {

            Supplier supplier =new Supplier(parameters.get("id").get(0),
                    parameters.get("name").get(0),
                    parameters.get("mobile").get(0),
                    parameters.get("address").get(0),
                    parameters.get("pincode").get(0),
                    parameters.get("city").get(0),
                    parameters.get("state").get(0),
                    parameters.get("country").get(0),
                    parameters.get("goods").get(0));

            supplierRepository.save(supplier);
        }
        catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/supplierlist";
    }

    @RequestMapping("/deleteSupplier/{deletekey}")
    public String deletesupplier(@PathVariable String deletekey) {

        try {

          supplierRepository.deleteById(deletekey);
        }
        catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/supplierlist";
    }


}
