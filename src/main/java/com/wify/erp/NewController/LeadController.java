package com.wify.erp.NewController;

import com.wify.erp.NewPojo.Leads;
import com.wify.erp.NewPojo.SalesEmployee;
import com.wify.erp.NewPojo.SalesPartner;
import com.wify.erp.repository.LeadsRepository;
import com.wify.erp.repository.SalesEmployeeRepository;
import com.wify.erp.repository.SalesPartnerRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.ListIterator;
import java.util.stream.Collectors;

@Controller
public class LeadController {

    @Autowired
    private LeadsRepository leadsRepository;

    @Autowired
    private SalesEmployeeRepository salesEmployeeRepository;

    @Autowired
    private SalesPartnerRepository salesPartnerRepository;

    @RequestMapping("/leads")
    public String leads(HttpServletRequest request, ModelMap map) {

        List<SalesPartner> salesPartnerList;

        List<Leads> leadsList1 = null;

        List<Leads> leadsList2 = null;

        List<Leads> leadsList3 = null;

        String p1 = null;

        String p2 = null;

        String p3 = null;

        try {

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            if (salesPartner.getLevel().equalsIgnoreCase("0")) {

                salesPartnerList = salesPartnerRepository.findAllByLevelGreaterThan("0");

                for (int i = 0; i < salesPartnerList.size(); i++) {

                    if (i == 0) {

                        p1 = salesPartnerList.get(i).getName();

                        leadsList1 = leadsRepository.findAllByLeadByAndCategoryOrCaptureBy(salesPartnerList.get(i).getId(), "Self", salesPartnerList.get(i).getName());
                    }
                    if (i == 1) {

                        p2 = salesPartnerList.get(i).getName();

                        leadsList2 = leadsRepository.findAllByLeadByAndCategoryOrCaptureBy(salesPartnerList.get(i).getId(), "Self", salesPartnerList.get(i).getName());
                    }
                    if (i == 2) {

                        p3 = salesPartnerList.get(i).getName();

                        leadsList3 = leadsRepository.findAllByLeadByAndCategoryOrCaptureBy(salesPartnerList.get(i).getId(), "Self", salesPartnerList.get(i).getName());
                    }

                }

            } else {

                map.addAttribute("hashmap", leadsRepository.findAllByLeadByAndCategoryOrCaptureBy(salesPartner.getId(), "Self", salesPartner.getName()));

                if (salesPartner.getLevel().equalsIgnoreCase("1")) {

                    map.addAttribute("sharedLeads", leadsRepository.findAllByCategory("Digital"));
                }

                if (salesPartner.getLevel().equalsIgnoreCase("2")) {

                    map.addAttribute("sharedLeads", leadsRepository.findAllByCategoryAndCaptureBy("Digital", ""));
                }

            }

            map.addAttribute("orderList1", leadsList1);

            map.addAttribute("orderList2", leadsList2);

            map.addAttribute("orderList3", leadsList3);

            map.addAttribute("partner1", p1);

            map.addAttribute("partner2", p2);

            map.addAttribute("partner3", p3);

            map.addAttribute("currentDate", java.time.LocalDate.now());

            map.addAttribute("level", salesPartner.getLevel());

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "/leadsList";
    }

    @RequestMapping("/leads/{leadtype}")
    public String leadsData(HttpServletRequest request, ModelMap map, @PathVariable String leadtype) {

        List<Leads> leadsList1 = null;

        List<Leads> leadsList2 = null;

        List<Leads> leadsList3 = null;

        List<Leads> bookedLeads = null;

        List<Leads> selfLeads = null;

        String p1 = null;

        String p2 = null;

        String p3 = null;

        HashMap<String, String> employeeNames = new HashMap<>();

        try {

            String salesEmployeeEmail = LoginController.getCookieSalesEmployeeEmail(request);

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            map.addAttribute("level", salesPartner.getLevel());

            if (salesEmployeeEmail != "") {

                SalesEmployee salesEmployee = salesEmployeeRepository.findByEmail(salesEmployeeEmail);

                map.addAttribute("isSalesEmployeeLoggedIn", "true");

                map.addAttribute("hashmap", leadsRepository.findAllBySalesEmpIDAndCategory(salesEmployee.getId(), "Self"));

                map.addAttribute("sharedLeads", leadsRepository.findAllByCategoryAndCaptureBy("Digital", ""));

                map.addAttribute("bookedLeads", leadsRepository.findAllByCategoryAndCaptureBy("Digital", salesPartner.getName()));

//                map.addAttribute("clients", clientRepository.findAllByEmpId(salesEmployee.getId()));

            } else {

                map.addAttribute("isSalesEmployeeLoggedIn", "false");

                map.addAttribute("hashmap", leadsRepository.findAllByLeadByAndCategory(salesPartner.getId(), "Self"));

                if (leadtype.equalsIgnoreCase("self")) {

                    selfLeads = leadsRepository.findAllByLeadByAndCategory(salesPartner.getId(), "Self");

                    employeeNames = getEmployeeNames(selfLeads);

                    map.addAttribute("employeeNames", employeeNames);
                }

                if (salesPartner.getLevel().equalsIgnoreCase("1")) {

                    map.addAttribute("sharedLeads", leadsRepository.findAllByCategory("Digital"));

                    map.addAttribute("bookedLeads", leadsRepository.findAllByCategoryAndCaptureBy("Digital", salesPartner.getName()));

                }

                if (salesPartner.getLevel().equalsIgnoreCase("2")) {

                    map.addAttribute("sharedLeads", leadsRepository.findAllByCategoryAndCaptureBy("Digital", ""));

                    map.addAttribute("bookedLeads", leadsRepository.findAllByCategoryAndCaptureBy("Digital", salesPartner.getName()));
                }

                if (leadtype.equalsIgnoreCase("booked")) {

                    bookedLeads = leadsRepository.findAllByCategoryAndCaptureBy("Digital", salesPartner.getName());

                    employeeNames = getEmployeeNames(bookedLeads);

                    map.addAttribute("employeeNames", employeeNames);
                }

                map.addAttribute("orderList1", leadsList1);

                map.addAttribute("orderList2", leadsList2);

                map.addAttribute("orderList3", leadsList3);

                map.addAttribute("partner1", p1);

                map.addAttribute("partner2", p2);

                map.addAttribute("partner3", p3);

                map.addAttribute("currentDate", java.time.LocalDate.now());

                map.addAttribute("leadtype", leadtype);

            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "/leadsList";
    }

    @RequestMapping("/addLeads/{type}/{key}")
    public String addLeads(HttpServletRequest request, ModelMap map, @PathVariable String type, @PathVariable String key) {

        String salesEmployeeEmail = LoginController.getCookieSalesEmployeeEmail(request);

        SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

        map.addAttribute("level", salesPartner.getLevel());

        if (salesEmployeeEmail != "") {

            SalesEmployee salesEmployee = salesEmployeeRepository.findByEmail(salesEmployeeEmail);

            map.addAttribute("isSalesEmployeeLoggedIn", "true");

            map.addAttribute("salesEmployeeId", salesEmployee.getId());
        } else {

            map.addAttribute("isSalesEmployeeLoggedIn", "false");

            map.addAttribute("salesEmployeeId", "");
        }

        map.addAttribute("salesEmployeeList", getNamesOnly(salesPartner.getId()));

        if (type.equalsIgnoreCase("add")) {

            if (!key.equalsIgnoreCase(null)) {

                map.addAttribute("category", key);

            }

            map.addAttribute("type", "add");

            map.addAttribute("data", new Leads());

            map.addAttribute("lead_generated", salesPartner.getId());

        }

        if (type.equalsIgnoreCase("edit")) {

            map.addAttribute("type", "edit");

            map.addAttribute("data", leadsRepository.findById(key));
        }

        return "/addLead";
    }

    @RequestMapping("/addLeadsForm")
    public String addLeadsForm(HttpServletRequest request, @RequestParam MultiValueMap<String, String> parameters) {

        String key = new ObjectId().toString();

        SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

        Leads leads = new Leads(
                key,
                StringUtils.capitalize(parameters.get("name").get(0)),
                parameters.get("address").get(0),
                parameters.get("mobile").get(0),
                parameters.get("stage").get(0),
                parameters.get("captureBy").get(0),
                parameters.get("followDate").get(0),
                parameters.get("registration").get(0),
                parameters.get("leadType").get(0),
                parameters.get("leadBy").get(0),
                parameters.get("category").get(0),
                parameters.get("salesEmpID").get(0),
                parameters.get("comment").get(0));

        leadsRepository.save(leads);

        if (salesPartner.getLevel().equalsIgnoreCase("1")) {

            if (parameters.get("category").get(0).toLowerCase().equals("self") || parameters.get("category").get(0).toLowerCase().equals("digital")) {

                return "redirect:/leads" + "/" + parameters.get("category").get(0).toLowerCase();

            } else {

                return "redirect:/leads" + "/" + "booked";
            }
        } else if (salesPartner.getLevel().equalsIgnoreCase("2")) {

            if (parameters.get("category").get(0).toLowerCase().equals("self") || parameters.get("category").get(0).toLowerCase().equals("digital")) {

                return "redirect:/leads" + "/" + parameters.get("category").get(0).toLowerCase();

            } else {

                return "redirect:/leads" + "/" + "booked";
            }
        }

        return "redirect:/leads";
    }

    @RequestMapping("/updateLeadsForm/{key}")
    public String updateLeadsForm(HttpServletRequest request, @RequestParam MultiValueMap<String, String> parameters, @PathVariable String key) throws InterruptedException {

        SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

        Leads leads = new Leads();

        if (parameters.get("category").get(0).equalsIgnoreCase("Digital") && parameters.get("captureBy").get(0).equalsIgnoreCase("")) {

            leads = new Leads(
                    parameters.get("id").get(0),
                    parameters.get("name").get(0),
                    parameters.get("address").get(0),
                    parameters.get("mobile").get(0),
                    parameters.get("stage").get(0),
                    salesPartner.getName(),
                    parameters.get("followDate").get(0),
                    parameters.get("registration").get(0),
                    parameters.get("leadType").get(0),
                    parameters.get("leadBy").get(0),
                    parameters.get("category").get(0),
                    parameters.get("salesEmpID").get(0),
                    parameters.get("comment").get(0));
        } else {

            leads = new Leads(
                    parameters.get("id").get(0),
                    parameters.get("name").get(0),
                    parameters.get("address").get(0),
                    parameters.get("mobile").get(0),
                    parameters.get("stage").get(0),
                    parameters.get("captureBy").get(0),
                    parameters.get("followDate").get(0),
                    parameters.get("registration").get(0),
                    parameters.get("leadType").get(0),
                    parameters.get("leadBy").get(0),
                    parameters.get("category").get(0),
                    parameters.get("salesEmpID").get(0),
                    parameters.get("comment").get(0));
        }

        leadsRepository.save(leads);

        if (salesPartner.getLevel().equalsIgnoreCase("1") || salesPartner.getLevel().equalsIgnoreCase("2")) {

            if (parameters.get("category").get(0).toLowerCase().equals("self") || parameters.get("category").get(0).toLowerCase().equals("digital") && parameters.get("captureBy").get(0).equals(salesPartner.getName().equals(""))) {

                return "redirect:/leads" + "/" + parameters.get("category").get(0).toLowerCase();

            } else {

                return "redirect:/leads" + "/" + "booked";
            }
        }

        return "redirect:/leads";
    }

  /*  @ResponseBody
    @RequestMapping(value = "/setTabInfo")
    public String setTabInfo(@RequestParam String name) {

        tabInfo = name;

        return name;

    }*/

  /*  @ResponseBody
    @RequestMapping(value = "/setTabInfoFirst")
    public String setTabInfoFirst(@RequestParam String name) {

        System.out.println(" tabInfoFirst: ---> " + name);

        tabInfoFirst = name;

        return name;

    }*/

    @RequestMapping("/captureLead/{id}")
    public String captureLead(HttpServletRequest request, @PathVariable String id) throws InterruptedException {

        Leads leads = null;

        try {

            String salesEmployeeEmail = LoginController.getCookieSalesEmployeeEmail(request);

            if (salesEmployeeEmail != "") {

                SalesEmployee salesEmployee = salesEmployeeRepository.findByEmail(salesEmployeeEmail);

                SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

                leads = leadsRepository.findById(id);

                leads.setCaptureBy(salesPartner.getName());

                leads.setSalesEmpID(salesEmployee.getId());

                leadsRepository.save(leads);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

//        return "redirect:/leads";

//        System.out.println("category while capturing lead >>> ");

        return "redirect:/leads" + "/" + leads.getCategory().toLowerCase();
    }

    public List<String> getNamesOnly(String salesPartnerId) {

        return salesEmployeeRepository.findAllByCompanyId(salesPartnerId)
                .stream()
                .map(SalesEmployee::getName)
                .collect(Collectors.toList());
    }

    public HashMap getEmployeeNames(List<Leads> leads) {

        HashMap<String, String> employeeNames = new HashMap<>();

        try {

            ListIterator<Leads> iterator = leads.listIterator();

            while (iterator.hasNext()) {

                Leads leads1 = iterator.next();

                SalesEmployee salesEmployee = salesEmployeeRepository.findById(leads1.getSalesEmpID());

                employeeNames.put(leads1.getSalesEmpID(), salesEmployee.getName());
            }

//            System.out.println("EmployeeNames >> "+ employeeNames);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return employeeNames;
    }
}