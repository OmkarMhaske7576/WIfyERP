package com.wify.erp.NewController;

import com.wify.erp.NewPojo.Inventory_Products;
import com.wify.erp.NewPojo.PackageBOM;
import com.wify.erp.repository.*;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
public class InventoryController {

    @Autowired
    private InventoryProductsRepository inventoryRepo;

    @Autowired
    private InventoryProductionRepository inventoryProductionRepository;

    @Autowired
    private ManufacturingBOMRepository manufacturingBOMRepository;

    @Autowired
    private PackageBOMRepository packageBOMRepository;

    @Autowired
    private WarehouseStockRepository warehouseStockRepository;

    @RequestMapping("/inventory_item_productList")
    public String inventory_item_productList(ModelMap model){

        try {

//            System.out.println(" --------> "+ inventoryRepo.find());

            model.addAttribute("inventory", inventoryRepo.findAllByCategory("Product"));
        }
        catch (Exception e) {

            e.printStackTrace();
        }

        return "inventory_item_productList";
    }

    @RequestMapping("/inventory_item_rawMaterialList")
    public String inventory_item_rawMaterialList(ModelMap model){

        try {

            model.addAttribute("inventory", inventoryRepo.findAllByCategory("Raw"));
        }
        catch (Exception e) {

            e.printStackTrace();
        }

        return "inventory_item_rawMaterialList";
    }

    @RequestMapping("/addInventoryProducts/{type}/{key}/{category}")
    public String addPackageBOM(ModelMap modelMap, @PathVariable String type, @PathVariable String key,@PathVariable String category) {

        int count;

        int productCount;

        String productCode = null;

        try {

            if (type.equals("add")) {

                modelMap.addAttribute("type", "add");

                modelMap.addAttribute("WarehouseStock", new Inventory_Products());

                modelMap.addAttribute("category",category);

                System.out.println("category >> "+ category);

                count = inventoryRepo.findAll().size();

                count++;

                modelMap.addAttribute("size",count);

                productCount = inventoryRepo.findAllByCategory(category).size(); 

                productCount++;

                if(productCount<10){

                    if (category.equalsIgnoreCase("Product")){

                        productCode = "P" +"_"+0+productCount;
                    }
                    else if(category.equalsIgnoreCase("Raw")){

                        productCode = "R" +"_"+0+productCount;
                    }
                }
                else
                {

                    if (category.equalsIgnoreCase("Product")){

                        productCode = "P" +"_"+productCount;
                    }
                    else if(category.equalsIgnoreCase("Raw")){

                        productCode = "R" +"_"+productCount;
                    }
                }

                modelMap.addAttribute("productCode",productCode);

            }

            if (type.equals("edit")) {

                modelMap.addAttribute("type", "edit");

                modelMap.addAttribute("WarehouseStock", inventoryRepo.findById(key));

                modelMap.addAttribute("category",category);

                System.out.println(" ------------> "+ category);

            }

        } catch (Exception e) {

            e.printStackTrace();
        }

            return "addInventoryProducts";
    }

    @RequestMapping("/addInventoryProductsForm")
    public String addWarehouseStockForm(@RequestParam MultiValueMap<String, String> parameters) {

        try {

            String id = ObjectId.get().toString();

            Inventory_Products i = new Inventory_Products(id,
                    parameters.get("productCode").get(0),
                    parameters.get("name").get(0).trim(),
                    parameters.get("stock").get(0),
                    parameters.get("price").get(0),
                    parameters.get("stockAlert").get(0),
                    parameters.get("category").get(0)
            );

            inventoryRepo.save(i);

        } catch (Exception e) {

            e.printStackTrace();
        }

        if (parameters.get("category").get(0).equalsIgnoreCase("Product")){

            return "redirect:/inventory_item_productList";
        }
        else{

            return "redirect:/inventory_item_rawMaterialList";

        }
    }

    @RequestMapping("/updateInventoryProductsForm/{type}")
    public String updateInventoryProductsForm(@RequestParam MultiValueMap<String, String> parameters,@PathVariable String type) {

        try {

            Inventory_Products i = new Inventory_Products(
                    parameters.get("id").get(0),
                    parameters.get("productCode").get(0),
                    parameters.get("name").get(0).trim(),
                    parameters.get("stock").get(0),
                    parameters.get("price").get(0),
                    parameters.get("stockAlert").get(0),
                    parameters.get("category").get(0)
            );

            inventoryRepo.save(i);

        } catch (Exception e) {

            e.printStackTrace();
        }

        if (type.equalsIgnoreCase("Product")){

            return "redirect:/inventory_item_productList";
        }
        else if (type.equalsIgnoreCase("Raw")){

            return "redirect:/inventory_item_rawMaterialList";
        }
        else if (type.equalsIgnoreCase("Warehouse")){

            return "redirect:/warehouseStockList";
        }
        else{

            return "redirect:/finance_productlist";
        }
    }

    @RequestMapping("/delete_Inventory_Item_Product/{id}/{category}")
    public String delete_Inventory_Item_Product(@PathVariable String id,@PathVariable String category) {

        try {

            inventoryRepo.deleteByProductCode(id);

            inventoryProductionRepository.deleteByCode(id);

            if (category.equalsIgnoreCase("Product")){

                manufacturingBOMRepository.deleteByProductCode(id);

                packageBOMRepository.deleteByCode(id);

                warehouseStockRepository.deleteByProductsCode(id);
            }
            else{

                manufacturingBOMRepository.deleteByCode(id);

            }
        }
        catch (Exception e) {

            e.printStackTrace();
        }

        if (category.equalsIgnoreCase("Product")){

            return "redirect:/inventory_item_productList";
        }
        else{

            return "redirect:/inventory_item_rawMaterialList";
        }
    }
}
