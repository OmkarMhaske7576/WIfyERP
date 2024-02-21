package com.wify.erp.NewController;

import com.wify.erp.NewPojo.Inventory_Products;
import com.wify.erp.NewPojo.PackageBOM;
import com.wify.erp.NewPojo.Packages;
import com.wify.erp.repository.InventoryProductsRepository;
import com.wify.erp.repository.PackageBOMRepository;
import com.wify.erp.repository.PackageRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class FinanceController {

    @Autowired
    public InventoryProductsRepository inventoryProductsRepository;

    @Autowired
    public PackageRepository packageRepository;

    @Autowired
    public PackageBOMRepository packageBOMRepository;

    @RequestMapping("/finance_productlist")
    public String finance_productlist(ModelMap modelMap) {

        try {

            modelMap.addAttribute("products", inventoryProductsRepository.findAllByCategory("Product"));
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "finance_productlist";
    }

    @RequestMapping("/finance_package")
    public String finance_package(ModelMap modelMap) {

        try {

            modelMap.addAttribute("packagelist", packageRepository.findAll());
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "finance_package";
    }

    @RequestMapping("/addPackage/{type}/{key}")
    public String addPackage(ModelMap model, @PathVariable String type, @PathVariable String key) {

        int count = 0;

        try {

            if (type.equals("add")) {

                model.addAttribute("type", "add");

                model.addAttribute("package2", new Packages());

                count = packageRepository.findAll().size();

                count++;

                model.addAttribute("size", count);

            }

            if (type.equals("edit")) {

                model.addAttribute("type", "edit");

                model.addAttribute("package2", packageRepository.findById(key));
            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "addPackage";
    }

    @RequestMapping("addPackageForm")
    public String addPackage(@RequestParam MultiValueMap<String, String> parameters) {

        try {

            String id = ObjectId.get().toString();

            Packages p = new Packages(
                    id,
                    parameters.get("name").get(0),
                    parameters.get("discount").get(0),
                    parameters.get("total").get(0),
                    parameters.get("finalTotal").get(0));

            packageRepository.save(p);
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/finance_package";
    }

    @RequestMapping("/updatePackage/{updatekey}")
    public String updatePackage(@RequestParam MultiValueMap<String, String> parameters, @PathVariable String updatekey) {

        try {
            Packages p = new Packages(
                    parameters.get("id").get(0),
                    parameters.get("name").get(0),
                    parameters.get("discount").get(0),
                    parameters.get("total").get(0),
                    parameters.get("finalTotal").get(0));

            packageRepository.save(p);
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/finance_package";
    }

    @RequestMapping("/deletePackage/{id}")
    public String deletePackage(@PathVariable String id) {

        try {

            packageRepository.deleteById(id);

            packageBOMRepository.deleteByPackageID(id);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/finance_package";
    }

//    ------------------- Package BOM ---------------------------------------------

    @RequestMapping("/packageBOM/{package_id}")
    public String packageBOM(ModelMap modelMap, @PathVariable String package_id) {

        int finalTotal = 0;

        List<PackageBOM> list = new ArrayList<>();

        try {

            Packages packages = packageRepository.findById(package_id);

            modelMap.addAttribute("package_name", packages.getName());

            modelMap.addAttribute("packageID", package_id);

            modelMap.addAttribute("list", packageBOMRepository.findAllByPackageID(package_id));

            if (Integer.parseInt(packages.getDiscount()) != 0 || Integer.parseInt(packages.getDiscount()) == 0 && Integer.parseInt(packages.getFinalTotal()) == 0) {

                list = packageBOMRepository.findAllByPackageID(package_id);

                for (PackageBOM bom : list) {

                    finalTotal = (finalTotal) + Integer.parseInt(bom.getPrice()) * Integer.parseInt(bom.getQuantity()) - Integer.parseInt(bom.getPrice()) * Integer.parseInt(bom.getQuantity()) * Integer.parseInt(packages.getDiscount()) / 100;

                    System.out.println("finalTotal >> " + finalTotal);
                }

                packages.setFinalTotal(Integer.toString(finalTotal));

                packageRepository.save(packages);

            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "packageBOM";
    }

    @RequestMapping("/addPackageBOM/{type}/{id}/{packageID}")
    public String addPackageBOM(ModelMap modelMap, @PathVariable String type, @PathVariable String id, @PathVariable String packageID) {

        int count;

        try {

            Packages packages = packageRepository.findById(packageID);

            modelMap.addAttribute("productlist", getNamesOnly());

            modelMap.addAttribute("package_name", packages.getName());

            modelMap.addAttribute("packageID", packageID);

            if (type.equals("add")) {

                modelMap.addAttribute("type", "add");

                modelMap.addAttribute("PackageBOm", new PackageBOM());

                count = packageBOMRepository.findAll().size();

                count++;

                modelMap.addAttribute("size", count);
            }

            if (type.equals("edit")) {

                modelMap.addAttribute("type", "edit");

                modelMap.addAttribute("PackageBOm", packageBOMRepository.findById(id));

            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "addPackageBOM";
    }

    @ResponseBody
    @RequestMapping(value = "/getproductcode")
    public String getproductcode(@RequestParam String name) {

        String p = null;

        try {

            Inventory_Products i = inventoryProductsRepository.findByName(name);

            p = i.getProductCode();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return p;
    }

    @ResponseBody
    @RequestMapping(value = "/getproductMRP")
    public String getproductMRP(@RequestParam String name) {

        String p = null;

        try {

            Inventory_Products i = inventoryProductsRepository.findByName(name);

            p = i.getPrice();
        } catch (Exception e) {

            e.printStackTrace();
        }

        return p;
    }

    @RequestMapping("addPackageBomForm")
    public String addPackageBomForm(@RequestParam MultiValueMap<String, String> parameters) {

        try {

            String id = ObjectId.get().toString();

            PackageBOM packageBOM = new PackageBOM(
                    id,
                    parameters.get("name").get(0),
                    parameters.get("code").get(0),
                    parameters.get("price").get(0),
                    parameters.get("quantity").get(0),
                    parameters.get("packageID").get(0));

            packageBOMRepository.save(packageBOM);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/packageBOM/" + parameters.get("packageID").get(0);
    }

    @RequestMapping("/updatePackageBOMForm")
    public String updatePackageBOMForm(@RequestParam MultiValueMap<String, String> parameters) {

        try {

            PackageBOM packageBOM = new PackageBOM(
                    parameters.get("id").get(0),
                    parameters.get("name").get(0),
                    parameters.get("code").get(0),
                    parameters.get("price").get(0),
                    parameters.get("quantity").get(0),
                    parameters.get("packageID").get(0));

            packageBOMRepository.save(packageBOM);
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/packageBOM/" + parameters.get("packageID").get(0);
    }

    @RequestMapping("/deletePackageBom/{id}/{packageID}")
    public String deletePackageBom(@PathVariable String id, @PathVariable String packageID) {

        try {

            packageBOMRepository.deleteById(id);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/packageBOM/" + packageID;
    }

    @ResponseBody
    @RequestMapping(value = "/getTotalAmount")
    public int getTotalAmount(@RequestParam String total) {

        String parts[];

        String part1;

        String part2;

        try {

            parts = total.split("-");

            part1 = parts[0];

            part2 = parts[1];

            Packages packages = packageRepository.findById(part2);

            packages.setTotal(part1);

            packageRepository.save(packages);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return 0;
    }

    public List<String> getNamesOnly() {

        return inventoryProductsRepository.findAllByCategory("Product")
                .stream()
                .map(Inventory_Products::getName)
                .collect(Collectors.toList());
    }
}