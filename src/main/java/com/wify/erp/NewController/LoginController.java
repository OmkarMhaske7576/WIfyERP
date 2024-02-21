package com.wify.erp.NewController;

import com.wify.erp.NewPojo.Employee;
import com.wify.erp.NewPojo.Manager;
import com.wify.erp.NewPojo.SalesEmployee;
import com.wify.erp.NewPojo.SalesPartner;
import com.wify.erp.repository.EmployeeRepository;
import com.wify.erp.repository.ManagerRepository;
import com.wify.erp.repository.SalesEmployeeRepository;
import com.wify.erp.repository.SalesPartnerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Base64;

@Controller
public class LoginController {

    @Autowired
    public SalesPartnerRepository salesPartnerRepository;

    @Autowired
    public ManagerRepository managerRepository;

    @Autowired
    public SalesEmployeeRepository salesEmployeeRepository;

    @Autowired
    public EmployeeRepository employeeRepository;

    public static String getCookieEmail(HttpServletRequest request) {

        String data = "";

        try {

            if (request.getCookies() != null) {

                for (Cookie c : request.getCookies()) {

                    if (c.getName().equals("email")) {

                        data = decodeVal(c.getValue());
                    }
                }
            }
        } catch (Exception e) {

            e.printStackTrace();
        }
        return data;
    }

