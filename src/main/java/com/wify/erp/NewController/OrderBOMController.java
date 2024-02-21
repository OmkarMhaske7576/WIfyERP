package com.wify.erp.NewController;

import com.wify.erp.NewPojo.*;
import com.wify.erp.repository.*;
import com.wify.erp.services.MethodsCalledService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.ListIterator;

@Controller
public class OrderBOMController {

    @Autowired
    public MethodsCalledService methodsCalledService;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private QuotationRepository quotationRepository;

    @Autowired
    private QuotationBOMRepository quotationBOMRepository;

    @Autowired
    private InventoryProductsRepository inventoryProductsRepository;

    @Autowired
    private SalesEmployeeRepository salesEmployeeRepository;

    @Autowired
    private SalesPartnerRepository salesPartnerRepository;

    @RequestMapping("/orderBOM/{quotationId}/{orderid}/{value}")
    public String orderBOM(HttpServletRequest request, ModelMap modelMap, @PathVariable String quotationId, @PathVariable String orderid, @PathVariable String value) {

        List<QuotationBOM> list;

        String orderQuantity;

        HashMap<String, String> hashmap = new HashMap<>();

        try {

            String salesEmployeeEmail = LoginController.getCookieSalesEmployeeEmail(request);

            if (salesEmployeeEmail != "") {

                modelMap.addAttribute("isSalesEmployeeLoggedIn", "true");
            }
            else{
                modelMap.addAttribute("isSalesEmployeeLoggedIn", "false");
            }

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            modelMap.addAttribute("level",salesPartner.getLevel());

            Order order = orderRepository.findById(orderid);

            SalesEmployee employee = salesEmployeeRepository.findById(order.getSalesEmpID());

            modelMap.addAttribute("employeeID",employee.getId());

            modelMap.addAttribute("employeeName",employee.getName());

            modelMap.addAttribute("clientName", order.getClientName());

            modelMap.addAttribute("status", order.getStatus());

            Quotation quotation = quotationRepository.findById(quotationId);

            orderQuantity = quotation.getOrderQuantity();

            modelMap.addAttribute("orderQuantity", quotation.getOrderQuantity());

            modelMap.addAttribute("value", value);

//            list = quotationBOMRepository.findAllByQuotationID(quotationId);

            list = methodsCalledService.hideMultipleProducts(quotationId);

            modelMap.addAttribute("orderbom", list);

            if (order.getStatus().equalsIgnoreCase("New")) {

                ListIterator<QuotationBOM> iterator = list.listIterator();

                while (iterator.hasNext()) {

                    QuotationBOM bom = iterator.next();

                    Inventory_Products products = inventoryProductsRepository.findByProductCode(bom.getPcode());

                    if (Integer.parseInt(products.getStock()) >= Integer.parseInt(bom.getQuantity()) * Integer.parseInt(orderQuantity)) {

                        hashmap.put(bom.getPcode(), "Stock is available");

                    } else {

                        int q = Integer.parseInt(bom.getQuantity()) * Integer.parseInt(orderQuantity) - Integer.parseInt(products.getStock());

                        hashmap.put(bom.getPcode(), "(" + q + ")" + " Stock Unavailable");
                    }

                }

                modelMap.addAttribute("hashmap", hashmap);

            }


        } catch (Exception e) {

            e.printStackTrace();
        }

        return "orderBOMlist";
    }

    /*public List hideMultipleProducts(String quotationId){

        List<QuotationBOM> list1;

        List<QuotationBOM> finalProductList = new ArrayList<>();

        list1 = quotationBOMRepository.findAllByQuotationID(quotationId);

        ListIterator iterator1 = list1.listIterator();

        while (iterator1.hasNext()) {

            QuotationBOM bom = (QuotationBOM) iterator1.next();

            if (finalProductList.size() == 0){

                finalProductList.add(bom);

            }
            else{

                for (int i=0; i<finalProductList.size(); i++){

                    if (finalProductList.get(i).getPname().equalsIgnoreCase(bom.getPname())){

                        int quantity = Integer.parseInt(finalProductList.get(i).getQuantity()) + Integer.parseInt(bom.getQuantity());

                        finalProductList.get(i).setQuantity(Integer.toString(quantity));

                        break;

                    }else if (!finalProductList.get(i).getPname().equalsIgnoreCase(bom.getPname()) && (finalProductList.size()-1) == i){

                        finalProductList.add(bom);

                        break;

                    }

                    else{

                    }

                }

            }

        }

        return finalProductList;
    }*/
}