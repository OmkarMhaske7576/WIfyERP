package com.wify.erp.NewController;

import com.wify.erp.NewPojo.*;
import com.wify.erp.repository.*;
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
public class OrderController {

    public static int orderCountAlert = 0;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private QuotationBOMRepository quotationBOMRepository;

    @Autowired
    private QuotationRepository quotationRepository;

    @Autowired
    private InventoryProductsRepository inventoryProductsRepository;

    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private LeadsRepository leadsRepository;

    @Autowired
    private SalesEmployeeRepository salesEmployeeRepository;

    @Autowired
    private SalesPartnerRepository salesPartnerRepository;

    @RequestMapping("/companyOrdersList")
    public String companyOrdersList(HttpServletRequest request, ModelMap map) {

        try {

            String salesEmployeeEmail = LoginController.getCookieSalesEmployeeEmail(request);

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            map.addAttribute("level", salesPartner.getLevel());

            if (salesEmployeeEmail != "") {

                map.addAttribute("isSalesEmployeeLoggedIn","true");

                SalesEmployee salesEmployee = salesEmployeeRepository.findByEmail(salesEmployeeEmail);

                map.addAttribute("orderlist", orderRepository.findAllBySalesEmpID(salesEmployee.getId()));

            } else {

                map.addAttribute("isSalesEmployeeLoggedIn","false");

                if (salesPartner.getLevel().equals("0")) {

                    salesPartner.setOrdersCount(Integer.toString(orderRepository.findAllByStatusNotContains("Pending").size()));

                } else {

                    salesPartner.setOrdersCount(Integer.toString(companyOrders(salesPartner.getId()).size()));
                }

                salesPartnerRepository.save(salesPartner);

                map.addAttribute("orderlist", companyOrders(salesPartner.getId()));

                if (!salesPartner.getLevel().equalsIgnoreCase("1")) {

                    map.addAttribute("tabInfo", "");

                }
                if (salesPartner.getLevel().equalsIgnoreCase("1")) {

                    map.addAttribute("childOrderList", childCompanyOrders(salesPartner.getId()));

                    map.addAttribute("selfOrdersCount", orderRepository.findAllByCompanyIDAndStatusNot(salesPartner.getId(), "Pending").size());

                    map.addAttribute("pendingOrdersCount", orderRepository.findAllByCompanyIDAndStatus(salesPartner.getId(), "Pending").size());

                }
            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "companyOrderList";
    }

    @RequestMapping("/confirmOrder/{orderID}")
    public String confirmOrder(@PathVariable String orderID) {

        try {

            Order order = orderRepository.findById(orderID);

            order.setStatus("New");

            orderRepository.save(order);

        } catch (Exception e) {

            e.printStackTrace();
        }
        return "redirect:/companyOrdersList";
    }

    @RequestMapping("/companyWiseOrderList")
    public String companyWiseOrderList(ModelMap map) {

        List<SalesPartner> salesPartnerList;

        List<Order> orderList1 = null;

        List<Order> orderList2 = null;

        List<Order> orderList3 = null;

        try {

            String p1 = null;

            String p2 = null;

            String p3 = null;

            salesPartnerList = salesPartnerRepository.findAllByLevelGreaterThan("0");

            for (int i = 0; i < salesPartnerList.size(); i++) {

                if (i == 0) {
                    p1 = salesPartnerList.get(i).getName();
                    orderList1 = orderRepository.findAllByCompanyIDAndStatusNot(salesPartnerList.get(i).getId(), "Pending");
                }
                if (i == 1) {
                    p2 = salesPartnerList.get(i).getName();
                    orderList2 = orderRepository.findAllByCompanyIDAndStatusNot(salesPartnerList.get(i).getId(), "Pending");
                }
                if (i == 2) {
                    p3 = salesPartnerList.get(i).getName();
                    orderList3 = orderRepository.findAllByCompanyIDAndStatusNot(salesPartnerList.get(i).getId(), "Pending");
                }

            }

            map.addAttribute("orderList1", orderList1);

            map.addAttribute("orderList2", orderList2);

            map.addAttribute("orderList3", orderList3);

            map.addAttribute("partner1", p1);

            map.addAttribute("partner2", p2);

            map.addAttribute("partner3", p3);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "companyWiseOrderList";
    }

    @RequestMapping("/orderlist")
    public String orderlist(HttpServletRequest request, ModelMap model) {

        List<SalesPartner> salesPartnerList;

        HashMap<String, String> hashmap = new HashMap<>();

        try {

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            if (salesPartner.getLevel().equals("0")) {

                System.out.println("1 >> " + orderRepository.findAllByStatusNotContains("Pending").size());

                salesPartner.setOrdersCount(Integer.toString(orderRepository.findAllByStatusNotContains("Pending").size()));

            } else {

                System.out.println("2 >> " + companyOrders(salesPartner.getId()).size());

                salesPartner.setOrdersCount(Integer.toString(companyOrders(salesPartner.getId()).size()));
            }

            salesPartnerRepository.save(salesPartner);

            salesPartnerList = salesPartnerRepository.findAllByLevelGreaterThan("0");

            for (int i = 0; i < salesPartnerList.size(); i++) {

                hashmap.put(salesPartnerList.get(i).getId(), salesPartnerList.get(i).getName());
            }

            model.addAttribute("hashmap", hashmap);

            System.out.println("Hashmap >> " + hashmap);

//            orderCountAlert = orderRepository.findAllByStatusNotContains("Pending").size();

            model.addAttribute("orderlist", orderRepository.findAllByStatusNotContains("Pending"));

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "/orderlist";
    }


    @RequestMapping("/addOrder/{type}/{updatekey}/{quotation_id}/{value}")
    public String addOrder(ModelMap model, @PathVariable String type, @PathVariable String updatekey, @PathVariable String quotation_id,
                           @PathVariable String value) {

        try {

            Quotation quotation = quotationRepository.findById(quotation_id);

            if (type.equals("add")) {

                model.addAttribute("value", value);

                model.addAttribute("quotationnumber", quotation_id);

                model.addAttribute("client_id", quotation.getClientId());

                Client client = clientRepository.findById(quotation.getClientId());

                System.out.println(" >>> " + client.getName() + " >>> " + client.getEmpName() + " >> " + client.getEmpId());

                if (client == null) {

                    Leads lead = leadsRepository.findById(quotation.getClientId());

                    model.addAttribute("clientname", lead.getName());

                } else {

                    model.addAttribute("clientname", client.getName());

                    model.addAttribute("empID", client.getEmpId());

                }

                model.addAttribute("type", "add");

                model.addAttribute("order", new Order());
            }

            if (type.equals("edit")) {

                model.addAttribute("value", value);

                model.addAttribute("type", "edit");

                model.addAttribute("order", orderRepository.findById(updatekey));

                model.addAttribute("employeeList", getNamesOnly());

            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "addorder";
    }

    @ResponseBody
    @RequestMapping(value = "/getEmployeeID")
    public String getEmployeeID(@RequestParam String name) {

        Employee emp = employeeRepository.findByName(name);

        return emp.getId();
    }

    @ResponseBody
    @RequestMapping(value = "/getSalesEmployeeID")
    public String getSalesEmployeeID(@RequestParam String name) {

        SalesEmployee emp = salesEmployeeRepository.findByName(name);

        return emp.getId();
    }

    @RequestMapping("/addOrderForm")
    public String addOrderForm(HttpServletRequest request, @RequestParam MultiValueMap<String, String> parameters) {

        try {

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            String id = new ObjectId().toString();

            Order order = new Order(
                    id,
                    parameters.get("clientId").get(0),
                    parameters.get("clientName").get(0),
                    parameters.get("quotationId").get(0),
                    "",
                    "",
                    parameters.get("salesEmpID").get(0),
                    "Pending",
                    parameters.get("estDate").get(0),
                    parameters.get("shipDate").get(0),
                    parameters.get("warrPeriod").get(0),
                    parameters.get("orderDate").get(0),
                    parameters.get("payStatus").get(0),
                    "",
                    parameters.get("courierName").get(0),
                    parameters.get("trackingNo").get(0),
                    salesPartner.getId(),"",
                    parameters.get("comment").get(0));

            orderRepository.save(order);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/quotationList" + "/" + parameters.get("clientId").get(0);
    }

    @RequestMapping("/updateOrderForm/{orderID}/{value}")
    public String updateOrderForm(HttpServletRequest request,@RequestParam MultiValueMap<String, String> parameters, @PathVariable String orderID, @PathVariable String value) {

        List<QuotationBOM> list;

        String transportType;

        String InstallerName;

        String InstallerID;

        try {

            Order order1 = orderRepository.findById(orderID);

            if (parameters.get("status").get(0).equalsIgnoreCase("Preparing") || parameters.get("status").get(0).equalsIgnoreCase("Cancelled")) {

                if (!order1.getStatus().equals(parameters.get("status").get(0))) {

                    Quotation q1 = quotationRepository.findById(parameters.get("quotationId").get(0));

                    String orderQuantity = q1.getOrderQuantity();

                    list = quotationBOMRepository.findAllByQuotationID(parameters.get("quotationId").get(0));

                    ListIterator<QuotationBOM> iterator = list.listIterator();

                    while (iterator.hasNext()) {

                        QuotationBOM bom = iterator.next();

                        Inventory_Products products = inventoryProductsRepository.findByProductCode(bom.getPcode());

                        int quantity = 0;

                        if (parameters.get("status").get(0).equalsIgnoreCase("Preparing")) {

                            quantity = Integer.parseInt(products.getStock()) - Integer.parseInt(bom.getQuantity()) * Integer.parseInt(orderQuantity);

                        }
                        if (parameters.get("status").get(0).equalsIgnoreCase("Cancelled")) {

                            quantity = Integer.parseInt(products.getStock()) + Integer.parseInt(bom.getQuantity()) * Integer.parseInt(orderQuantity);

                        }

                        products.setStock(Integer.toString(quantity));

                        inventoryProductsRepository.save(products);
                    }
                }
            }

            if (parameters.containsKey("transType")) {

                transportType = parameters.get("transType").get(0);

            } else {

                transportType = "";
            }

            if (parameters.containsKey("installerName")) {

                InstallerName = parameters.get("installerName").get(0);

            } else {

                InstallerName = "";
            }

            if (parameters.containsKey("installerID")) {

                InstallerID = parameters.get("installerID").get(0);

            } else {

                InstallerID = "";
            }

            Order order = new Order(
                    parameters.get("id").get(0),
                    parameters.get("clientId").get(0),
                    parameters.get("clientName").get(0),
                    parameters.get("quotationId").get(0),
                    InstallerName,
                    InstallerID,
                    parameters.get("salesEmpID").get(0),
                    parameters.get("status").get(0),
                    parameters.get("estDate").get(0),
                    parameters.get("shipDate").get(0),
                    parameters.get("warrPeriod").get(0),
                    parameters.get("orderDate").get(0),
                    parameters.get("payStatus").get(0),
                    transportType,
                    parameters.get("courierName").get(0),
                    parameters.get("trackingNo").get(0),
                    parameters.get("companyID").get(0),
                    parameters.get("host").get(0),
                    parameters.get("comment").get(0));

            orderRepository.save(order);

            String employeeEmail = LoginController.getCookieEmployeeEmail(request);

            if(value.equalsIgnoreCase("order") && employeeEmail != "") {

                return "redirect:/employeeOrdersList";
            }
            else if (value.equalsIgnoreCase("order")) {

                return "redirect:/orderlist";
            }


        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/warehouseorders";
    }

    public List<Order> companyOrders(String salesPartnerId) {

        List<Order> orderlist = new ArrayList<>();

        try {

            orderlist.addAll(orderRepository.findAllByCompanyID(salesPartnerId));

        } catch (Exception e) {

            e.printStackTrace();
        }
        return orderlist;
    }

    public List<Order> childCompanyOrders(String salesPartnerId) {

        List<Order> orderlist = new ArrayList<>();

        try {

            orderlist.addAll(orderRepository.findAllByCompanyIDNotAndStatusNot(salesPartnerId, "Pending"));

        } catch (Exception e) {

            e.printStackTrace();
        }
        return orderlist;
    }

    /**
     * ------------  Order alert count ------------------------------
     **/

    @ResponseBody
    @RequestMapping(value = "/getUpdateOrderCount")
    public int getUpdateOrderCount(HttpServletRequest request) {

        SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

        if (salesPartner == null) {

//            System.out.println("Inside if >> ");

            return 0;
        } else {

            if (salesPartner.getLevel().equals("0")) {

                int updatedCount = orderRepository.findAllByStatusNotContains("Pending").size();

                int oldCount = Integer.parseInt(salesPartner.getOrdersCount());

                int newOrderCount = updatedCount - oldCount;

                return newOrderCount;

            } else {

                int updatedCount = companyOrders(salesPartner.getId()).size();

                int oldCount = Integer.parseInt(salesPartner.getOrdersCount());

                int newOrderCount = updatedCount - oldCount;

                return newOrderCount;
            }
        }
    }

    public List<String> getNamesOnly() {

        return employeeRepository.findAll()
                .stream()
                .map(Employee::getName)
                .collect(Collectors.toList());
    }
}
