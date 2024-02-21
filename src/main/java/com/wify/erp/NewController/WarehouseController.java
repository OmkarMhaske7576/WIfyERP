package com.wify.erp.NewController;

import com.wify.erp.NewPojo.*;
import com.wify.erp.repository.*;
import com.wify.erp.services.MethodsCalledService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.ListIterator;

@Controller
public class WarehouseController {

    @Autowired
    public MethodsCalledService methodsCalledService;

    @Autowired
    private InventoryProductsRepository inventoryProductsRepository;

    @Autowired
    private WarehouseStockRepository warehouseStockRepository;

    @Autowired
    private InventoryProductsRepository inventoryRepo;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private QuotationBOMRepository quotationBOMRepository;

    @Autowired
    private QuotationRepository quotationRepository;

    @RequestMapping("/warehouseorders")
    public String warehouseorders(ModelMap modelMap) {

        List<Order> list;

        List<QuotationBOM> list1;

        HashMap<String, String> hashmap = new HashMap<>();

        String orderQuantity;

        try {

            modelMap.addAttribute("orderlist", orderRepository.findAllByStatusOrStatusOrStatusOrStatus("New", "Preparing", "Ready to install", "Shipped"));

            list = orderRepository.findAllByStatus("New");

            ListIterator<Order> iterator = list.listIterator();

            while (iterator.hasNext()) {

                Order order = iterator.next();

                Quotation quotation = quotationRepository.findById(order.getQuotationId());

                orderQuantity = quotation.getOrderQuantity();

                list1 = methodsCalledService.hideMultipleProducts(order.getQuotationId());

                ListIterator<QuotationBOM> iterator1 = list1.listIterator();

                int availableCount = 0;

                int unAvailableCount = 0;

                while (iterator1.hasNext()) {

                    QuotationBOM bom = iterator1.next();

                    Inventory_Products products = inventoryProductsRepository.findByProductCode(bom.getPcode());

                    if (Integer.parseInt(products.getStock()) >= Integer.parseInt(bom.getQuantity()) * Integer.parseInt(orderQuantity)) {

                        availableCount++;

                    } else {

                        unAvailableCount++;
                    }
                }

                if (unAvailableCount > 0) {

                    hashmap.put(order.getId(), "Stock unAvailable");
                } else {

                    hashmap.put(order.getId(), "Stock Available");
                }

            }

            modelMap.addAttribute("hashmap", hashmap);

//            System.out.println("Hashmap >>> " + hashmap);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "warehouseorders";
    }

   /* public List hideMultipleProducts(String quotationId) {

        List<QuotationBOM> list1;

        List<QuotationBOM> finalProductList = new ArrayList<>();

        list1 = quotationBOMRepository.findAllByQuotationID(quotationId);

        ListIterator iterator1 = list1.listIterator();

        while (iterator1.hasNext()) {

            QuotationBOM bom = (QuotationBOM) iterator1.next();

            if (finalProductList.size() == 0) {

                finalProductList.add(bom);

            } else {

                for (int i = 0; i < finalProductList.size(); i++) {

                    if (finalProductList.get(i).getPname().equalsIgnoreCase(bom.getPname())) {

                        int quantity = Integer.parseInt(finalProductList.get(i).getQuantity()) + Integer.parseInt(bom.getQuantity());

                        finalProductList.get(i).setQuantity(Integer.toString(quantity));

                        break;

                    } else if (!finalProductList.get(i).getPname().equalsIgnoreCase(bom.getPname()) && (finalProductList.size() - 1) == i) {

                        finalProductList.add(bom);

                        break;

                    } else {

                    }

                }

            }

        }

        return finalProductList;
    }*/

    /**
     * ------------------------------------- WareHouseStock ------------------------------------
     **/

    @RequestMapping("/warehouseStockList")
    public String warehouseStockList(ModelMap map) {

        try {

            map.addAttribute("products", inventoryProductsRepository.findAllByCategory("Product"));

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "warehouseStockList";
    }

    @RequestMapping("/addWarehouseStock/{productCode}")
    public String addPackageBOM(ModelMap modelMap, @PathVariable String productCode) {

        try {

            Inventory_Products product = inventoryProductsRepository.findByProductCode(productCode);

            modelMap.addAttribute("WarehouseStock", product);

            modelMap.addAttribute("manuallyAdded", warehouseStockRepository.findByProductsCode(productCode));

        } catch (Exception e) {

            e.printStackTrace();

        }

        return "addWarehouseStock";
    }

    @RequestMapping("/updateInventoryProductsForm")
    public String updateInventoryProductsForm(@RequestParam MultiValueMap<String, String> parameters) {

        System.out.println(" Inside Warehouse Controller");

        try {

            Inventory_Products i = new Inventory_Products(parameters.get("id").get(0),
                    parameters.get("productCode").get(0),
                    parameters.get("name").get(0),
                    parameters.get("stock").get(0),
                    parameters.get("price").get(0),
                    parameters.get("stockAlert").get(0),
                    parameters.get("category").get(0)
            );

            inventoryRepo.save(i);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/warehouseStockList";

    }

    @RequestMapping("/addSeprateStockForm")
    public String addSeprateStock(@RequestParam MultiValueMap<String, String> parameters) {

        int count;

        int updateStock;

        String productCode;

        try {

            count = warehouseStockRepository.findAll().size();

            count++;

            productCode = parameters.get("productsCode").get(0);

            WarehouseStock i = new WarehouseStock(
                    count,
                    parameters.get("date").get(0),
                    parameters.get("stocks").get(0),
                    parameters.get("comment").get(0),
                    parameters.get("productsCode").get(0)
            );

            warehouseStockRepository.save(i);

            Inventory_Products products = inventoryProductsRepository.findByProductCode(productCode);

            updateStock = Integer.parseInt(products.getStock()) + Integer.parseInt(parameters.get("stocks").get(0));

            products.setStock(Integer.toString(updateStock));

            inventoryProductsRepository.save(products);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/warehouseStockList";
    }

    /**
     * --------------------------------- Required Modules ----------------------------------
     **/

    @RequestMapping("/requiredModules")
    public String requiredModules(ModelMap map) {

        List<Order> orderList;

        List<QuotationBOM> list1;

        List<QuotationBOM> finalProductList = new ArrayList<>();

        HashMap<String ,String> hashMap = new HashMap<>();

        List<Inventory_Products> products;

        int orderQuantity;

        try {

            orderList = orderRepository.findAllByStatus("New");

            ListIterator<Order> iterator = orderList.listIterator();

            while (iterator.hasNext()) {

                Order order = iterator.next();

                Quotation quotation = quotationRepository.findById(order.getQuotationId());

                orderQuantity = Integer.parseInt(quotation.getOrderQuantity());

                list1 = quotationBOMRepository.findAllByQuotationID(order.getQuotationId());

                ListIterator iterator1 = list1.listIterator();

                while (iterator1.hasNext()) {

                    QuotationBOM bom = (QuotationBOM) iterator1.next();

                    int q = Integer.parseInt(bom.getQuantity()) * orderQuantity;

                    bom.setQuantity(Integer.toString(q));

                    if (finalProductList.size() == 0) {

                        finalProductList.add(bom);

                    } else {

                        for (int i = 0; i < finalProductList.size(); i++) {

                            if (finalProductList.get(i).getPname().equalsIgnoreCase(bom.getPname()) && !bom.getPname().contains("Controller")) {

                                int quantity = Integer.parseInt(finalProductList.get(i).getQuantity()) + Integer.parseInt(bom.getQuantity());

                                finalProductList.get(i).setQuantity(Integer.toString(quantity));

                                break;

                            }
                            else if (!finalProductList.get(i).getPname().equalsIgnoreCase(bom.getPname()) && (finalProductList.size() - 1) == i) {

                                finalProductList.add(bom);

                                break;

                            }
                            else {

                            }

                        }

                    }

                }
            }

            map.addAttribute("orderlist",finalProductList);

            System.out.println("finalProductList >> "+ finalProductList);

            products = inventoryProductsRepository.findAllByCategory("Product");

            ListIterator<Inventory_Products> iterator1 = products.listIterator();

            while(iterator1.hasNext()){

                Inventory_Products p = iterator1.next();

                hashMap.put(p.getProductCode(),p.getStock());

            }

            System.out.println("hashMap >> "+ hashMap);

            map.addAttribute("hashmap",hashMap);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "requiredModules";
    }

    /*public StringBuilder checkForModulesAvailable(String id) {

        ControllerPojo controllerPojo = null;

        StringBuilder builder = new StringBuilder();

        try {

            controllerPojo = (ControllerPojo) quotationBOMRepository.findById(id);

            Inventory_Products products = inventoryProductsRepository.findByNameContains("Controller Generic");

            if (Integer.parseInt(products.getStock()) > controllerPojo.getGeneric()){

                System.out.println("Stock available >> ");

                builder.append("Generic = Available");

            }
            else
            {

                System.out.println("Stock unAvailable >> ");

                builder.append("Generic = Unavailable");

            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return builder;
    }*/

}