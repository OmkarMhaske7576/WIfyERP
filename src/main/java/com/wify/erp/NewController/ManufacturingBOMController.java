package com.wify.erp.NewController;

import com.wify.erp.NewPojo.Inventory_Products;
import com.wify.erp.NewPojo.ManufacturingBOM;
import com.wify.erp.NewPojo.SalesEmployee;
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

import java.util.*;
import java.util.stream.Collectors;

@Controller
public class ManufacturingBOMController {

    @Autowired
    public InventoryProductsRepository inventoryProductsRepository;

    @Autowired
    public ManufacturingBOMRepository manufacturingBOMRepository;

    @RequestMapping("/getManufacturingBOM")
    public String getManufacturingBOM(ModelMap model) {

        List<Inventory_Products> list;

        List<ManufacturingBOM> list1;

        List<Inventory_Products> list2;

        HashMap<String, Float> map = new HashMap<>();

        try {

            model.addAttribute("products", inventoryProductsRepository.findAllByCategory("Product"));

            list = new ArrayList<>(inventoryProductsRepository.findAllByCategory("Product"));

            ListIterator<Inventory_Products> iterator = list.listIterator();

            while (iterator.hasNext()) {

                float updatePrice = 0;

                Inventory_Products item = iterator.next();

                String productCode = item.getProductCode();

                list1 = new ArrayList<>(manufacturingBOMRepository.findAllByProductCode(productCode));

                ListIterator<ManufacturingBOM> iterator1 = list1.listIterator();

                while (iterator1.hasNext()) {

                    ManufacturingBOM bom = iterator1.next();

                    String rawProductCode = bom.getCode();

                    int rawProductQuantity = Integer.parseInt(bom.getQuantity());

                    list2 = new ArrayList<>(inventoryProductsRepository.findAllByCategory("Raw"));

                    ListIterator<Inventory_Products> iterator2 = list2.listIterator();

                    while (iterator2.hasNext()) {

                        Inventory_Products products = iterator2.next();

                        if (rawProductCode.equalsIgnoreCase(products.getProductCode())) {

                            updatePrice = updatePrice + Float.parseFloat(products.getPrice()) * rawProductQuantity;

                        }

                    }
                }

                map.put(productCode,updatePrice);

            }

            model.addAttribute("manufacturingCost", map);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "manufacturingList";
    }

    @RequestMapping("/productBOMlist/{productCode}")
    public String productBOMlist(ModelMap model, @PathVariable String productCode) {

        try {

            model.addAttribute("productCode",productCode);

            model.addAttribute("productName",findProductName(productCode));

            model.addAttribute("pbom", manufacturingBOMRepository.findAllByProductCode(productCode));

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "manufacturingBOMList";
    }

    @RequestMapping("addManufacturingBOM/{type}/{updatekey}/{productCode}")
    public String productBOM(ModelMap model, @PathVariable String type, @PathVariable String updatekey, @PathVariable String productCode) {

        int count;

        try {

            model.addAttribute("productsbomrawmaterial", getNamesOnly());

            model.addAttribute("productCode",productCode);

            model.addAttribute("productName",findProductName(productCode));

            if (type.equals("add")) {

                model.addAttribute("type", "add");

                model.addAttribute("productBOM", new ManufacturingBOM());

                count = manufacturingBOMRepository.findAll().size();

                count++;

                model.addAttribute("size", count);
            }

            if (type.equals("edit")) {

                model.addAttribute("type", "edit");

                model.addAttribute("productBOM", manufacturingBOMRepository.findById(updatekey));

            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "addManufacturingBOM";
    }

    @RequestMapping("/addManufacturingBOMForm")
    public String addManufacturingBOMForm(@RequestParam MultiValueMap<String, String> parameters) {

        try {

            String id = ObjectId.get().toString();

            ManufacturingBOM bom = new ManufacturingBOM(
                    id,
                    parameters.get("name").get(0),
                    parameters.get("code").get(0),
                    parameters.get("quantity").get(0),
                    parameters.get("productCode").get(0));

            manufacturingBOMRepository.save(bom);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/productBOMlist/" + parameters.get("productCode").get(0);
    }

    @RequestMapping("/updateManufacturingBOMForm/{updatekey}")
    public String updateManufacturingBOMForm(@RequestParam MultiValueMap<String, String> parameters, @PathVariable String updatekey) {

        try {

            ManufacturingBOM bom = new ManufacturingBOM(
                    parameters.get("id").get(0),
                    parameters.get("name").get(0),
                    parameters.get("code").get(0),
                    parameters.get("quantity").get(0),
                    parameters.get("productCode").get(0));

            manufacturingBOMRepository.save(bom);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/productBOMlist/" + parameters.get("productCode").get(0);
    }

    @RequestMapping("/deleteManufacturingBOM/{id}/{productCode}")
    public String deleteproductbom(@PathVariable String id, @PathVariable String productCode) {

        try {

            manufacturingBOMRepository.deleteById(id);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/productBOMlist/" + productCode;
    }

    @ResponseBody
    @RequestMapping(value = "/getitemid")
    public String getitemid(@RequestParam String name) {

        String code = null;

        try {

            Inventory_Products p = inventoryProductsRepository.findByName(name);

            code = p.getProductCode();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return code;
    }

    public String findProductName(String id){

        String name = null;
        try{

            Inventory_Products products = inventoryProductsRepository.findByProductCode(id);

            name = products.getName();
        }
        catch (Exception e){

            e.printStackTrace();
        }
        return name;
    }

    public List<String> getNamesOnly(){

        return inventoryProductsRepository.findAllByCategory("Raw")
                .stream()
                .map(Inventory_Products::getName)
                .collect(Collectors.toList());
    }
}