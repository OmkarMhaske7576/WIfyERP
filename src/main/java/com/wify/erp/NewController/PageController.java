package com.wify.erp.NewController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServlet;
import java.text.ParseException;

import com.itextpdf.layout.element.*;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import java.io.FileNotFoundException;

@Controller
public class PageController extends HttpServlet {

   /* @RequestMapping("home")
    public String homePage(ModelMap model) {

        return "/home";
    }*/

   /* @RequestMapping("/")
    public String home(ModelMap model) {

        int count = FirebaseUtility.orderlist.size();

        int cal = count - OrderController.orderCountAlert;

        model.addAttribute("Cal",cal);

        model.addAttribute("updatedCount", count);

        model.addAttribute("oldCount",OrderController.orderCountAlert);

        model.addAttribute("updatedClientCount", FirebaseUtility.clients.size());

        model.addAttribute("oldClientCount",ClientController.clientCountAlert);

        return "/home";

    }*/

    /*@ResponseBody
    @RequestMapping(value = "/getUpdateOrderCount")
    public static int getUpdateOrderCount() throws ParseException {

        *//*String date = null;

        for (Map.Entry<String, ArrayList<Object>> entry : FirebaseUtility.flagCount.entrySet()) {

            if (entry.getKey().equals("order")) {

                date = entry.getValue().get(0).toString();
            }
        }

        System.out.println(" >>>>>>>>>>>>>>>>>>>>>>>>>>>> " + date);

        for (Map.Entry<String, Order> entry : FirebaseUtility.orderlist.entrySet()){

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            Date date1 = sdf.parse(entry.getValue().getOrder_date());

            System.out.println("The date 1 is -------------------------> " + sdf.format(date1));

            Date date2 = sdf.parse(date);

//            System.out.println("The date 2 is : " + sdf.format(date2));

            if(date1.compareTo(date2) > 0) {
                System.out.println("Date 1 occurs after Date 2");
            } else if(date1.compareTo(date2) < 0) {
                System.out.println("Date 1 occurs before Date 2");
            } else if(date1.compareTo(date2) == 0) {
                System.out.println("Both dates are equal");
            }

        }*//*

        int updatedCount = FirebaseUtility.orderlist.size();

        int oldCount = OrderController.orderCountAlert;

        int newOrderCount = updatedCount - oldCount;

        return newOrderCount;
    }*/

    @ResponseBody
    @RequestMapping(value = "/getClientCount")
    public static int getClientCount() throws ParseException {

       /* String date = null;

        for (Map.Entry<String, ArrayList<Object>> entry : FirebaseUtility.flagCount.entrySet()) {

            if (entry.getKey().equals("client")) {

                date = entry.getValue().get(2).toString();
            }
        }

        for (Map.Entry<String, Client> entry : FirebaseUtility.clients.entrySet()){

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            Date date1 = sdf.parse(entry.getValue().getInstallation_date());

            System.out.println("The date 1 is -------------------------> " + sdf.format(date1));

                Date date2 = sdf.parse(date);

                System.out.println("The date 2 is : " + sdf.format(date2));

                System.out.println(" >>>>>>>>>>>>>>>>>>>>>>>>>>>> " + date1.compareTo(date2));

                if(date1.compareTo(date2) > 0) {
                    System.out.println("Date 1 occurs after Date 2");
                } else if(date1.compareTo(date2) < 0) {
                    System.out.println("Date 1 occurs before Date 2");
                } else if(date1.compareTo(date2) == 0) {
                    System.out.println("Both dates are equal");
                }

        }

        System.out.println(" Updated Date : ------ > "+ date);*/

        int updatedClientCount = 0;

//        int oldClientCount = ClientController.clientCountAlert;

//        int newClientCount = updatedClientCount - oldClientCount;

//        return newClientCount;

        return 0;
    }
/*
    @ResponseBody
    @RequestMapping(value = "/setDateInGlobal")
    public void setDateInGlobal(@RequestParam String name) throws ParseException {

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        Date date = new Date();

        System.out.println(" -- > Current Date" + dateFormat.format(date));

        LeadsUtility leads = new LeadsUtility();

        leads.addDateInGlobal(name,dateFormat.format(date));

        System.out.println(" Name: ---> "+ name);

    }*/

    /*public static String generatePdf() throws FileNotFoundException {


        String file = "E:/server/addingObjects.pdf";
        PdfDocument pdfDoc = new PdfDocument(new PdfWriter(file));

        // Creating a Document object
        Document doc = new Document(pdfDoc);

        // Creating a table
        float [] pointColumnWidths = {300F, 300F};
        Table table = new Table(pointColumnWidths);

        // Adding row 1 to the table
        Cell c1 = new Cell();
        c1.add(new Paragraph("Java Related Tutorials"));
        c1.setTextAlignment(TextAlignment.LEFT);
        table.addCell(c1);

        List list1 = new List();
        ListItem item1 = new ListItem("JavaFX");
        ListItem item2 = new ListItem("Java");
        ListItem item3 = new ListItem("Java Servlets");
        list1.add(item1);
        list1.add(item2);
        list1.add(item3);

        Cell c2 = new Cell();
        c2.add(list1);
        c2.setTextAlignment(TextAlignment.LEFT);
        table.addCell(c2);

        // Adding row 2 to the table
        Cell c3 = new Cell();
        c3.add(new Paragraph("No SQL Databases"));
        c3.setTextAlignment(TextAlignment.LEFT);
        table.addCell(c3);

        List list2 = new List();
        list2.add(new ListItem("HBase"));
        list2.add(new ListItem("Neo4j"));
        list2.add(new ListItem("MongoDB"));

        Cell c4 = new Cell();
        c4.add(list2);
        c4.setTextAlignment(TextAlignment.LEFT);
        table.addCell(c4);

        // Adding Table to document
        doc.add(table);

        // Closing the document
        doc.close();
        System.out.println("Lists added to table successfully..");

        return "success";
    }*/


}