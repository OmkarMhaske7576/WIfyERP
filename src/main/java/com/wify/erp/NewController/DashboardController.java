package com.wify.erp.NewController;

import com.google.gson.Gson;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.properties.TextAlignment;
import com.wify.erp.NewPojo.*;
import com.wify.erp.repository.*;
import com.wify.erp.services.MethodsCalledService;
import org.bson.BsonBinarySubType;
import org.bson.types.Binary;
import org.bson.types.ObjectId;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class DashboardController {

    @Autowired
    public MethodsCalledService methodsCalledService;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private QuotationRepository quotationRepository;

    @Autowired
    private QuotationBOMRepository quotationBOMRepository;

    @Autowired
    private PackageRepository packageRepository;

    @Autowired
    private SalesPartnerRepository salesPartnerRepository;

    @Autowired
    private PhotoRepository photoRepository;

    @Autowired
    private SalesEmployeeRepository salesEmployeeRepository;

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private LeadsRepository leadsRepository;

    @Autowired
    private EmployeeRepository employeeRepository;

    private static BufferedImage resize(BufferedImage img, int height, int width) {
        Image tmp = img.getScaledInstance(width, height, Image.SCALE_SMOOTH);
        BufferedImage resized = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g2d = resized.createGraphics();
        g2d.drawImage(tmp, 0, 0, null);
        g2d.dispose();
        return resized;
    }

    @RequestMapping("/dashboard")
    public String dashboard(HttpServletRequest request, ModelMap modelMap) throws IOException {

        HashMap<String, Integer> monthwiseSale = new HashMap<>();

        HashMap<String, Integer> yearwiseSale = new HashMap<>();

        yearwiseSale.clear();

        monthwiseSale.clear();

        List<Order> orderList;

        List<QuotationBOM> quotationBOMList;

        int extraDiscount = 0;

        int orderQuantity;

        Float packageDiscount = 0.0f;

        Float finalDiscount = 0.0f;

  /*      FileReader reader=new FileReader("E:\\Projects\\LatestERP\\WifyERP\\src\\main\\resources\\application.properties");

        Properties properties=new Properties();
        properties.load(reader);

        System.out.println(">>>>>> " + properties.getProperty("server.port"));*/

     /*   Properties p=System.getProperties();
        Set set=p.entrySet();

        Iterator itr=set.iterator();
        while(itr.hasNext()){
            Map.Entry entry=(Map.Entry)itr.next();
            System.out.println(entry.getKey()+" = "+entry.getValue());
        }*/

        SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

        String employeeEmail = LoginController.getCookieEmployeeEmail(request);

        String salesEmployeeEmail1 = LoginController.getCookieSalesEmployeeEmail(request);

        modelMap.addAttribute("salesPartnerName",salesPartner.getName());

        if (employeeEmail == "" && salesEmployeeEmail1 == ""){

//            System.out.println("employeeLoggedIn false");

            modelMap.addAttribute("employeeLoggedIn","false");

        }
        else if (salesEmployeeEmail1 != ""){

//            System.out.println("salesEmployeeLoggedIn true");

            modelMap.addAttribute("employeeLoggedIn","true");

        }
        else if (employeeEmail != ""){

//            System.out.println("employeeEmail true");

            modelMap.addAttribute("employeeLoggedIn","true");

        }

        if (salesPartnerRepository.findAll().size() == 0) {

            modelMap.addAttribute("dashboard", "dashboard");

            modelMap.addAttribute("monthwiseSale", monthwiseSale);

            modelMap.addAttribute("yearWiseSale", yearwiseSale);

        } else {

            String salesEmployeeEmail = LoginController.getCookieSalesEmployeeEmail(request);

            if (salesEmployeeEmail != "") {

                SalesEmployee salesEmployee = salesEmployeeRepository.findByEmail(salesEmployeeEmail);

                orderList = fetchCompanyOrders(salesPartner.getLevel(), salesEmployee.getId(), true);
            } else {

                orderList = fetchCompanyOrders(salesPartner.getLevel(), salesPartner.getId(), false);
            }

            modelMap.addAttribute("dashboard", "dashboard");

            ListIterator<Order> iterator1 = orderList.listIterator();

            while (iterator1.hasNext()) {

                Order order = iterator1.next();

                Quotation quotation = quotationRepository.findById(order.getQuotationId());

                orderQuantity = Integer.parseInt(quotation.getOrderQuantity());

                extraDiscount = Integer.parseInt(quotation.getExtraDiscount());

                packageDiscount = (Float.parseFloat(methodsCalledService.fetchPackageDiscount(quotation.getId())));

                quotationBOMList = quotationBOMRepository.findAllByQuotationID(quotation.getId());

                ListIterator<QuotationBOM> iterator2 = quotationBOMList.listIterator();

                float mm = 0.0f;

                while (iterator2.hasNext()) {

                    QuotationBOM bom = iterator2.next();

                    int productPrice = Integer.parseInt(bom.getPrice());

                    int productQuantity = Integer.parseInt(bom.getQuantity()) * orderQuantity;

                    Float finalPrice;

                    if (bom.getPackageName().trim().length() > 0){

//                        finalDiscount = extraDiscount + packageDiscount;

                       int applyPackageDiscount = Math.round((productPrice * productQuantity) - (productPrice * productQuantity) * packageDiscount / 100);

                       finalPrice = applyPackageDiscount - applyPackageDiscount * (float)(extraDiscount) / 100;
                    }
                    else{

                        finalDiscount = new Float(extraDiscount);

                        finalPrice = (productPrice * productQuantity) - (productPrice * productQuantity) * finalDiscount / 100;

                    }

//                    System.out.println("finalDiscount >> "+ finalDiscount);

                    mm = mm + finalPrice;

                    System.out.print(bom.getPname()+" >> ");

                    System.out.println(Math.round(finalPrice));

                    String[] orderDate = order.getOrderDate().split("-");

                    String month = orderDate[1];

                    String year = orderDate[0];

                    /** -------------------------- Year wise Sale start---------------------------------- **/

                    if (yearwiseSale.containsKey(year)) {

                        yearwiseSale.computeIfPresent(year, (k, v) -> v + Math.round(finalPrice));
                    } else {

                        yearwiseSale.put(year, Math.round(finalPrice));
                    }

                    /** -------------------------- Month wise Sale Start ---------------------------------- **/

                    Month months = Month.of(Integer.parseInt(month));

                    String m = months + year;

                    if (monthwiseSale.containsKey(m)) {

                        monthwiseSale.computeIfPresent(m, (k, v) -> v + Math.round(finalPrice));
                    } else {

                        monthwiseSale.put(m, Math.round(finalPrice));
                    }

                }

                System.out.println("MM >> "+ Math.round(mm));

                System.out.println("Order end ------------------------------------------------------------- ");
            }

            modelMap.addAttribute("monthwiseSale", monthwiseSale);

            modelMap.addAttribute("yearWiseSale", yearwiseSale);

            modelMap.addAttribute("level", salesPartner.getLevel());

            modelMap.addAttribute("salesPartnerID", "null");

            /**  ------------ Display Photo ------------ */

       /* Photo photo1 = getPhoto("63e37cc8cf94d6190c26f243");

        modelMap.addAttribute("image",
                Base64.getEncoder().encodeToString(photo1.getImage().getData()));*/


        }

        if (employeeEmail == "" && salesEmployeeEmail1 == "") {

//                System.out.println("Getting Sales Partner Data >>");

//                System.out.println("getNamesOnly >> " + getNamesOnly());

            modelMap.addAttribute("salesPartners", getNamesOnly());

        }

        return "dashboard";
    }

    /**
     * ---------------------- Child Sales Partner Dashboard ------------------------
     **/

    @RequestMapping("/viewSalesPartnerData/{id}")
    public String viewSalesPartnerData(HttpServletRequest request, ModelMap modelMap, @PathVariable String id) {

        try {

            HashMap<String, Integer> monthwiseSale = new HashMap<>();

            HashMap<String, Integer> yearwiseSale = new HashMap<>();

            yearwiseSale.clear();

            monthwiseSale.clear();

            List<Order> orderList;

            List<QuotationBOM> quotationBOMList;

            int extraDiscount = 0;

            int orderQuantity;

            int packageDiscount;

            modelMap.addAttribute("salesPartnerID", id);

            SalesPartner parentSalesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            modelMap.addAttribute("level", parentSalesPartner.getLevel());

            SalesPartner salesPartner = salesPartnerRepository.findById(id);

            modelMap.addAttribute("name", salesPartner.getName());

            modelMap.addAttribute("employeeLoggedIn","false");

            modelMap.addAttribute("salesPartnerName",salesPartner.getName());

            if (salesPartnerRepository.findAll().size() == 0) {

                modelMap.addAttribute("dashboard", "salesPartnerDashboard");

                modelMap.addAttribute("monthwiseSale", monthwiseSale);

                modelMap.addAttribute("yearWiseSale", yearwiseSale);

            } else {

                orderList = fetchCompanyOrders(salesPartner.getLevel(), salesPartner.getId(), false);

                modelMap.addAttribute("dashboard", "salesPartnerDashboard");

                ListIterator<Order> iterator1 = orderList.listIterator();

                while (iterator1.hasNext()) {

                    Order order = iterator1.next();

                    Quotation quotation = quotationRepository.findById(order.getQuotationId());

                    orderQuantity = Integer.parseInt(quotation.getOrderQuantity());

                    extraDiscount = Integer.parseInt(quotation.getExtraDiscount());

                    packageDiscount = Integer.parseInt(methodsCalledService.fetchPackageDiscount(quotation.getId()));

                    quotationBOMList = quotationBOMRepository.findAllByQuotationID(quotation.getId());

                    ListIterator<QuotationBOM> iterator2 = quotationBOMList.listIterator();

                    while (iterator2.hasNext()) {

                        QuotationBOM bom = iterator2.next();

                        int productPrice = Integer.parseInt(bom.getPrice());

                        int productQuantity = Integer.parseInt(bom.getQuantity()) * orderQuantity;

                        int finalDiscount = extraDiscount + packageDiscount;

                        int finalPrice = (productPrice * productQuantity) - (productPrice * productQuantity) * finalDiscount / 100;

                        String[] orderDate = order.getOrderDate().split("-");

                        String month = orderDate[1];

                        String year = orderDate[0];

                        /** -------------------------- Year wise Sale start---------------------------------- **/

                        if (yearwiseSale.containsKey(year)) {

                            yearwiseSale.computeIfPresent(year, (k, v) -> v + finalPrice);
                        } else {

                            yearwiseSale.put(year, finalPrice);
                        }

                        /** -------------------------- Month wise Sale Start ---------------------------------- **/

                        Month months = Month.of(Integer.parseInt(month));

                        String m = months + year;

                        if (monthwiseSale.containsKey(m)) {

                            monthwiseSale.computeIfPresent(m, (k, v) -> v + finalPrice);
                        } else {

                            monthwiseSale.put(m, finalPrice);
                        }

                    }
                }

                modelMap.addAttribute("monthwiseSale", monthwiseSale);

                modelMap.addAttribute("yearWiseSale", yearwiseSale);

            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return "dashboard";
    }

    /*public String fetchPackageDiscount(String quotationID) {

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
    }*/

    public List<Order> fetchCompanyOrders(String level, String id, Boolean isSalesEmployeeLoggedIn) {

        List<Order> orderlist = new ArrayList<>();

        try {

            if (level.equalsIgnoreCase("0")) {

                orderlist = orderRepository.findAllByStatus("Completed");

            } else {

                if (isSalesEmployeeLoggedIn) {

                    orderlist.addAll(orderRepository.findAllBySalesEmpIDAndStatus(id, "Completed"));

                } else {

                    orderlist.addAll(orderRepository.findAllByCompanyIDAndStatus(id, "Completed"));

                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }
        return orderlist;
    }

    /**
     * --------------------------------------- Date wise Data -------------------------------------------------
     **/

    @RequestMapping("/findDataBetweenDates/{dashboardType}/{salesPartnerID}")
    public void findDataBetweenDates(HttpServletRequest request, HttpServletResponse response, @RequestParam MultiValueMap<String, String> parameters, @PathVariable String dashboardType, @PathVariable String salesPartnerID) {

        List<Order> ordersList;

        int orderListSize = 0;

        String percentage;

        SalesPartner salesPartner = null;

        try {

            if (dashboardType.equalsIgnoreCase("dashboard") && salesPartnerID.equalsIgnoreCase("null")) {

                salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            } else if (dashboardType.equalsIgnoreCase("salesPartnerDashboard") && !salesPartnerID.equalsIgnoreCase("null")) {

                salesPartner = salesPartnerRepository.findById(salesPartnerID);
            }

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            LocalDate firstDate = LocalDate.parse(parameters.get("firstDate").get(0), formatter);

            LocalDate secondDate = LocalDate.parse(parameters.get("secondDate").get(0), formatter);

            if (salesPartner.getLevel().equalsIgnoreCase("0") && salesPartnerID.equalsIgnoreCase("null")) {

                percentage = salesPartner.getPercentage();

                ordersList = orderRepository.findAllByOrderDateBetweenAndStatus(firstDate.minusDays(1).toString(), secondDate.plusDays(1).toString(), "Completed");

            } else if (!salesPartner.getLevel().equalsIgnoreCase("0") && salesPartnerID.equalsIgnoreCase("null")) {

                ordersList = orderRepository.findAllByOrderDateBetweenAndStatusAndCompanyID(firstDate.minusDays(1).toString(), secondDate.plusDays(1).toString(), "Completed", salesPartner.getId());

                percentage = salesPartner.getPercentage();

            } else {

                percentage = salesPartner.getPercentage();

                ordersList = orderRepository.findAllByOrderDateBetweenAndStatusAndCompanyID(firstDate.minusDays(1).toString(), secondDate.plusDays(1).toString(), "Completed", salesPartnerID);

            }

            orderListSize = generatePdf(firstDate, secondDate, ordersList, percentage, salesPartner.getLevel());

            if (orderListSize > 0) {

                String fileName = "Test.pdf";
                String path = "/C:/New/" + fileName;

                File file = new File(path);
                FileInputStream inputStream = new FileInputStream(file);

                response.setContentType("application/pdf");
                response.setContentLength((int) file.length());
                response.setHeader("Content-Disposition", "inline;filename=\"" + fileName + "\"");

                FileCopyUtils.copy(inputStream, response.getOutputStream());
            }

        } catch (Exception e) {

            e.printStackTrace();
        }
    }

    public int generatePdf(LocalDate from, LocalDate to, List<Order> orders, String percentage, String salesPartnerLevel) {

        List<Order> orderlist = new ArrayList<>();

        File file1 = new File("C://New//Test.pdf");

        String file = "C:/New/Test.pdf";

        int orderListSize = 0;

        int finalBaseTotal = 0;

        double finalTotal = 0;

        double finalCGST = 0;

        double finalSGST = 0;

        try {

            DateTimeFormatter formatters = DateTimeFormatter.ofPattern("dd/MM/YYYY");
            String FirstDate = from.format(formatters);
            String SecondDate = to.format(formatters);

            orderlist.addAll(orders);

            orderListSize = orderlist.size();

            PdfDocument pdfDoc = new PdfDocument(new PdfWriter(file));

            // Creating a Document object
            Document doc = new Document(pdfDoc);

            Cell title = new Cell();
            title.add(new Paragraph("Completed Orders Data From " + FirstDate + " to " + SecondDate));

            doc.add(title);
            // Creating a table
            float[] pointColumnWidths = {120F, 120F, 120F, 120F, 120F};
            Table table = new Table(pointColumnWidths);

            Cell a1 = new Cell();
            a1.add(new Paragraph("Client Name"));
            a1.setTextAlignment(TextAlignment.CENTER);
            a1.setBold();
            table.addCell(a1);

            Cell a2 = new Cell();
            a2.add(new Paragraph("Base Price"));
            a2.setTextAlignment(TextAlignment.CENTER);
            a2.setBold();
            table.addCell(a2);

            Cell a3 = new Cell();
            a3.add(new Paragraph("CGST"));
            a3.setTextAlignment(TextAlignment.CENTER);
            a3.setBold();
            table.addCell(a3);

            Cell a4 = new Cell();
            a4.add(new Paragraph("SGST"));
            a4.setTextAlignment(TextAlignment.CENTER);
            a4.setBold();
            table.addCell(a4);

            Cell a5 = new Cell();
            a5.add(new Paragraph("Total"));
            a5.setTextAlignment(TextAlignment.CENTER);
            a5.setBold();
            table.addCell(a5);

            for (int i = 0; i < orderlist.size(); i++) {

                Cell c1 = new Cell();
                c1.add(new Paragraph(orderlist.get(i).getClientName()));
                c1.setTextAlignment(TextAlignment.CENTER);
                table.addCell(c1);

                String finalPrice = getCompleteOrderTotal(orderlist.get(i).getQuotationId(), percentage, salesPartnerLevel);
                finalBaseTotal = finalBaseTotal + Integer.parseInt(finalPrice);
                Cell c2 = new Cell();
                c2.add(new Paragraph(finalPrice));
                c2.setTextAlignment(TextAlignment.CENTER);
                table.addCell(c2);

                double calculateCGST = Integer.parseInt(finalPrice) * (0.09);
                finalCGST = finalCGST + calculateCGST;
                Cell c3 = new Cell();
                c3.add(new Paragraph(String.valueOf(calculateCGST)));
                c3.setTextAlignment(TextAlignment.CENTER);
                table.addCell(c3);

                double calculateSGST = Integer.parseInt(finalPrice) * (0.09);
                finalSGST = finalSGST + calculateSGST;
                Cell c4 = new Cell();
                c4.add(new Paragraph(String.valueOf(calculateSGST)));
                c4.setTextAlignment(TextAlignment.CENTER);
                table.addCell(c4);

                double total = Integer.parseInt(finalPrice) + calculateCGST + calculateSGST;
                finalTotal = finalTotal + total;
                Cell c5 = new Cell();
                c5.add(new Paragraph(String.valueOf(total)));
                c5.setTextAlignment(TextAlignment.CENTER);
                table.addCell(c5);

                if (i == (orderlist.size() - 1)) {

                    Cell finalc1 = new Cell();
                    finalc1.add(new Paragraph("Total"));
                    finalc1.setTextAlignment(TextAlignment.CENTER);
                    finalc1.setBold();
                    table.addCell(finalc1);

                    Cell finalc2 = new Cell();
                    finalc2.add(new Paragraph(String.valueOf(finalBaseTotal)));
                    finalc2.setTextAlignment(TextAlignment.CENTER);
                    table.addCell(finalc2);

                    Cell finalc3 = new Cell();
                    finalc3.add(new Paragraph(String.valueOf(finalCGST)));
                    finalc3.setTextAlignment(TextAlignment.CENTER);
                    table.addCell(finalc3);

                    Cell finalc4 = new Cell();
                    finalc4.add(new Paragraph(String.valueOf(finalSGST)));
                    finalc4.setTextAlignment(TextAlignment.CENTER);
                    table.addCell(finalc4);

                    Cell finalc5 = new Cell();
                    finalc5.add(new Paragraph(String.valueOf(finalTotal)));
                    finalc5.setTextAlignment(TextAlignment.CENTER);
                    table.addCell(finalc5);
                }
            }

            // Adding Table to document
            doc.add(table);

            // Closing the document
            doc.close();
//            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orderListSize;
    }

    public String getCompleteOrderTotal(String quotationId, String percentage, String salesPartnerLevel) {

        List<QuotationBOM> bomList;

        int finalprice = 0;

        String packageDiscount = "";

        int quotationDiscount = 0;

        try {

            bomList = quotationBOMRepository.findAllByQuotationID(quotationId);

            if (!salesPartnerLevel.equalsIgnoreCase("0")) {

                Quotation quotation = quotationRepository.findById(quotationId);

                quotationDiscount = Integer.parseInt(quotation.getExtraDiscount());

            }

            ListIterator iterator = bomList.listIterator();

            while (iterator.hasNext()) {

                QuotationBOM bom = (QuotationBOM) iterator.next();

                finalprice = finalprice + Integer.parseInt(bom.getQuantity()) * Integer.parseInt(bom.getPrice());

                if (packageDiscount.equalsIgnoreCase("")) {

                    packageDiscount = methodsCalledService.fetchPackageDiscount(bom.getQuotationID());

                }
            }

            finalprice = finalprice - finalprice * (quotationDiscount + Integer.parseInt(packageDiscount)) / 100;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return Integer.toString(finalprice);
    }

    /**
     * ------------------------------------ Adding Photo -----------------------------------
     **/

    @RequestMapping("/addPhoto")
    public String addPhoto() {

        return "addPhoto";
    }

    @PostMapping("/addPhotoForm")
    public String addPhoto(@RequestParam("title") String title,
                           @RequestParam("image") MultipartFile image)
            throws IOException {

        String id = ObjectId.get().toString();

        Photo photo = new Photo();

        photo.setId(id);

        photo.setTitle(title);

        photo.setImage(new Binary(BsonBinarySubType.BINARY, image.getBytes()));

        BufferedImage resized = resize((BufferedImage) image, 300, 300);

        photoRepository.save(photo);

        return "redirect:/dashboard";
    }

    public Photo getPhoto(String id) {
        return photoRepository.findById(id).get();
    }

    @ResponseBody
    @RequestMapping(value = "/getChildPartnerData")
    public String getChildPartnerData(@RequestParam String data) {

        int selfCnt = 0;

        int clientsCnt = 0;

        int bookedCnt = 0;

        String month[] = {"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"};

        String companyName = data.split("=")[1];

        String type = data.split("=")[0];

        LinkedHashMap<String, JSONObject> hashMap = new LinkedHashMap<>();

        LinkedHashMap<String, Integer> map = new LinkedHashMap<>();

        LinkedHashMap<String, JSONObject> linkedHashMap = new LinkedHashMap<>();

        try {

            SalesPartner salesPartner = salesPartnerRepository.findByName(companyName);

            List<Client> clientList = clientRepository.findAllByCompanyID(salesPartner.getId());

            List<Leads> leadsList = leadsRepository.findAllByLeadByAndCategory(salesPartner.getId(), "Self");

            leadsList.addAll(leadsRepository.findAllByCategoryAndCaptureBy("Digital", salesPartner.getName()));

            String yearCheck = new SimpleDateFormat("yyyy#MM#dd#HH#mm#ss").format(new Date()).split("#")[0];

            if (type.equalsIgnoreCase("Month")) {

                for (String m : month) {

                    for (Client client : clientList) {

                        if (client.getInstallation().split("-")[1].equalsIgnoreCase(m) && client.getInstallation().split("-")[0].equalsIgnoreCase(yearCheck)) {

                            clientsCnt++;
                        }
                    }

                    for (Leads leads : leadsList) {

                        if (leads.getRegistration().split("-")[1].equalsIgnoreCase(m) && leads.getCategory().equalsIgnoreCase("Self") && leads.getRegistration().split("-")[0].equalsIgnoreCase(yearCheck)) {

                            selfCnt++;

                        } else if (leads.getRegistration().split("-")[1].equalsIgnoreCase(m) && leads.getCategory().equalsIgnoreCase("Digital") && leads.getRegistration().split("-")[0].equalsIgnoreCase(yearCheck)) {

                            bookedCnt++;

                        }
                    }

                    JSONObject jsonObject = new JSONObject();

                    if (selfCnt != 0 || bookedCnt != 0 || clientsCnt != 0) {

                        jsonObject.put("self", selfCnt);

                        jsonObject.put("booked", bookedCnt);

                        jsonObject.put("client", clientsCnt);

                        Month monthName = Month.of(Integer.parseInt(m));

                        hashMap.put(monthName.toString(), jsonObject);
                    }

                    selfCnt = 0;

                    bookedCnt = 0;

                    clientsCnt = 0;

                }

            } else if (type.equalsIgnoreCase("Year")) {

                for (Client client : clientList) {

                    if (map.containsKey("client-" + client.getInstallation().split("-")[0])) {

                        map.computeIfPresent("client-" + client.getInstallation().split("-")[0], (k, v) -> v + 1);

                    } else {

                        map.put("client-" + client.getInstallation().split("-")[0], 1);
                    }
                }

                for (Leads leads : leadsList) {

                    if (leads.getCategory().equalsIgnoreCase("Self")) {

                        if (map.containsKey("self-" + leads.getRegistration().split("-")[0])) {

                            map.computeIfPresent("self-" + leads.getRegistration().split("-")[0], (k, v) -> v + 1);

                        } else {

                            map.put("self-" + leads.getRegistration().split("-")[0], 1);
                        }

                    } else if (leads.getCategory().equalsIgnoreCase("Digital")) {

                        if (map.containsKey("booked-" + leads.getRegistration().split("-")[0])) {

                            map.computeIfPresent("booked-" + leads.getRegistration().split("-")[0], (k, v) -> v + 1);

                        } else {

                            map.put("booked-" + leads.getRegistration().split("-")[0], 1);
                        }
                    }
                }
                JSONObject jsonObject = new JSONObject();

                for (Map.Entry<String, Integer> entry : map.entrySet()) {

                    jsonObject.put(entry.getKey().split("-")[0], entry.getValue());

                    linkedHashMap.put(entry.getKey().split("-")[1], jsonObject);

                }

                System.out.println("linkedHashMap >> " + linkedHashMap);

            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        if (type.equalsIgnoreCase("Month")) {

            return new Gson().toJson(hashMap);
        } else {

            return new Gson().toJson(linkedHashMap);
        }
    }

    public List<String> getNamesOnly() {

        return salesPartnerRepository.findAllByLevelGreaterThan("0")
                .stream()
                .map(SalesPartner::getName)
                .collect(Collectors.toList());
    }

}
