package com.wify.erp.NewController;

import com.wify.erp.NewPojo.*;
import com.wify.erp.repository.*;
import com.wify.erp.services.MethodsCalledService;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.ListIterator;
import java.util.stream.Collectors;

@Controller
public class QuotationController {

    @Autowired
    public MethodsCalledService methodsCalledService;

    @Autowired
    private QuotationRepository quotationRepository;

    @Autowired
    private QuotationBOMRepository quotationBOMRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private InventoryProductsRepository inventoryRepo;

    @Autowired
    private PackageRepository packageRepository;

    @Autowired
    private PackageBOMRepository packageBOMRepository;

    @Autowired
    private LeadsRepository leadsRepository;

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private SalesPartnerRepository salesPartnerRepository;

    @Autowired
    private RoomBoardsRepository roomBoardsRepository;

    @RequestMapping("/quotationList/{id}")
    public String quotationList(HttpServletRequest request, ModelMap map, @PathVariable String id) {

        List<Quotation> list;

        HashMap<String, Boolean> hashMap = new HashMap<>();

        HashMap<String, Boolean> orderCompletedHashMap = new HashMap<>();

        try {

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            map.addAttribute("level", salesPartner.getLevel());

            if (leadsRepository.existsById(id)) {

                map.addAttribute("clientType", "lead");

                map.addAttribute("clientName", methodsCalledService.fetchClientName("lead", id));

            } else if (clientRepository.existsById(id)) {

                map.addAttribute("clientType", "client");

                map.addAttribute("clientName", methodsCalledService.fetchClientName("client", id));

            }

            map.addAttribute("clientID", id);

            list = quotationRepository.findAllByClientId(id);

            ListIterator<Quotation> iterator1 = list.listIterator();

            while (iterator1.hasNext()) {

                Quotation q1 = iterator1.next();

                Boolean val = orderRepository.existsByQuotationId(q1.getId());

                if (val) {

                    hashMap.put(q1.getId(), val);

                } else {

                    hashMap.put(q1.getId(), false);

                }

                Boolean val1 = orderRepository.existsByQuotationIdAndStatus(q1.getId(), "Completed");

                if (val1) {

                    orderCompletedHashMap.put(q1.getId(), val);

                } else {

                    orderCompletedHashMap.put(q1.getId(), false);

                }
            }

            map.addAttribute("orderAddedCheck", hashMap);

            map.addAttribute("orderCompletedCheck", orderCompletedHashMap);

//            System.out.println("orderAddedCheck >> " + hashMap);

//            System.out.println("orderCompletedCheck >> " + orderCompletedHashMap);

            map.addAttribute("quotationlist", quotationRepository.findAllByClientId(id));

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "/quotationlist";
    }

    @RequestMapping("/addQuotation/{type}/{key}/{clientID}")
    public String addQuotation(HttpServletRequest request, ModelMap modelMap, @PathVariable String type, @PathVariable String key, @PathVariable String clientID) {

        List<Quotation> list;

        ArrayList<Integer> quotationCount;

        try {

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            modelMap.addAttribute("level", salesPartner.getLevel());

            modelMap.addAttribute("clientID", clientID);

            if (leadsRepository.existsById(clientID)) {

                modelMap.addAttribute("clientType", "lead");

                modelMap.addAttribute("clientName", methodsCalledService.fetchClientName("lead", clientID));

            } else if (clientRepository.existsById(clientID)) {

                modelMap.addAttribute("clientType", "client");

                modelMap.addAttribute("clientName", methodsCalledService.fetchClientName("client", clientID));

            }

            quotationCount = new ArrayList<>();

            if (type.equals("add")) {

                list = quotationRepository.findAll();

                ListIterator<Quotation> iterator1 = list.listIterator();

                while (iterator1.hasNext()) {

                    Quotation q1 = iterator1.next();

                    quotationCount.add(Integer.parseInt(q1.getqNum()));
                }

                int maximum = 0;

                if (!quotationCount.isEmpty()) {

                    maximum = quotationCount.get(0);

                }

                for (int i = 1; i < quotationCount.size(); i++) {

                    if (maximum < quotationCount.get(i)) {

                        maximum = quotationCount.get(i);
                    }

                }

                maximum++;

                modelMap.addAttribute("quotation_No", maximum);

                modelMap.addAttribute("type", "add");

                modelMap.addAttribute("quotation", new Quotation());
            }
            if (type.equals("edit")) {

                modelMap.addAttribute("type", "edit");

                modelMap.addAttribute("quotation", quotationRepository.findById(key));

            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "addQuotation";
    }

    @RequestMapping("/addQuotationForm")
    public String addQuotationForm(@RequestParam MultiValueMap<String, String> parameters) {

        String id = new ObjectId().toString();

        Quotation q1 = new Quotation(
                id,
                parameters.get("qNum").get(0),
                parameters.get("clientId").get(0),
                parameters.get("extraDiscount").get(0),
                parameters.get("orderQuantity").get(0),
                "", 0
        );

        quotationRepository.save(q1);

        return "redirect:/quotationList" + "/" + parameters.get("clientId").get(0);
    }

    @RequestMapping("/updateQuotationForm/{updateKey}")
    public String updateQuotationForm(@RequestParam MultiValueMap<String, String> parameters, @PathVariable String updateKey) {

        Quotation quotation = quotationRepository.findById(updateKey);

        quotation.setqNum(parameters.get("qNum").get(0));

        quotation.setExtraDiscount(parameters.get("extraDiscount").get(0));

        quotation.setOrderQuantity(parameters.get("orderQuantity").get(0));

        quotationRepository.save(quotation);

        return "redirect:/quotationList" + "/" + parameters.get("clientId").get(0);
    }

    @ResponseBody
    @RequestMapping(value = "/checkProductsAddedinQuotation")
    public String checkProductsAddedinQuotation(@RequestParam String name) {

        String value = "false";

        List<QuotationBOM> list1;

        list1 = quotationBOMRepository.findByQuotationID(name);

        if (list1.size() > 0) {

            value = "true";
        }

        return value;
    }

    /**
     * ----------------------------------Add Quotation BOM---------------------------------
     **/

    @RequestMapping("/quotationBOMlist/{quotation_no}/{quotation_id}")
    public String quotationBOMlist(HttpServletRequest request, ModelMap modelMap, @PathVariable String quotation_no, @PathVariable String quotation_id) {

        try {

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            Quotation q = quotationRepository.findById(quotation_id);

            modelMap.addAttribute("clientID", q.getClientId());

            if (leadsRepository.existsById(q.getClientId())) {

                modelMap.addAttribute("clientType", "lead");

                modelMap.addAttribute("clientName", methodsCalledService.fetchClientName("lead", q.getClientId()));

            } else if (clientRepository.existsById(q.getClientId())) {

                modelMap.addAttribute("clientType", "client");

                modelMap.addAttribute("clientName", methodsCalledService.fetchClientName("client", q.getClientId()));

            }

            modelMap.addAttribute("level", salesPartner.getLevel());

            modelMap.addAttribute("orderid", quotation_no);

            modelMap.addAttribute("quotationID", quotation_id);

            String discount = methodsCalledService.fetchPackageDiscount(quotation_id);

            modelMap.addAttribute("packageDiscount", discount);

            Boolean val = orderRepository.existsByQuotationId(quotation_id);

            modelMap.addAttribute("quotationAddedCheck", val);

            Quotation quotation = quotationRepository.findById(quotation_id);

            modelMap.addAttribute("orderQuantity", quotation.getOrderQuantity());

            modelMap.addAttribute("extraDiscount", quotation.getExtraDiscount());

            modelMap.addAttribute("orderid", quotation_no);

            modelMap.addAttribute("orderbom", quotationBOMRepository.findAllByQuotationID(quotation_id));

            List<QuotationBOM> bom = quotationBOMRepository.findAllByQuotationID(quotation_id);

            String packageName = null;

            for (QuotationBOM b : bom) {

                packageName = b.getPackageName();

                break;

            }

            if (bom.size() > 0) {

                if (packageName.trim().length() > 0) {

                    Packages packages = packageRepository.findByName(packageName);

                    modelMap.addAttribute("finalAmountOfPackage", packages.getFinalTotal());

                } else {

                    modelMap.addAttribute("finalAmountOfPackage", "0");
                }

            }

//            controllerPojo = (ControllerPojo) quotationBOMRepository.findById(quotation_id);

//            modelMap.addAttribute("controllerData",controllerPojo);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "quotationBOMlist";
    }

    @RequestMapping("/addQuotationBOM/{type}/{updatekey}/{name}/{clientID}/{quotationID}")
    public String addQuotationBOM(HttpServletRequest request, ModelMap model, @PathVariable String type, @PathVariable String updatekey,
                                  @PathVariable String name, @PathVariable String clientID, @PathVariable String quotationID) {

        try {

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            model.addAttribute("level", salesPartner.getLevel());

            model.addAttribute("clientID", clientID);

            if (leadsRepository.existsById(clientID)) {

                model.addAttribute("clientType", "lead");

                model.addAttribute("clientName", methodsCalledService.fetchClientName("lead", clientID));

            } else if (clientRepository.existsById(clientID)) {

                model.addAttribute("clientType", "client");

                model.addAttribute("clientName", methodsCalledService.fetchClientName("client", clientID));

            }

            Quotation quotation = quotationRepository.findById(quotationID);

            model.addAttribute("orderid", quotation.getqNum());

            model.addAttribute("quotationID", quotationID);

            model.addAttribute("qoutationBOMAddType", name);

            if (type.equals("add")) {

                model.addAttribute("type", "add");

                model.addAttribute("orderbom", new QuotationBOM());
            }

            if (type.equals("edit")) {

                model.addAttribute("type", "edit");

                model.addAttribute("orderbom", quotationBOMRepository.findById(updatekey));

                System.out.println("orderbom >>> " + quotationBOMRepository.findById(updatekey));
            }

            model.addAttribute("productlist", getProductNamesOnly());

            model.addAttribute("packageList", getPackageNamesOnly());

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "addQuotationBOM";
    }

    @ResponseBody
    @RequestMapping(value = "/getqid")
    public String getqid(@RequestParam String name) {

        String code = null;

        try {

            Inventory_Products products = inventoryRepo.findByName(name);

            code = products.getProductCode();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return code;
    }

    @ResponseBody
    @RequestMapping(value = "/getqprice")
    public String getqprice(@RequestParam String name) {

        String price = null;

        try {

            Inventory_Products products = inventoryRepo.findByName(name);

            price = products.getPrice();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return price;
    }


    @RequestMapping("/addQuotationBOMForm/{addType}")
    public String addQuotationBOMForm(@RequestParam MultiValueMap<String, String> parameters, @PathVariable String addType) {

        List<PackageBOM> list;

        Quotation quotation = null;

        try {

            quotation = quotationRepository.findById(parameters.get("quotationID").get(0));

            if (addType.equalsIgnoreCase("addPackage")) {

                //methodsCalledService.addMiniserverByDefault(quotation.getId());

                Packages p = packageRepository.findByName(parameters.get("package_name").get(0));

                list = packageBOMRepository.findAllByPackageID(p.getId());

                ListIterator<PackageBOM> iterator1 = list.listIterator();

                while (iterator1.hasNext()) {

                    PackageBOM p1 = iterator1.next();

                    QuotationBOM bom = new QuotationBOM();

                    String id = new ObjectId().toString();

                    bom.setId(id);
                    bom.setPcode(p1.getCode());
                    bom.setPname(p1.getName());
                    bom.setQuantity(p1.getQuantity());
                    bom.setPrice(p1.getPrice());
                    bom.setPackageName(parameters.get("package_name").get(0));
                    bom.setQuotationID(parameters.get("quotationID").get(0));
                    bom.setRoomName("");

                    quotationBOMRepository.save(bom);
                }

            }

            if (addType.equalsIgnoreCase("addProduct")) {

                String id = new ObjectId().toString();

                if (quotationBOMRepository.existsByQuotationIDAndPnameAndPackageName(parameters.get("quotationID").get(0), parameters.get("pname").get(0), "")) {

                    QuotationBOM bom = quotationBOMRepository.findByQuotationIDAndPname(parameters.get("quotationID").get(0), parameters.get("pname").get(0));

                    String finalQuantity = Integer.toString(Integer.parseInt(bom.getQuantity()) + Integer.parseInt(parameters.get("quantity").get(0)));

                    bom.setQuantity(finalQuantity);

                    quotationBOMRepository.save(bom);

                } else {

                    methodsCalledService.addMiniserverByDefault(quotation.getId());

                    QuotationBOM q1 = new QuotationBOM(
                            id,
                            parameters.get("pname").get(0),
                            parameters.get("pcode").get(0),
                            parameters.get("quantity").get(0),
                            parameters.get("price").get(0),
                            "",
                            parameters.get("quotationID").get(0),
                            parameters.get("roomName").get(0)
                    );

                    quotationBOMRepository.save(q1);
                }
            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/quotationBOMlist/" + quotation.getqNum() + "/" + parameters.get("quotationID").get(0);
    }

    @RequestMapping("/updateQuotationBOMForm/{updatekey}")
    public String updateQuotationBOMForm(@RequestParam MultiValueMap<String, String> parameters, @PathVariable String updatekey) {

        Quotation quotation = null;

        try {

            QuotationBOM bom = quotationBOMRepository.findById(updatekey);

            if (quotationBOMRepository.existsByIdAndPnameContains(updatekey, "Controller")) {

                ControllerPojo controllerPojo = (ControllerPojo) quotationBOMRepository.findById(updatekey);

                controllerPojo.setQuantity(parameters.get("quantity").get(0));

                quotationBOMRepository.save(controllerPojo);

            } else {

                bom.setQuantity(parameters.get("quantity").get(0));
                /*QuotationBOM q1 = new QuotationBOM(
                        updatekey,
                        parameters.get("pname").get(0),
                        parameters.get("pcode").get(0),
                        parameters.get("quantity").get(0),
                        parameters.get("price").get(0),
                        "",
                        parameters.get("quotationID").get(0),
                        parameters.get("roomName").get(0)
                );*/

                quotationBOMRepository.save(bom);

            }

            quotation = quotationRepository.findById(parameters.get("quotationID").get(0));

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/quotationBOMlist/" + quotation.getqNum() + "/" + parameters.get("quotationID").get(0);
    }

    @RequestMapping("/deleteQuotationBOM/{deletekey}/{quotationId}")
    public String deleteQuotationBOM(@PathVariable String deletekey, @PathVariable String quotationId) {

        Quotation quotation = null;

        try {

            quotation = quotationRepository.findById(quotationId);

            if (quotationBOMRepository.findAllByQuotationID(quotationId).size() == 2) {

                quotationBOMRepository.deleteByPnameContainsAndQuotationID("Mini", quotationId);

//                roomBoardsRepository.deleteAllByQuotationID(quotationId);

            }

            quotationBOMRepository.deleteById(deletekey);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/quotationBOMlist/" + quotation.getqNum() + "/" + quotationId;
    }

   /* public void addMiniserverByDefault(String quotationId) {

        if (!quotationBOMRepository.existsByQuotationID(quotationId)) {

            String miniserverID = new ObjectId().toString();

            Inventory_Products products = inventoryRepo.findByNameContains("Mini");

            QuotationBOM quotationBOM = new QuotationBOM(
                    miniserverID,
                    products.getName(),
                    products.getProductCode(),
                    "1",
                    products.getPrice(),
                    "",
                    quotationId

            );

            quotationBOMRepository.save(quotationBOM);
        }
    }*/

    /**
     * ------------------------------------ Generate Quotation ---------------------------------------------
     **/

    @RequestMapping("/generatequotation/{quotationnumber}/{quoID}/{clientID}")
    public String generatequotation(HttpServletRequest request, ModelMap modelMap, @PathVariable String quotationnumber, @PathVariable String quoID, @PathVariable String clientID) {

        String packageName = "";

        List<QuotationBOM> list1;

        List<QuotationBOM> finalProductList;

        try {

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            modelMap.addAttribute("level", salesPartner.getLevel());

//            System.out.println("level >>> "+ salesPartner.getLevel());

            modelMap.addAttribute("company", salesPartner);

            Object obj;

            modelMap.addAttribute("quotationnumber", quotationnumber);

            obj = leadsRepository.findById(clientID);

            if (obj == null) {

                obj = clientRepository.findById(clientID);
            }

            modelMap.addAttribute("clientdetails", obj);

            list1 = quotationBOMRepository.findAllByQuotationID(quoID);

            QuotationBOM bom = null;

            for (int i = 0; i < list1.size(); i++) {

                bom = list1.get(i);

                if (bom.getPackageName().equalsIgnoreCase("")) {

                } else {

                    break;
                }
            }

            if (packageName.equalsIgnoreCase("")) {

                packageName = bom.getPackageName();

                if (!packageName.equalsIgnoreCase("")) {

                    Packages packages = packageRepository.findByName(packageName);

                    modelMap.addAttribute("discount", packages.getDiscount());

                } else {

                    modelMap.addAttribute("discount", "0");

                }

//                    break;
            }

            finalProductList = methodsCalledService.hideMultipleProducts(quoID);

            modelMap.addAttribute("orderdetails", finalProductList);

            Quotation quotation = quotationRepository.findById(quoID);

            modelMap.addAttribute("extraDiscount", quotation.getExtraDiscount());

            modelMap.addAttribute("orderQuantity", quotation.getOrderQuantity());

            List<QuotationBOM> bom1 = quotationBOMRepository.findAllByQuotationID(quoID);

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

        return "quotation";
    }

    /*public String fetchPackageDiscount(String quotationID) {

        List<QuotationBOM> list1;

        String discount = "";

        try {

            list1 = quotationBOMRepository.findAllByQuotationID(quotationID);

            ListIterator iterator1 = list1.listIterator();

            while (iterator1.hasNext()) {

                QuotationBOM bom = (QuotationBOM) iterator1.next();

                String packageName = bom.getPackageName();

                if (!packageName.equalsIgnoreCase("")) {

                    Packages packages = packageRepository.findByName(packageName);

                    discount = packages.getDiscount();

                } else {

                    discount = "0";

                }

                break;

            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return discount;
    }*/

    public List<String> getPackageNamesOnly() {

        return packageRepository.findAll()
                .stream()
                .map(Packages::getName)
                .collect(Collectors.toList());
    }

    public List<String> getProductNamesOnly() {

        return inventoryRepo.findAllByCategory("Product")
                .stream()
                .map(Inventory_Products::getName)
                .collect(Collectors.toList());
    }

    @ResponseBody
    @RequestMapping(value = "/getControllerData")
    public ControllerPojo getControllerData(@RequestParam String id) {

        ControllerPojo controllerPojo = null;

        try {

            System.out.println("id >> " + id);

            controllerPojo = (ControllerPojo) quotationBOMRepository.findById(id);

            System.out.println("controllerPojo >> " + controllerPojo.toString());

        } catch (Exception e) {

            e.printStackTrace();
        }

//        System.out.println("controllerPojo >> " + controllerPojo.toString());

        return controllerPojo;
    }


   /* @RequestMapping("/deletequotation/{clientID}/{deletekey}")
    public String deletequotation(@PathVariable String clientID, @PathVariable String deletekey) {

        QuotationUtility q = new QuotationUtility();

        q.deleteQuotation(clientID, deletekey);

        for (Map.Entry<String, ArrayList<Quotation>> entry : FirebaseUtility.quotationList.entrySet()) {

            ArrayList<Quotation> value = entry.getValue();

            int index = 0;

            for (Quotation quotation : value) {

//                if (quotation.getQuotation_no().equals(deletekey)) {
//
//                    value.remove(index);
//
//                    break;
//                } else {
//                    index++;
//                }
            }

        }

        q.deleteQuotationBOM(deletekey);

        return "redirect:/quotation/" + clientID + "/" + clientName + "/" + installerid;
    }*/

}
