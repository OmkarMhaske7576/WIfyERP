package com.wify.erp.NewController;

import com.wify.erp.NewPojo.Client;
import com.wify.erp.NewPojo.Order;
import com.wify.erp.NewPojo.SalesEmployee;
import com.wify.erp.NewPojo.SalesPartner;
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
import java.util.List;
import java.util.ListIterator;
import java.util.stream.Collectors;

@Controller
public class ClientController {

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private SalesEmployeeRepository salesEmployeeRepository;

    @Autowired
    private LeadsRepository leadsRepository;

    @Autowired
    private SalesPartnerRepository salesPartnerRepository;

    @Autowired
    private OrderRepository orderRepository;

    @RequestMapping("/clientList")
    public String clientList(HttpServletRequest request, ModelMap map) {

        List<SalesPartner> salesPartnerList;

        List<Client> clientList1 = null;

        List<Client> clientList2 = null;

        List<Client> clientList3 = null;

        String p1 = null;

        String p2 = null;

        String p3 = null;

        try {

            String salesEmployeeEmail = LoginController.getCookieSalesEmployeeEmail(request);

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            map.addAttribute("level", salesPartner.getLevel());

            if (salesEmployeeEmail != "") {

                SalesEmployee salesEmployee = salesEmployeeRepository.findByEmail(salesEmployeeEmail);

                map.addAttribute("clients", clientRepository.findAllByEmpId(salesEmployee.getId()));

            } else {

                if (salesPartner.getLevel().equalsIgnoreCase("0")) {

                    salesPartnerList = salesPartnerRepository.findAllByLevelGreaterThan("0");

                    for (int i = 0; i < salesPartnerList.size(); i++) {

                        if (i == 0) {

                            p1 = salesPartnerList.get(i).getName();

                            clientList1 = clientRepository.findAllByCompanyID(salesPartnerList.get(i).getId());
                        }
                        if (i == 1) {

                            p2 = salesPartnerList.get(i).getName();

                            clientList2 = clientRepository.findAllByCompanyID(salesPartnerList.get(i).getId());
                        }
                        if (i == 2) {

                            p3 = salesPartnerList.get(i).getName();

                            clientList3 = clientRepository.findAllByCompanyID(salesPartnerList.get(i).getId());
                        }
                    }

                    map.addAttribute("orderList1", clientList1);

                    map.addAttribute("orderList2", clientList2);

                    map.addAttribute("orderList3", clientList3);

                    map.addAttribute("partner1", p1);

                    map.addAttribute("partner2", p2);

                    map.addAttribute("partner3", p3);

                } else {

                    map.addAttribute("clients", clientRepository.findAllByCompanyID(salesPartner.getId()));

                }
            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "/clientlist";
    }

    @RequestMapping("/addClient/{type}/{updatekey}")
    public String addClient(HttpServletRequest request, ModelMap model, @PathVariable String type, @PathVariable String updatekey) {

        try {

            String salesEmployeeEmail = LoginController.getCookieSalesEmployeeEmail(request);

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            model.addAttribute("installeropt", getNamesOnly(salesPartner.getId()));

            if (salesEmployeeEmail != "") {

                SalesEmployee salesEmployee = salesEmployeeRepository.findByEmail(salesEmployeeEmail);

                model.addAttribute("isSalesEmployeeLoggedIn", "true");

                model.addAttribute("salesEmployeeName",salesEmployee.getName());

                model.addAttribute("salesEmployeeId",salesEmployee.getId());
            }
            else{

                model.addAttribute("isSalesEmployeeLoggedIn", "false");

                model.addAttribute("salesEmployeeName","");

                model.addAttribute("salesEmployeeId","");
            }

            if (type.equals("add")) {

                if (!updatekey.equalsIgnoreCase("null")) {

                    model.addAttribute("leadObj", leadsRepository.findById(updatekey));

                } else {

                    model.addAttribute("leadObj", "null");
                }

                model.addAttribute("companyID", salesPartner.getId());

                model.addAttribute("type", "add");

                model.addAttribute("client", new Client());
            }

            if (type.equals("edit")) {

                model.addAttribute("type", "edit");

                model.addAttribute("client", clientRepository.findById(updatekey));
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "/addclient";
    }

    @ResponseBody
    @RequestMapping(value = "/getInstallerid")
    public String getInstallerid(@RequestParam String name) {

        SalesEmployee emp = null;

        try {

            emp = salesEmployeeRepository.findByName(name);

        }
        catch (Exception e){

            e.printStackTrace();
        }

        return emp.getId();
    }

    @RequestMapping("/addClientForm")
    public String addClientForm(@RequestParam MultiValueMap<String, String> parameters) {

        String id;

        try {

            if (parameters.get("id").get(0).equalsIgnoreCase("")) {

                id = new ObjectId().toString();

            } else {

                id = parameters.get("id").get(0);

            }

            Client c1 = new Client(
                    id,
                    parameters.get("name").get(0),
                    parameters.get("address").get(0),
                    parameters.get("address1").get(0),
                    parameters.get("floor").get(0),
                    parameters.get("landmark").get(0),
                    parameters.get("city").get(0),
                    parameters.get("pincode").get(0),
                    parameters.get("state").get(0),
                    parameters.get("gps").get(0),
                    parameters.get("mail").get(0),
                    parameters.get("mobile").get(0),
                    parameters.get("residence").get(0),
                    parameters.get("installation").get(0),
                    parameters.get("clientType").get(0),
                    parameters.get("businessType").get(0),
                    parameters.get("empName").get(0),
                    parameters.get("empId").get(0),
                    parameters.get("companyID").get(0),
                    parameters.get("comment").get(0)
            );

            clientRepository.save(c1);

            if (!parameters.get("id").get(0).equalsIgnoreCase("")) {

                leadsRepository.deleteById(parameters.get("id").get(0));
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/clientList";
    }

    @RequestMapping("/updateClientForm/{updateKey}")
    public String updateClientForm(@RequestParam MultiValueMap<String, String> parameters, @PathVariable String updateKey) {

        try {

            Client c1 = new Client(
                    parameters.get("id").get(0),
                    parameters.get("name").get(0),
                    parameters.get("address").get(0),
                    parameters.get("address1").get(0),
                    parameters.get("floor").get(0),
                    parameters.get("landmark").get(0),
                    parameters.get("city").get(0),
                    parameters.get("pincode").get(0),
                    parameters.get("state").get(0),
                    parameters.get("gps").get(0),
                    parameters.get("mail").get(0),
                    parameters.get("mobile").get(0),
                    parameters.get("residence").get(0),
                    parameters.get("installation").get(0),
                    parameters.get("clientType").get(0),
                    parameters.get("businessType").get(0),
                    parameters.get("empName").get(0),
                    parameters.get("empId").get(0),
                    parameters.get("companyID").get(0),
                    parameters.get("comment").get(0)
            );

            clientRepository.save(c1);

            if (orderRepository.existsByClientId(parameters.get("id").get(0))){

               List<Order> orderList = orderRepository.findAllByClientId(parameters.get("id").get(0));

                ListIterator<Order> iterator = orderList.listIterator();

                while (iterator.hasNext()){

                    Order order = iterator.next();

                    order.setClientName(parameters.get("name").get(0));

                    orderRepository.save(order);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/clientList";
    }

    @RequestMapping("/deleteClient/{id}")
    public String deleteClient(@PathVariable String id) {

        try{

            clientRepository.deleteById(id);

        }
        catch (Exception e){

            e.printStackTrace();
        }

        return "redirect:/clientList";
    }

    public List<String> getNamesOnly(String id) {

        return salesEmployeeRepository.findAllByCompanyId(id)
                .stream()
                .map(SalesEmployee::getName)
                .collect(Collectors.toList());
    }

}
