package com.wify.erp.NewController;

import com.wify.erp.NewPojo.*;
import com.wify.erp.pojo.Transactions;
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

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.ListIterator;

@Controller
public class TransactionsController {

    @Autowired
    public MethodsCalledService methodsCalledService;

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private QuotationBOMRepository quotationBOMRepository;

    @Autowired
    private QuotationRepository quotationRepository;

    @Autowired
    private PackageRepository packageRepository;

    @Autowired
    private SalesPartnerRepository salesPartnerRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private LeadsRepository leadsRepository;

    @Autowired
    private ClientRepository clientRepository;

    @RequestMapping("/transactionsList/{quotationId}")
    public String transactionsList(HttpServletRequest request, ModelMap map, @PathVariable String quotationId) {

        int total = 0;

        List<QuotationBOM> quotationBOMList;

        try {

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            Quotation quotation = quotationRepository.findById(quotationId);

            map.addAttribute("clientID", quotation.getClientId());

            map.addAttribute("quotationId", quotationId);

            map.addAttribute("quotationNo", quotation.getqNum());

            if (leadsRepository.existsById(quotation.getClientId())) {

                map.addAttribute("clientType", "lead");

                map.addAttribute("clientName", methodsCalledService.fetchClientName("lead", quotation.getClientId()));

            } else if (clientRepository.existsById(quotation.getClientId())) {

                map.addAttribute("clientType", "client");

                map.addAttribute("clientName", methodsCalledService.fetchClientName("client", quotation.getClientId()));

            }

//            System.out.println("SalesPartner email >> "+ salesPartner.getEmail() +"  Level >> "+ salesPartner.getLevel());

            map.addAttribute("level", salesPartner.getLevel());

            map.addAttribute("transactions", transactionRepository.findAllByQuotationId(quotationId));

            quotationBOMList = quotationBOMRepository.findAllByQuotationID(quotationId);

            int extraDiscount = Integer.parseInt(quotation.getExtraDiscount());

//            System.out.println("extraDiscount >> " + extraDiscount);

            ListIterator<QuotationBOM> iterator = quotationBOMList.listIterator();

            int packagePrice = 0;

            while (iterator.hasNext()) {

                QuotationBOM bom = iterator.next();

                int packageDiscount = 0;

                if (bom.getPackageName().trim().length() > 0) {

                    if (packagePrice == 0) {

                        System.out.println("packagePrice >> ");

                        Packages packages = packageRepository.findByName(bom.getPackageName());

                        packagePrice = Integer.parseInt(packages.getFinalTotal());

                        int finalPrice = packagePrice - packagePrice * (extraDiscount) / 100;

                        total = total + finalPrice;

                    } else {

                        System.out.println("Do Nothing >> ");
                    }

                } else {

                    int productPrice = Integer.parseInt(bom.getQuantity()) * Integer.parseInt(bom.getPrice());

                    System.out.println(bom.getPname() + ">> " + productPrice);

                    int finalPrice = productPrice - productPrice * (extraDiscount) / 100;

                    total = total + finalPrice;
                }
            }

//            System.out.println("Quotation Price >> " + total);

            map.addAttribute("TotalAmount", total);

            String employeeEmail = LoginController.getCookieEmployeeEmail(request);

            System.out.println("employeeEmail >> "+ employeeEmail);

            if (employeeEmail != "") {

                map.addAttribute("isEmployeeLoggedIn","true");
            }
            else {
                map.addAttribute("isEmployeeLoggedIn","false");
            }

            String salesEmployeeEmail = LoginController.getCookieSalesEmployeeEmail(request);

            if (salesEmployeeEmail != "") {

                map.addAttribute("isSalesEmployeeLoggedIn", "true");
            }
            else {

                map.addAttribute("isSalesEmployeeLoggedIn", "false");
            }




        } catch (Exception e) {

            e.printStackTrace();
        }
        return "transactionsList";
    }

