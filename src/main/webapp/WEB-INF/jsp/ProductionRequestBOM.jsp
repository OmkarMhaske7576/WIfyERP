<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<html lang='en'>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"
            integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI=" crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
            crossorigin="anonymous"></script>


    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.4/css/jquery.dataTables.min.css">
    <script src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js" defer></script>

    <link rel="stylesheet" href="/js/plugins/colorpicker/bootstrap-colorpicker-plus.min.css">
    <link rel="stylesheet" href="/js/plugins/scrollbar/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="/js/plugins/intro-tour/introjs.min.css">
    <link rel="stylesheet" href="/js/plugins/intro-tour/themes/introjs-modern.css">
    <link rel="stylesheet" href="/js/plugins/datepicker/datepicker.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>

    <link rel="stylesheet" type="text/css" href="/css/dripicon.css"/>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <link rel="stylesheet" type="text/css" href="/css/responsive.css"/>

    <style>

        table, th, tr {
            width: 100px;
            text-align: center;
        }

        #display_name {
            cursor: pointer;
        }
    </style>

</head>
<body class="theme-body" style="overflow-x: auto">

<c:if test="${values.equals('inventory')}">
    <h3 id="display_name">
        <span>Inventory > </span>
        <span onclick="window.location='/inventoryProductionlist/${values}'">Production Request</span>
        <span onclick="window.location='/productionrequestBOM/${productCode}/${quantity}/${productname}/${values}/${requestStatus}'" > > ${productname}</span>
    </h3><br>
</c:if>

<c:if test="${values.equals('warehouse')}">
    <h3 id="display_name">
        <span>Warehouse > </span>
        <span onclick="window.location='/inventoryProductionlist/${values}'">Production Request</span>
        <span onclick="window.location='/productionrequestBOM/${productCode}/${quantity}/${productname}/${values}/${requestStatus}'" > > ${productname}</span>
    </h3><br>
</c:if>

<table id="example" class="table table-striped" style="width:100%" class="myTableClass">
    <thead>
    <tr>
        <th>Item Code</th>
        <th>Item Name</th>
        <th>Quantity per product</th>
        <th>Total quantity</th>
        <c:if test="${requestStatus.equals('New')}">
            <th>Status</th>
        </c:if>

    </tr>
    </thead>
    <tbody class="layui-table">

    <c:forEach var="Bomlist" items="${BomRequest}">

        <tr>
            <td>${Bomlist.code}</td>
            <td>${Bomlist.name}</td>
            <td>${Bomlist.quantity}</td>
            <td> ${Bomlist.quantity * quantity}</td>
            <c:if test="${requestStatus.equals('New')}">
                <c:forEach var="map" items="${map}">

                    <c:if test="${map.key == Bomlist.code}">

                        <td>${map.value}</td>

                    </c:if>

                </c:forEach>
            </c:if>
        </tr>

    </c:forEach>

    </tbody>
</table>

<script>
    $(document).ready(function () {

        $('#example').dataTable({
            "aLengthMenu": [25, 50, 75, 100],
            "pageLength": 100
        });

        /* var count=0;
         var noofrows=0;
         $("table > tbody > tr").each(function () {

             if($(this).find('td').eq(4).text()=="Stock is available"){
                 count++;
             }
             noofrows++;

         });*/
    });

</script>

</body>
</html>
