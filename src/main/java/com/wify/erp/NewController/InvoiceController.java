package com.wify.erp.NewController;

import com.wify.erp.NewPojo.*;
import com.wify.erp.repository.*;
//import com.wify.erp.utility.FirebaseUtility;
import com.wify.erp.services.MethodsCalledService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

@Controller
public class InvoiceController {

    @Autowired
    public MethodsCalledService methodsCalledService;

    @Autowired
    private QuotationRepository quotationRepository;

    @Autowired
    private QuotationBOMRepository quotationBOMRepository;

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private PackageRepository packageRepository;

    @Autowired
    private SalesPartnerRepository salesPartnerRepository;

    @RequestMapping("/generateInvoice/{clientID}/{quotationID}/{companyId}/{type}")
    public String generateInvoice(HttpServletRequest request, ModelMap modelMap, @PathVariable String clientID, @PathVariable String quotationID, @PathVariable String companyId, @PathVariable String type) {

        List<QuotationBOM> list1;

        try {

            SalesPartner salesPartner1 = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            if (type.equalsIgnoreCase("self")){

                SalesPartner salesPartner = salesPartnerRepository.findById(companyId);

                if (salesPartner1.getLevel().equalsIgnoreCase("0")){

                    System.out.println("Apply Percentage");

                    System.out.println(salesPartner1.getPercentage());

                    modelMap.addAttribute("percentage",salesPartner1.getPercentage());

                    modelMap.addAttribute("clientdetails", salesPartner);

                    modelMap.addAttribute("companyName",salesPartner1);
                }
                else{

                    if (salesPartner.getPercentage().equals(salesPartner1.getPercentage())){

                        System.out.println("Apply Self Percentage");

                        System.out.println(salesPartner1.getPercentage());

                        modelMap.addAttribute("percentage",salesPartner1.getPercentage());

                        Object obj;

                        obj = clientRepository.findById(clientID);

                        modelMap.addAttribute("clientdetails", obj);

                        modelMap.addAttribute("companyName",salesPartner);
                    }
                    else{

                        System.out.println("Apply Digital Percentage");

                        System.out.println(Integer.parseInt(salesPartner1.getPercentage()) - Integer.parseInt(salesPartner.getPercentage()));

                        modelMap.addAttribute("percentage",Integer.parseInt(salesPartner1.getPercentage()) - Integer.parseInt(salesPartner.getPercentage()));

                        modelMap.addAttribute("clientdetails", salesPartner);

                        modelMap.addAttribute("companyName",salesPartner1);
                    }
                }

            }
            else{

                System.out.println("Inside else >>> ");

                modelMap.addAttribute("percentage","100");

                Object obj;

                obj = clientRepository.findById(clientID);

                modelMap.addAttribute("clientdetails", obj);

                SalesPartner salesPartner = salesPartnerRepository.findById(companyId);

                modelMap.addAttribute("companyName",salesPartner);
            }

            list1 = methodsCalledService.hideMultipleProducts(quotationID);

            ListIterator iterator1 = list1.listIterator();

            while (iterator1.hasNext()) {

                QuotationBOM bom = (QuotationBOM) iterator1.next();

                String packageName = bom.getPackageName();

                if (!packageName.equalsIgnoreCase("")) {

                    Packages packages = packageRepository.findByName(packageName);

                    modelMap.addAttribute("discount", packages.getDiscount());
                } else {

                    modelMap.addAttribute("discount", "0");
                }

                break;

            }

            modelMap.addAttribute("orderdetails", list1);

            Quotation quotation = quotationRepository.findById(quotationID);

            modelMap.addAttribute("extraDiscount", quotation.getExtraDiscount());

            modelMap.addAttribute("orderQuantity", quotation.getOrderQuantity());

            List<QuotationBOM> bom1 = quotationBOMRepository.findAllByQuotationID(quotationID);

            String packageName1 = null;

            for (QuotationBOM b : bom1) {

                packageName1 = b.getPackageName();

                break;

            }

            if (bom1.size() > 0) {

                if (packageName1.trim().length() > 0) {

                    Packages packages = packageRepository.findByName(packageName1);

                    modelMap.addAttribute("finalAmountOfPackage", packages.getFinalTotal());

                } else {

                    modelMap.addAttribute("finalAmountOfPackage", "0");
                }

            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "invoice";
    }

    /*@RequestMapping("/generateProFormaInvoice/{clientID}/{quotationNo}/{orderID}")
    public String generateProFormaInvoice(ModelMap modelMap, @PathVariable String clientID, @PathVariable String quotationNo, @PathVariable String orderID) {

//        System.out.println("Client Id: "+ clientID);

      *//*  String [] num = orderID.split("_");

        String num1 = num[1];

        modelMap.addAttribute("invoice_no",num1);*//*

        ArrayList<OrderBOM> arr = new ArrayList<>();

        ArrayList<OrderBOM> val;

        for (Map.Entry<String, Client> entry : FirebaseUtility.clients.entrySet()) {

            modelMap.addAttribute("CCC", entry.getValue());

//            if (entry.getValue().getClient_id().equalsIgnoreCase(clientID)){
//
//                modelMap.addAttribute("clientDetails",entry.getValue());
//            }
        }

        for (Map.Entry<String, ArrayList<OrderBOM>> entry2 : FirebaseUtility.orderBOMlist.entrySet()) {

            val = entry2.getValue();

            for (OrderBOM order : val) {

                if (entry2.getKey().equals(quotationNo)) {

                    modelMap.addAttribute("discount", entry2.getValue().get(0).getDiscount());

                    arr.add(order);
                }
            }
        }

        for (Map.Entry<String, ArrayList<Quotation>> entry : FirebaseUtility.quotationList.entrySet()) {

            for (int j = 0; j < entry.getValue().size(); j++) {

//                if (entry.getValue().get(j).getQuotation_no().equals(quotationNo)){
//
//                    System.out.println("Discount >---------->>>> "+ entry.getValue().get(j).getExtraDiscount());
//
////                        extraDiscount = entry.getValue().get(j).getExtraDiscount();
//
//                    modelMap.addAttribute("extraDiscount",entry.getValue().get(j).getExtraDiscount());
//
//                    modelMap.addAttribute("orderQuantity",entry.getValue().get(j).getOrderQuantity());
//                }
            }
        }

        modelMap.addAttribute("products", arr);

        return "proforma";
    }*/

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