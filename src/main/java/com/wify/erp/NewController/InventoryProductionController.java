package com.wify.erp.NewController;

import com.wify.erp.NewPojo.Inventory_Products;
import com.wify.erp.NewPojo.Inventory_production;
import com.wify.erp.NewPojo.ManufacturingBOM;
import com.wify.erp.repository.InventoryProductionRepository;
import com.wify.erp.repository.InventoryProductsRepository;
import com.wify.erp.repository.ManufacturingBOMRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.ListIterator;
import java.util.stream.Collectors;

@Controller
public class InventoryProductionController {

    @Autowired
    public InventoryProductionRepository inventoryProductionRepository;

    @Autowired
    public InventoryProductsRepository inventoryProductsRepository;

    @Autowired
    public ManufacturingBOMRepository manufacturingBOMRepository;

    /**
     * ------------------- Products Production Requests --------------------
     **/

    @RequestMapping("/inventoryProductionlist/{value}")
    public String inventoryProductionlist(ModelMap model, @PathVariable String value) {

        List<Inventory_production> list1;

        List<ManufacturingBOM> list2;

        HashMap<String, String> map = new HashMap<>();

        try {

            model.addAttribute("value", value);

            model.addAttribute("iproduction", inventoryProductionRepository.findAllByCategory("Product"));

            list1 = inventoryProductionRepository.findAllByCategory("Product");

            ListIterator<Inventory_production> iterator1 = list1.listIterator();

            while (iterator1.hasNext()) {

                Inventory_production production = iterator1.next();

                String productCode = production.getCode();

                if (production.getStatus().equalsIgnoreCase("New")) {

                    int requestQuantity = Integer.parseInt(production.getQuantity());

                    int availableCount = 0;

                    int unAvailableCount = 0;

                    list2 = manufacturingBOMRepository.findAllByProductCode(productCode);

                    ListIterator<ManufacturingBOM> iterator2 = list2.listIterator();

                    while (iterator2.hasNext()) {

                        ManufacturingBOM bom = iterator2.next();

                        String rawProductCode = bom.getCode();

                        int rawMaterialQuantity = Integer.parseInt(bom.getQuantity());

                        Inventory_Products p1 = inventoryProductsRepository.findByProductCode(rawProductCode);

                        if (Integer.parseInt(p1.getStock()) >= (requestQuantity * rawMaterialQuantity)) {

                            availableCount++;
                        } else {

                            unAvailableCount++;
                        }

                    }

                    if (unAvailableCount > 0) {

                        map.put(productCode, "Stock unavailable");
                    } else {

                        map.put(productCode, "Stock Available");
                    }

                }

            }

            model.addAttribute("map", map);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "/inventoryProductionlist";
    }

    @RequestMapping("/addInventoryProduction/{type}/{updatekey}/{category}/{typeValue}")
    public String addInventoryProduction(ModelMap model, @PathVariable String type, @PathVariable String updatekey, @PathVariable String category, @PathVariable String typeValue) {

        int count;

        String requestId = null;

        try {

            model.addAttribute("typeValue", typeValue);

            model.addAttribute("value", typeValue);

            model.addAttribute("productsbommaterial", getNamesOnly(category));

            if (type.equals("add")) {

                model.addAttribute("type", "add");

                model.addAttribute("category", category);

                model.addAttribute("iproduction", new Inventory_production());

                int id = inventoryProductionRepository.findAll().size();

                id++;

                model.addAttribute("id", id);

                count = inventoryProductionRepository.findAllByCategory(category).size();

                count++;

                if (count < 10) {

                    if (category.equalsIgnoreCase("Product")) {

                        requestId = "PR" + "_" + 0 + count;
                    } else if (category.equalsIgnoreCase("Raw")) {

                        requestId = "RR" + "_" + 0 + count;
                    }
                } else {

                    if (category.equalsIgnoreCase("Product")) {

                        requestId = "PR" + "_" + count;
                    } else if (category.equalsIgnoreCase("Raw")) {

                        requestId = "RR" + "_" + count;
                    }
                }

                model.addAttribute("size", requestId);
            }

            if (type.equals("edit")) {

                model.addAttribute("type", "edit");

                model.addAttribute("iproduction", inventoryProductionRepository.findById(updatekey));

            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "addInventoryProduction";
    }

    @RequestMapping("/addInventoryProductionForm/{typeValue}")
    public String addInventoryProduction(@RequestParam MultiValueMap<String, String> parameters, @PathVariable String typeValue) {

        try {

            String id = ObjectId.get().toString();

            Inventory_production production = new Inventory_production(
                    id,
                    parameters.get("request").get(0),
                    parameters.get("name").get(0),
                    parameters.get("code").get(0),
                    parameters.get("quantity").get(0),
                    "New",
                    parameters.get("date").get(0),
                    parameters.get("category").get(0),
                    parameters.get("comment").get(0)
            );

            inventoryProductionRepository.save(production);
        } catch (Exception e) {

            e.printStackTrace();
        }

        if (parameters.get("category").get(0).equalsIgnoreCase("Product")) {

            return "redirect:/inventoryProductionlist/" + typeValue;

        } else {

            return "redirect:/rawRequestProductionList";
        }

    }

    @RequestMapping("/updateInventoryProductionForm/{updatekey}/{typeValue}")
    public String updateinventoryproduction(ModelMap model, @RequestParam MultiValueMap<String, String> parameters, @PathVariable String updatekey, @PathVariable String typeValue) {

        String productCode;

        int productQuantity;

        String requestID;

        List<ManufacturingBOM> list1;

        try {
            productCode = parameters.get("code").get(0);

            requestID = parameters.get("request").get(0);

            productQuantity = Integer.parseInt(parameters.get("quantity").get(0));

            Inventory_production production = new Inventory_production(
                    parameters.get("id").get(0),
                    parameters.get("request").get(0),
                    parameters.get("name").get(0),
                    parameters.get("code").get(0),
                    parameters.get("quantity").get(0),
                    parameters.get("status").get(0),
                    parameters.get("date").get(0),
                    parameters.get("category").get(0),
                    parameters.get("comment").get(0)
            );

            Inventory_production ip1 = inventoryProductionRepository.findByRequest(requestID);

            inventoryProductionRepository.save(production);

            if (parameters.get("category").get(0).equalsIgnoreCase("Product")) {

                if (!ip1.getStatus().equalsIgnoreCase("WIP") && parameters.get("status").get(0).equalsIgnoreCase("WIP")) {

                    list1 = manufacturingBOMRepository.findAllByProductCode(productCode);

                    ListIterator<ManufacturingBOM> iterator1 = list1.listIterator();

                    while (iterator1.hasNext()) {

                        ManufacturingBOM bom = iterator1.next();

                        String rawProductCode = bom.getCode();

                        int rawProductQuantity = Integer.parseInt(bom.getQuantity());

                        Inventory_Products rawObject = inventoryProductsRepository.findByProductCode(rawProductCode);

                        int currentStock = Integer.parseInt(rawObject.getStock());

                        rawObject.setStock(Integer.toString(currentStock - (productQuantity * rawProductQuantity)));

                        inventoryProductsRepository.save(rawObject);

                    }

                }
            } else {

                if (!ip1.getStatus().equalsIgnoreCase("Complete") && parameters.get("status").get(0).equalsIgnoreCase("Complete")) {

                    String requestCode = parameters.get("code").get(0);

                    int requestQuantity = Integer.parseInt(parameters.get("quantity").get(0));

                    Inventory_Products p1 = inventoryProductsRepository.findByProductCode(requestCode);

                    int finalQuantity = Integer.parseInt(p1.getStock()) + requestQuantity;

                    p1.setStock(Integer.toString(finalQuantity));

                    inventoryProductsRepository.save(p1);

                }

            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        if (parameters.get("category").get(0).equalsIgnoreCase("Product")) {

            return "redirect:/inventoryProductionlist/" + typeValue;
        }
        else {

            return "redirect:/rawRequestProductionList";
        }
    }

    @RequestMapping("/deleteInventoryProduction/{deletekey}/{category}/{typeValue}")
    public String deleteinventoryproduction(@PathVariable String deletekey, @PathVariable String category, @PathVariable String typeValue) {

        try {

            inventoryProductionRepository.deleteById(deletekey);

        } catch (Exception e) {

            e.printStackTrace();
        }

        if (category.equalsIgnoreCase("Product")) {

            return "redirect:/inventoryProductionlist/" + typeValue;
        }
        else {

            return "redirect:/rawRequestProductionList";
        }
    }

    @ResponseBody
    @RequestMapping(value = "/getinventoryitemid")
    public String getinventoryitemid(@RequestParam String name) {

        String code = null;

        try {

            Inventory_Products products = inventoryProductsRepository.findByName(name);

            code = products.getProductCode();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return code;
    }

    @RequestMapping("productionrequestBOM/{pcode}/{quantity}/{productname}/{values}/{requestStatus}")
    public String productionrequestBOM(ModelMap modelMap, @PathVariable String pcode, @PathVariable String quantity, @PathVariable String productname, @PathVariable String values, @PathVariable String requestStatus) {

        List<ManufacturingBOM> list1;

        HashMap<String, String> map = new HashMap<>();

        try {

            modelMap.addAttribute("productCode", pcode);

            modelMap.addAttribute("quantity", Integer.parseInt(quantity));

            modelMap.addAttribute("productname", productname);

            modelMap.addAttribute("values", values);

            modelMap.addAttribute("requestStatus", requestStatus);

            modelMap.addAttribute("BomRequest", manufacturingBOMRepository.findAllByProductCode(pcode));

            if (requestStatus.equalsIgnoreCase("New")) {

                list1 = manufacturingBOMRepository.findAllByProductCode(pcode);

                ListIterator<ManufacturingBOM> iterator1 = list1.listIterator();

                while (iterator1.hasNext()) {

                    ManufacturingBOM bom = iterator1.next();

                    String rawCode = bom.getCode();

                    int rawQuantity = Integer.parseInt(bom.getQuantity());

                    Inventory_Products products = inventoryProductsRepository.findByProductCode(rawCode);

                    int totalQuantity = Integer.parseInt(quantity) * rawQuantity;

                    if (Integer.parseInt(products.getStock()) >= totalQuantity) {

                        map.put(rawCode, "Stock is available");
                    } else {

                        int required = totalQuantity - Integer.parseInt(products.getStock());

                        map.put(rawCode, "( " + required + " )" + " Stock required");
                    }
                }

                modelMap.addAttribute("map", map);
            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "ProductionRequestBOM";
    }




   /* @RequestMapping(value = "/productionrequest")
    public void productionrequest(@RequestParam String obj) {

        String key = "";

        String flag = "";

        String value = "";

        int index = 0;

        try {

            for (String a : obj.split(",")) {

                if (index == 0) {

                    key = a;
                }
                if (index == 1) {

                    flag = a;
                }
                if (index == 2) {

                    value = a;
                }

                index++;
            }

            InventoryProductionUtility.flag = flag;

            InventoryProductionUtility.val = Boolean.parseBoolean(value);

            InventoryProductionUtility.hashmap2.put(flag, value);
        } catch (Exception e) {

            e.printStackTrace();
        }
    }*/


   /* public HashMap<String, String> returnRawAvailability(){

        List<Inventory_production> list1;

        List<ManufacturingBOM> list2;

        HashMap<String, String> map = new HashMap<>();

        try{

            list1 = inventoryProductionRepository.findAllByCategory("Product");

            ListIterator<Inventory_production> iterator1 = list1.listIterator();

            while (iterator1.hasNext()){

                Inventory_production production = iterator1.next();

                String productCode = production.getCode();

                if (production.getStatus().equalsIgnoreCase("New")){

                    int requestQuantity = Integer.parseInt(production.getQuantity());

                    System.out.println("Product name >>>> "+ production.getName() + " size >> "+ requestQuantity);

                    int availableCount = 0;

                    int unAvailableCount = 0;

                    list2 = manufacturingBOMRepository.findAllByProductCode(productCode);

                    ListIterator<ManufacturingBOM> iterator2 = list2.listIterator();

                    while(iterator2.hasNext()){

                        ManufacturingBOM bom = iterator2.next();

                        String rawProductCode = bom.getCode();

                        System.out.println("Raw Product name >>>> "+bom.getName() + " size >> "+ bom.getQuantity());

                        int rawMaterialQuantity = Integer.parseInt(bom.getQuantity());

                        Inventory_Products p1 = inventoryProductsRepository.findByProductCode(rawProductCode);

                        if (Integer.parseInt(p1.getStock()) >= (requestQuantity * rawMaterialQuantity)){

                            System.out.println(" Available >>>>>>>>>>>>>> " + (requestQuantity * rawMaterialQuantity));

                            availableCount++;
                        }
                        else{

                            System.out.println(" UnAvailable ................ " + (requestQuantity * rawMaterialQuantity));

                            unAvailableCount++;
                        }

                    }

                    if (unAvailableCount > 0){

                        map.put(productCode,"Stock unavailable");
                    }
                    else{

                        map.put(productCode,"Stock Available");
                    }

                }

            }

        }
        catch (Exception e){

            e.printStackTrace();
        }

        return map;
    }*/

    /**
     * ------------------- Raw Production Requests --------------------
     **/


    @RequestMapping("/rawRequestProductionList")
    public String rawRequestProductionList(ModelMap modelMap) {

        try {

            modelMap.addAttribute("iproduction", inventoryProductionRepository.findAllByCategory("Raw"));


        } catch (Exception e) {

            e.printStackTrace();
        }

        return "/inventoryRawProductionlist";
    }

    public List<String> getNamesOnly(String category) {

        return inventoryProductsRepository.findAllByCategory(category)
                .stream()
                .map(Inventory_Products::getName)
                .collect(Collectors.toList());
    }
}