package com.wify.erp.NewController;

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

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class SalesPartnerController {

    @Autowired
    private SalesPartnerRepository salesPartnerRepository;

    @Autowired
    private SalesEmployeeRepository salesEmployeeRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private LeadsRepository leadsRepository;

    @RequestMapping("/salesPartner")
    public String salesPartner(HttpServletRequest request, ModelMap map) {

        try {

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            if (salesPartnerRepository.findAll().size() == 0) {

                map.addAttribute("level", "0");
            }
            else{

                map.addAttribute("level", salesPartner.getLevel());

                map.addAttribute("hashmap", salesPartnerRepository.findAllByLevelGreaterThan(salesPartner.getLevel()));
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "/salesPartnerList";
    }

    @RequestMapping("/addSalesPartner/{type}/{key}")
    public String addSalesPartner(HttpServletRequest request, ModelMap map, @PathVariable String type, @PathVariable String key) {

        SalesPartner salesPartner1 = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

        if (type.equalsIgnoreCase("add")) {

            map.addAttribute("type", "add");

            map.addAttribute("salesPartner", new SalesPartner());

            int level;

            if (salesPartnerRepository.findAll().size() == 0) {

                level = 0;

            } else {

                level = Integer.parseInt(salesPartner1.getLevel());

                level++;
            }

            map.addAttribute("level", level);
        }
        if (type.equalsIgnoreCase("edit")) {

            map.addAttribute("type", "edit");

            SalesPartner salesPartner = salesPartnerRepository.findById(key);

            map.addAttribute("salesPartner", salesPartner);

        }

        if (salesPartnerRepository.findAll().size() == 0) {

            map.addAttribute("selfLevel","0");
        }
        else{

            map.addAttribute("selfLevel",salesPartner1.getLevel());
        }

        return "addSalesPartner";
    }

    @RequestMapping("/addSalesPartnerForm")
    public String addSalesPartnerForm(@RequestParam MultiValueMap<String, String> parameters) {

        try {

            String key = new ObjectId().toString();

            SalesPartner salesPartner = new SalesPartner(
                    key,
                    parameters.get("name").get(0),
                    parameters.get("mobile").get(0),
                    parameters.get("address").get(0),
                    parameters.get("address1").get(0),
                    parameters.get("state").get(0),
                    parameters.get("gst").get(0),
                    parameters.get("email").get(0),
                    parameters.get("date").get(0),
                    parameters.get("level").get(0),
                    parameters.get("percentage").get(0),
                    parameters.get("ordersCount").get(0),
                    parameters.get("comment").get(0));

            salesPartnerRepository.save(salesPartner);

            if (parameters.get("level").get(0).equalsIgnoreCase("0")) {

//                LoginController.salesPartner = salesPartner;

            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/salesPartner";
    }

    @RequestMapping("/updateSalesPartnerForm/{key}")
    public String updateSalesPartnerForm(@RequestParam MultiValueMap<String, String> parameters, @PathVariable String key) {

        try {

            SalesPartner salesPartner = new SalesPartner(
                    parameters.get("id").get(0),
                    parameters.get("name").get(0),
                    parameters.get("mobile").get(0),
                    parameters.get("address").get(0),
                    parameters.get("address1").get(0),
                    parameters.get("state").get(0),
                    parameters.get("gst").get(0),
                    parameters.get("email").get(0),
                    parameters.get("date").get(0),
                    parameters.get("level").get(0),
                    parameters.get("percentage").get(0),
                    parameters.get("ordersCount").get(0),
                    parameters.get("comment").get(0));

            salesPartnerRepository.save(salesPartner);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/salesPartner";
    }

    /**
     * -------------------------- Sales Employees ---------------------------------
     **/

    @RequestMapping("/salesEmployeeList")
    public String salesEmployeeList(HttpServletRequest request, ModelMap map) {

        List<SalesPartner> salesPartnerList;

        List<SalesEmployee> salesEmployeeList1 = null;

        List<SalesEmployee> salesEmployeeList2 = null;

        List<SalesEmployee> salesEmployeeList3 = null;

        String p1 = null;

        String p2 = null;

        String p3 = null;

        try {

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            map.addAttribute("level", salesPartner.getLevel());

            if (salesPartner.getLevel().equalsIgnoreCase("0")) {

                salesPartnerList = salesPartnerRepository.findAllByLevelGreaterThan("0");

                for (int i = 0; i < salesPartnerList.size(); i++) {

                    if (i == 0) {
                        p1 = salesPartnerList.get(i).getName();
                        salesEmployeeList1 = salesEmployeeRepository.findAllByCompanyId(salesPartnerList.get(i).getId());
                    }
                    if (i == 1) {
                        p2 = salesPartnerList.get(i).getName();
                        salesEmployeeList2 = salesEmployeeRepository.findAllByCompanyId(salesPartnerList.get(i).getId());
                    }
                    if (i == 2) {
                        p3 = salesPartnerList.get(i).getName();
                        salesEmployeeList3 = salesEmployeeRepository.findAllByCompanyId(salesPartnerList.get(i).getId());
                    }

                }

                map.addAttribute("orderList1", salesEmployeeList1);

                map.addAttribute("orderList2", salesEmployeeList2);

                map.addAttribute("orderList3", salesEmployeeList3);

                map.addAttribute("partner1", p1);

                map.addAttribute("partner2", p2);

                map.addAttribute("partner3", p3);

                System.out.println("partner1 >>  " + p1);

                System.out.println("partner2 >>  " + p2);

                System.out.println("partner3 >>  " + p3);
            } else {

                map.addAttribute("hashmap", salesEmployeeRepository.findAllByCompanyId(salesPartner.getId()));
            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "salesEmployeeList";
    }

    @RequestMapping("/addSalesEmployee/{type}/{key}")
    public String addSalesEmployee(HttpServletRequest request, ModelMap map, @PathVariable String type, @PathVariable String key) {

        SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

        if (type.equalsIgnoreCase("add")) {

            map.addAttribute("type", "add");

            map.addAttribute("businessInstaller", new SalesEmployee());

            map.addAttribute("companyId", salesPartner.getId());

            map.addAttribute("companyName", salesPartner.getName());

        }
        if (type.equalsIgnoreCase("edit")) {

            map.addAttribute("type", "edit");

            map.addAttribute("businessInstaller", salesEmployeeRepository.findById(key));

        }

        return "addSalesEmployee";
    }

    @RequestMapping("/addSalesEmployeeForm")
    public String addSalesEmployeeForm(@RequestParam MultiValueMap<String, String> parameters) {

        String key = new ObjectId().toString();

        SalesEmployee salesEmployee = new SalesEmployee(
                key,
                parameters.get("name").get(0),
                parameters.get("gender").get(0),
                parameters.get("address").get(0),
                parameters.get("email").get(0),
                parameters.get("mobile").get(0),
                parameters.get("reg_date").get(0),
                parameters.get("dob").get(0),
                parameters.get("companyName").get(0),
                parameters.get("companyId").get(0),
                parameters.get("status").get(0),
                parameters.get("comment").get(0));

        salesEmployeeRepository.save(salesEmployee);

        return "redirect:/salesEmployeeList";
    }

    @RequestMapping("/updateSalesEmployeeForm/{key}")
    public String updateSalesEmployeeForm(@RequestParam MultiValueMap<String, String> parameters, @PathVariable String key) {

        SalesEmployee salesEmployee = new SalesEmployee(
                parameters.get("id").get(0),
                parameters.get("name").get(0),
                parameters.get("gender").get(0),
                parameters.get("address").get(0),
                parameters.get("email").get(0),
                parameters.get("mobile").get(0),
                parameters.get("reg_date").get(0),
                parameters.get("dob").get(0),
                parameters.get("companyName").get(0),
                parameters.get("companyId").get(0),
                parameters.get("status").get(0),
                parameters.get("comment").get(0));

        salesEmployeeRepository.save(salesEmployee);

        return "redirect:/salesEmployeeList";
    }

    @RequestMapping("/viewSalesEmployeeData/{id}")
    public String viewSalesEmployeeData(HttpServletRequest request, ModelMap map, @PathVariable String id) {

        try {

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            map.addAttribute("level",salesPartner.getLevel());

            map.addAttribute("orderList", orderRepository.findAllBySalesEmpID(id));

            map.addAttribute("clientList", clientRepository.findAllByEmpId(id));

            SalesEmployee employee = salesEmployeeRepository.findById(id);

            map.addAttribute("employeeName", employee.getName());

            map.addAttribute("employeeID", id);

            map.addAttribute("leadsList", leadsRepository.findAllBySalesEmpID(id));

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "salesEmployeeData";
    }

}