    @RequestMapping("/addTransaction/{type}/{key}/{quotationId}")
    public String addTransaction(ModelMap map, @PathVariable String type, @PathVariable String key, @PathVariable String quotationId) {

        try {

            Quotation quotation = quotationRepository.findById(quotationId);

            map.addAttribute("clientID", quotation.getClientId());

            map.addAttribute("quotationId", quotationId);

            map.addAttribute("quotationNo", quotation.getqNum());

            if (leadsRepository.existsById(quotation.getClientId())) {

                map.addAttribute("clientType", "lead");

                map.addAttribute("clientName", methodsCalledService.fetchClientName("lead", quotation.getClientId()));

            } else if (clientRepository.existsById(quotation.getClientId())) {

                map.addAttribute("clientType", "client");

                map.addAttribute("clientName", methodsCalledService.fetchClientName("client", quotation.getClientId()));

            }

            map.addAttribute("type", type);

            if (type.equalsIgnoreCase("add")) {

                map.addAttribute("quotationId", quotationId);

                map.addAttribute("transactionObj", new Transactions());

            }

            if (type.equalsIgnoreCase("edit")) {

                map.addAttribute("transactionObj", transactionRepository.findById(key));

            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "addTransaction";
    }

    @RequestMapping("/addTransactionForm")
    public String addTransactionForm(@RequestParam MultiValueMap<String, String> parameters) {

        Boolean paidStatus = false;
        try {

            String id = new ObjectId().toString();

            Transactions transactions = new Transactions(
                    id,
                    parameters.get("quotationId").get(0),
                    parameters.get("payment_type").get(0),
                    parameters.get("payment_mode").get(0),
                    parameters.get("amount").get(0),
                    parameters.get("transaction_id").get(0),
                    parameters.get("transaction_date").get(0)
            );

            transactionRepository.save(transactions);

            paidStatus = checkForFullyPaymentDone(parameters.get("quotationId").get(0));

            if (paidStatus) {

                if (orderRepository.existsByQuotationId(parameters.get("quotationId").get(0))) {

                    Order order = orderRepository.findByQuotationId(parameters.get("quotationId").get(0));

                    order.setPayStatus("Paid");

                    orderRepository.save(order);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/transactionsList/" + parameters.get("quotationId").get(0);
    }

    @RequestMapping("/updateTransactionForm")
    public String updateTransactionForm(@RequestParam MultiValueMap<String, String> parameters) {

        try {

            Transactions transactions = new Transactions(
                    parameters.get("id").get(0),
                    parameters.get("quotationId").get(0),
                    parameters.get("payment_type").get(0),
                    parameters.get("payment_mode").get(0),
                    parameters.get("amount").get(0),
                    parameters.get("transaction_id").get(0),
                    parameters.get("transaction_date").get(0)
            );

            transactionRepository.save(transactions);
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/transactionsList/" + parameters.get("quotationId").get(0);
    }

    /** ---------------- Print Receipt ---------------- */

    @RequestMapping("/printReceipt/{id}")
    public String printReceipt(ModelMap map, @PathVariable String id){

        try{

            Transactions t1 = transactionRepository.findById(id);

            Quotation q1 = quotationRepository.findById(t1.getQuotationId());

            Client client = clientRepository.findById(q1.getClientId());

            map.addAttribute("clientName",client.getName());

            map.addAttribute("amount", t1.getAmount());

            map.addAttribute("through", t1.getTransaction_id());

            map.addAttribute("quotationNo", q1.getqNum());

        }
        catch (Exception e){

            e.printStackTrace();
        }

        return "receipt";
    }

    public Integer fetchPackageDiscount(String packageName) {

        int discount = 0;

        try {

            Packages p = packageRepository.findByName(packageName);

            discount = Integer.parseInt(p.getDiscount());

        } catch (Exception e) {

            e.printStackTrace();
        }

        return discount;
    }

    public Boolean checkForFullyPaymentDone(String quotationId) {

        int total = 0;

        Quotation quotation = null;

        List<QuotationBOM> quotationBOMList = null;

        List<Transactions> transactionsList = null;

        int transactionAmount = 0;

        Boolean paidStatus = false;

        try {

            quotation = quotationRepository.findById(quotationId);

            quotationBOMList = quotationBOMRepository.findAllByQuotationID(quotationId);

            int extraDiscount = Integer.parseInt(quotation.getExtraDiscount());

            ListIterator<QuotationBOM> iterator = quotationBOMList.listIterator();

            while (iterator.hasNext()) {

                QuotationBOM bom = iterator.next();

                int packageDiscount = 0;

                int productPrice = Integer.parseInt(bom.getQuantity()) * Integer.parseInt(bom.getPrice());

                int finalPrice = productPrice - productPrice * (extraDiscount + packageDiscount) / 100;

                total = total + finalPrice;

            }

            transactionsList = transactionRepository.findAllByQuotationId(quotationId);

            ListIterator<Transactions> listIterator = transactionsList.listIterator();

            while (listIterator.hasNext()) {

                Transactions transactions = listIterator.next();

                transactionAmount = transactionAmount + Integer.parseInt(transactions.getAmount());

            }

            System.out.println("Quotation Price >> " + total);

            System.out.println("Transactions Amount >> " + transactionAmount);

            if (total - transactionAmount == 0) {

                paidStatus = true;

            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return paidStatus;
    }

   /* public String fetchClientName(String type, String id) {

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
    }*/

 /*   public List<String> getNamesOnly(String id) {

        return quotationRepository.findAllByClientId(id)
                .stream()
                .map(Quotation::getqNum)
                .collect(Collectors.toList());
    }*/

}
