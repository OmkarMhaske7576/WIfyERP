package com.wify.erp.NewController;

import com.wify.erp.NewPojo.Manager;
import com.wify.erp.NewPojo.SalesPartner;
import com.wify.erp.repository.ManagerRepository;
import com.wify.erp.repository.SalesPartnerRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ManagerController {

    @Autowired
    private ManagerRepository managerRepository;

    @Autowired
    private SalesPartnerRepository salesPartnerRepository;

    @RequestMapping("/managersList")
    public String managersList(ModelMap map, HttpServletRequest request){

        try{

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            map.addAttribute("level",salesPartner.getLevel());

            map.addAttribute("managersList",managerRepository.findAllByCompanyID(salesPartner.getId()));

        }
        catch (Exception e){

            e.printStackTrace();
        }

        return "managersList";
    }

    @RequestMapping("/addManager/{type}/{key}")
    public String addManager(HttpServletRequest request, ModelMap map, @PathVariable String type, @PathVariable String key){

        try{

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            map.addAttribute("type",type);

            map.addAttribute("level",salesPartner.getLevel());

            if (type.equalsIgnoreCase("add")){

                map.addAttribute("manager", new Manager());

                map.addAttribute("companyID",salesPartner.getId());

            }

            if (type.equalsIgnoreCase("edit")){

                Manager manager = managerRepository.findById(key);

                map.addAttribute("manager",manager);

            }

        }
        catch(Exception e){

            e.printStackTrace();
        }

        return "addManager";
    }

    @RequestMapping("/addManagerForm")
    public String addManagerForm(@RequestParam MultiValueMap<String,String> parameters){

        try{

            String key = new ObjectId().toString();

            Manager manager = new Manager(
                    key,
                    parameters.get("name").get(0),
                    parameters.get("mobile").get(0),
                    parameters.get("address").get(0),
                    parameters.get("email").get(0),
                    parameters.get("date").get(0),
                    parameters.get("level").get(0),
                    parameters.get("companyID").get(0),
                    parameters.get("status").get(0),
                    parameters.get("comment").get(0));

            managerRepository.save(manager);

        }
        catch(Exception e){

            e.printStackTrace();
        }

        return "redirect:/managersList";
    }

    @RequestMapping("/updateManagerForm")
    public String updateManagerForm(@RequestParam MultiValueMap<String, String> parameters){

        try{

            Manager manager = new Manager(
                    parameters.get("id").get(0),
                    parameters.get("name").get(0),
                    parameters.get("mobile").get(0),
                    parameters.get("address").get(0),
                    parameters.get("email").get(0),
                    parameters.get("date").get(0),
                    parameters.get("level").get(0),
                    parameters.get("companyID").get(0),
                    parameters.get("status").get(0),
                    parameters.get("comment").get(0));

            managerRepository.save(manager);

        }
        catch(Exception e){

            e.printStackTrace();
        }

        return "redirect:/managersList";
    }

}