    public static String getCookieSalesEmployeeEmail(HttpServletRequest request) {

        String data = "";

        try {

            if (request.getCookies() != null) {

                for (Cookie c : request.getCookies()) {

                    if (c.getName().equals("SalesEmployee")) {

                        data = decodeVal(c.getValue());
                    }
                }
            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return data;
    }

    public static String getCookieEmployeeEmail(HttpServletRequest request) {

        String data = "";

        try {

            if (request.getCookies() != null) {

                for (Cookie c : request.getCookies()) {

                    if (c.getName().equals("Employee")) {

                        data = decodeVal(c.getValue());
                    }
                }
            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return data;
    }

    @RequestMapping("/")
    public String login(HttpServletRequest request, ModelMap model) {

        String email = null;

        String token = null;

        try {

            if (salesPartnerRepository.findAll().size() == 0) {

                model.addAttribute("company_email", "");

                model.addAttribute("level", "");

                model.addAttribute("loggedInName", "");

                return "/home";
            }

            email = getCookies(request, "email");

            token = getCookies(request, "token");

            if (email != "" && token != "") {

                return "redirect:/home";
            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "/login";
    }

    @ResponseBody
    @RequestMapping(value = "/managerLoggedInCheck")
    public String managerLoggedInCheck(@RequestParam String name) {

        String val = null;

        try {

            if (managerRepository.existsByEmail(name)) {

                Manager manager = managerRepository.findByEmail(name);

                SalesPartner salesPartner = salesPartnerRepository.findById(manager.getCompanyID());

                val = "Manager" + "#"+salesPartner.getEmail();

            }
            else if (salesEmployeeRepository.existsByEmail(name)){

                SalesEmployee salesEmployee = salesEmployeeRepository.findByEmail(name);

                SalesPartner salesPartner = salesPartnerRepository.findById(salesEmployee.getCompanyId());

                val = "SalesEmployee" + "#"+salesPartner.getEmail();

            }else if (employeeRepository.existsByEmail(name)){

                SalesPartner salesPartner = salesPartnerRepository.findByLevel("0");

                val = "Employee" + "#"+salesPartner.getEmail();

            }
            else {

                val = "Admin" + "#" + "null";
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return val;
    }

   /* @ResponseBody
    @RequestMapping("/loginCheck")
    public String loginForm(HttpServletResponse response, @RequestParam String name) {

        String token = name.split("@@")[0];

        String email = name.split("@@")[1];

        if (managerRepository.existsByEmail(email)) {

            Manager manager = managerRepository.findByEmail(email);

            SalesPartner salesPartner = salesPartnerRepository.findById(manager.getCompanyID());

            Cookie cookie = new Cookie("email", salesPartner.getEmail());

            Cookie cookie1 = new Cookie("token", token);

            Cookie cookie2 = new Cookie("manager", email);

            cookie.setMaxAge(7 * 24 * 60 * 60);
            cookie.setSecure(true);

            cookie1.setMaxAge(7 * 24 * 60 * 60);
            cookie1.setSecure(true);

            cookie2.setMaxAge(7 * 24 * 60 * 60);
            cookie2.setSecure(true);

            response.addCookie(cookie);

            response.addCookie(cookie1);

            response.addCookie(cookie2);

        } else {

            Cookie cookie = new Cookie("email", email);

            Cookie cookie1 = new Cookie("token", token);

            cookie.setMaxAge(7 * 24 * 60 * 60);
            cookie.setSecure(true);

            cookie1.setMaxAge(7 * 24 * 60 * 60);
            cookie1.setSecure(true);

            response.addCookie(cookie);

            response.addCookie(cookie1);

        }

        return null;
    }*/

    @RequestMapping("/home")
    public String loginComplete(ModelMap model, HttpServletRequest request) throws InterruptedException {

        String email = getCookies(request, "email");

        String token = getCookies(request, "token");

        String manageremail = getCookies(request, "manager");

        String salesEmployeeEmail = getCookies(request,"SalesEmployee");

        String employeeEmail = getCookies(request,"Employee");

        SalesPartner salesPartner1 = salesPartnerRepository.findByEmail(email);

        if (email != "" && token != "") {

            if (manageremail == "" && salesEmployeeEmail == "" && employeeEmail == "") {

                if (salesPartner1 != null) {

//                    System.out.println("1 >>");

                    model.addAttribute("company_email", salesPartner1.getEmail());

                    model.addAttribute("level", salesPartner1.getLevel());

                    model.addAttribute("loggedInName", salesPartner1.getName());

                    model.addAttribute("isManagerLoggedIn", "false");

                    model.addAttribute("isSalesEmployeeLoggedIn", "false");

                    model.addAttribute("isEmployeeLoggedIn", "false");

                } else {

//                    System.out.println("2 >>");

                    System.out.println("salesPartner is null !! ");

                    return "/login";
                }

            } else {

                if (manageremail != "") {

//                    System.out.println("3 >>");

                    Manager manager1 = managerRepository.findByEmail(manageremail);

                    model.addAttribute("company_email", manager1.getEmail());

                    model.addAttribute("level", manager1.getLevel());

                    model.addAttribute("loggedInName", manager1.getName());

                    model.addAttribute("isManagerLoggedIn", "true");

                    model.addAttribute("isSalesEmployeeLoggedIn", "false");

                    model.addAttribute("isEmployeeLoggedIn", "false");

                }
                else if (salesEmployeeEmail != "") {

//                    System.out.println("4 >>");

                    SalesEmployee salesEmployee1 = salesEmployeeRepository.findByEmail(salesEmployeeEmail);

                    model.addAttribute("company_email", salesEmployee1.getEmail());

                    model.addAttribute("level", salesPartner1.getLevel());

                    model.addAttribute("loggedInName", salesEmployee1.getName());

                    model.addAttribute("isManagerLoggedIn", "false");

                    model.addAttribute("isSalesEmployeeLoggedIn", "true");

                    model.addAttribute("isEmployeeLoggedIn", "false");

                }
                else if (employeeEmail != "") {

//                    System.out.println("5 >>");

                    Employee employee = employeeRepository.findByEmail(employeeEmail);

                    model.addAttribute("company_email", employee.getEmail());

                    model.addAttribute("level", salesPartner1.getLevel());

                    model.addAttribute("loggedInName", employee.getName());

                    model.addAttribute("isManagerLoggedIn", "false");

                    model.addAttribute("isSalesEmployeeLoggedIn", "false");

                    model.addAttribute("isEmployeeLoggedIn", "true");

                }
                else {

                    System.out.println("6 >>");

                    System.out.println("Manager or SalesEmployee is null !! ");

                    return "/login";
                }
            }
            return "/home";
        }
        return "redirect:/";
    }
/*
    @ResponseBody
    @RequestMapping("/logoutCheck")
    public String logoutCheck(HttpServletResponse response) {

        String data = "success";

        Cookie cookie = new Cookie("email", "");

        Cookie cookie1 = new Cookie("token", "");

        Cookie cookie2 = new Cookie("manager", "");

        response.addCookie(cookie);

        response.addCookie(cookie1);

        response.addCookie(cookie2);

        return data;
    }*/

    public String getCookies(HttpServletRequest request, String cookieType) {

        String data = "";

        try {

            if (request.getCookies() != null) {

                for (Cookie c : request.getCookies()) {

                    if (c.getName().equals("email") && cookieType.equalsIgnoreCase("email")) {

                        data = decodeVal(c.getValue());

                    } else if (c.getName().equals("token") && cookieType.equalsIgnoreCase("token")) {

                        data = c.getValue();

                    } else if (c.getName().equals("manager") && cookieType.equalsIgnoreCase("manager")) {

                        data = decodeVal(c.getValue());
                    }
                    else if (c.getName().equals("SalesEmployee") && cookieType.equalsIgnoreCase("SalesEmployee")) {

                        data = decodeVal(c.getValue());
                    }
                    else if (c.getName().equals("Employee") && cookieType.equalsIgnoreCase("Employee")) {

                        data = decodeVal(c.getValue());
                    }
                }
            }
        } catch (Exception e) {

            e.printStackTrace();
        }
        return data;
    }

    public static String decodeVal(String type){

        Base64.Decoder decoder = Base64.getDecoder();
        byte[] decodedByte = decoder.decode(type);
        String decodedString = new String(decodedByte);
        return decodedString;
    }

}