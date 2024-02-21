package com.wify.erp.services;

import com.wify.erp.NewPojo.*;
import com.wify.erp.repository.*;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;

@Service
public class MethodsCalledService {

    @Autowired
    public QuotationBOMRepository quotationBOMRepository;

    @Autowired
    public InventoryProductsRepository inventoryProductsRepository;

    @Autowired
    public PackageRepository packageRepository;

    @Autowired
    public ClientRepository clientRepository;

    @Autowired
    public LeadsRepository leadsRepository;

    public void addMiniserverByDefault(String quotationId) {

        try {

            System.out.println("Inside addMiniserverByDefault >>");

            if (!quotationBOMRepository.existsByQuotationID(quotationId)) {

                String miniserverID = new ObjectId().toString();

                Inventory_Products products = inventoryProductsRepository.findByNameContains("Mini");

                QuotationBOM quotationBOM = new QuotationBOM(
                        miniserverID,
                        products.getName(),
                        products.getProductCode(),
                        "1",
                        products.getPrice(),
                        "",
                        quotationId,""
                );

                quotationBOMRepository.save(quotationBOM);

            }
        } catch (Exception e) {

            e.printStackTrace();
        }
    }

    public String fetchPackageDiscount(String quotationID) {

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
    }

    public List hideMultipleProducts(String quotationId) {

        List<QuotationBOM> list1;

        List<QuotationBOM> finalProductList = new ArrayList<>();

        list1 = quotationBOMRepository.findAllByQuotationID(quotationId);

        ListIterator iterator1 = list1.listIterator();

        while (iterator1.hasNext()) {

            QuotationBOM bom = (QuotationBOM) iterator1.next();

            if (finalProductList.size() == 0 || bom.getPname().contains("Controller")) {

                finalProductList.add(bom);

            } else {

                for (int i = 0; i < finalProductList.size(); i++) {

                    if (finalProductList.get(i).getPname().equalsIgnoreCase(bom.getPname())) {

                        int quantity = Integer.parseInt(finalProductList.get(i).getQuantity()) + Integer.parseInt(bom.getQuantity());

                        finalProductList.get(i).setQuantity(Integer.toString(quantity));

                        break;

                    } else if (!finalProductList.get(i).getPname().equalsIgnoreCase(bom.getPname()) && (finalProductList.size() - 1) == i) {

                        finalProductList.add(bom);

                        break;

                    } else {

                    }

                }

            }

        }

        return finalProductList;
    }

    public String fetchClientName(String type, String id) {

        String name = null;

        if (type.equalsIgnoreCase("lead")) {

            Leads lead = leadsRepository.findById(id);

            name = lead.getName();
        }
        if (type.equalsIgnoreCase("client")) {

            Client client = clientRepository.findById(id);

            name = client.getName();
        }
        return name;
    }
}
