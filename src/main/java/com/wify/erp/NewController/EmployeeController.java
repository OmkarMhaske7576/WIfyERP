package com.wify.erp.NewController;

import com.wify.erp.NewPojo.Employee;
import com.wify.erp.NewPojo.Order;
import com.wify.erp.repository.EmployeeRepository;
import com.wify.erp.repository.OrderRepository;
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
import java.util.Optional;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    public OrderRepository orderRepository;

    @RequestMapping("/employeelist")
    public String employeelist(ModelMap modelMap){

        try{

            modelMap.addAttribute("employee", employeeRepository.findAll());

        }
        catch (Exception e){

            e.printStackTrace();
        }

        return "employeelist";
    }

    @RequestMapping("/addemployee/{type}/{updatekey}")
    public String addemployee(ModelMap model, @PathVariable String type, @PathVariable String updatekey) {

        try {

            if (type.equals("add")) {

                model.addAttribute("type", "add");

                model.addAttribute("emp" , new Employee());

            }

            if (type.equals("edit")) {

                model.addAttribute("type", "edit");

                model.addAttribute("emp" ,  employeeRepository.findById(updatekey));

            }

        }
        catch (Exception e){

            e.printStackTrace();
        }

        return "addEmployee";
    }

    @RequestMapping("/addEmployeeForm")
    public String addClientForm(@RequestParam MultiValueMap<String, String> parameters) {

        try {

            String id = ObjectId.get().toString();

            Employee e1 = new Employee(id,
                    parameters.get("name").get(0),
                    parameters.get("bgroup").get(0),
                    parameters.get("gender").get(0),
                    parameters.get("address").get(0),
                    parameters.get("designation").get(0),
                    parameters.get("email").get(0),
                    parameters.get("mobile").get(0),
                    parameters.get("altmobile").get(0),
                    parameters.get("join_date").get(0),
                    parameters.get("dob").get(0)
            );

            employeeRepository.save(e1);

        }
        catch (Exception e){

            e.printStackTrace();
        }

        return "redirect:/employeelist";
    }

    @RequestMapping("/updateEmployeeForm/{updatekey}")
    public String updateEmployeeForm(@RequestParam MultiValueMap<String, String> parameters,@PathVariable String updatekey){

        try {

            Employee e1 = new Employee(parameters.get("id").get(0),
                    parameters.get("name").get(0),
                    parameters.get("bgroup").get(0),
                    parameters.get("gender").get(0),
                    parameters.get("address").get(0),
                    parameters.get("designation").get(0),
                    parameters.get("email").get(0),
                    parameters.get("mobile").get(0),
                    parameters.get("altmobile").get(0),
                    parameters.get("join_date").get(0),
                    parameters.get("dob").get(0)
            );

            employeeRepository.save(e1);
        }
        catch (Exception e){

            e.printStackTrace();
        }

        return "redirect:/employeelist";
    }

    @RequestMapping("/deleteEmployee/{deletekey}")
    public  String deleteEmployee(@PathVariable String deletekey){

        try {

            employeeRepository.deleteById(deletekey);
        }

        catch (Exception e){

            e.printStackTrace();
        }

        return "redirect:/employeelist";
    }

    @RequestMapping("/employeeOrdersList")
    public String employeeOrdersList(HttpServletRequest request, ModelMap map){

        try{

            String employeeEmail = LoginController.getCookieEmployeeEmail(request);

            System.out.println("employeeEmail >> "+ employeeEmail);

            Employee employee = employeeRepository.findByEmail(employeeEmail);

            map.addAttribute("employeeID",employee.getId());

            map.addAttribute("employeeOrderList",orderRepository.findAllByInstallerID(employee.getId()));

            map.addAttribute("isEmployeeLoggedIn","true");

        }
        catch (Exception e){

            e.printStackTrace();
        }

        return "employeeOrderList";
    }

    @RequestMapping("/viewEmployeeOrdersList/{employeeID}")
    public String employeeOrdersList(HttpServletRequest request, ModelMap map,@PathVariable String employeeID){

        try{

            Employee employee = employeeRepository.findById(employeeID);

            map.addAttribute("employeeName",employee.getName());

            map.addAttribute("employeeID",employeeID);

            map.addAttribute("employeeOrderList",orderRepository.findAllByInstallerID(employeeID));

            map.addAttribute("isEmployeeLoggedIn","false");

        }
        catch (Exception e){

            e.printStackTrace();
        }

        return "employeeOrderList";
    }
}