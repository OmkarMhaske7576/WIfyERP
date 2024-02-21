<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <script>
        var total = 0;

    </script>

</head>
<body class="theme-body" style="overflow-x: auto">

<c:if test="${value.equals('order')}">
    <h3 id="display_name">
        <span>Orders > </span>
        <span onclick="window.location='/orderlist'">Order List</span>
        <span> > ${clientName}</span>
    </h3><br>
</c:if>

<c:if test="${value.equals('warehouse')}">
    <h3 id="display_name">
        <span>Warehouse > </span>
        <span onclick="window.location='/warehouseorders'"> Received Orders</span>
        <span> > ${clientName}</span>
    </h3><br>
</c:if>

<c:if test="${value.equals('company') && level =='0'}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/companyWiseOrderList'">Company wise OrderLst</span>
        <span> > ${clientName}</span>
    </h3><br>
</c:if>

<c:if test="${value.equals('company') && level > '0' && isSalesEmployeeLoggedIn.equals('false')}">
    <h3 id="display_name">
            <%--        <span>Client > </span>--%>
        <span onclick="window.location='/companyOrdersList'">Company Orders</span>
        <span> > ${clientName}</span>
    </h3><br>
</c:if>

<c:if test="${value.equals('company') && level > '0' && isSalesEmployeeLoggedIn.equals('true')}">
    <h3 id="display_name">
            <%--        <span>Client > </span>--%>
        <span onclick="window.location='/companyOrdersList'">Orders</span>
        <span> > ${clientName}</span>
    </h3><br>
</c:if>

<c:if test="${value.equals('salesEmployee') && level =='0'}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/salesEmployeeList'">Sales EmployeeList</span>
        <span onclick="window.location='/viewSalesEmployeeData/${employeeID}'"> > ${employeeName} (Emp) </span>
        <span> > ${clientName} (Order)</span>
    </h3><br>
</c:if>

<c:if test="${value.equals('salesEmployee') && level > '0'}">
    <h3 id="display_name">
        <span onclick="window.location='/salesEmployeeList'">Sales EmployeeList</span>
        <span onclick="window.location='/viewSalesEmployeeData/${employeeID}'"> > ${employeeName} (Emp) </span>
        <span> > ${clientName} (Order)</span>
    </h3><br>
</c:if>

<table id="example" class="table table-striped" style="width:100%">
    <thead>
    <tr>
        <th>Product code</th>
        <th>Product name</th>
        <th>Quantity</th>
        <c:if test="${status.equals('New') && value != ('company')}">
            <th>
                    <%--                <c:if test="${status.equals('Ready to install') || status.equals('Completed') || status.equals('Cancelled') || status.equals('Shipped')}">hidden</c:if> >--%>
                Available Status
            </th>
        </c:if>

    </tr>
    </thead>
    <tbody>

    <c:forEach var="orderbom" items="${orderbom}">
        <tr>
            <td>${orderbom.pcode}</td>
            <td <c:if test="${orderbom.pname.contains('Controller')}"> style="cursor: pointer" onclick="showModelBox1('${orderbom.id}')" </c:if> >${orderbom.pname}</td>
            <td>
                <c:choose>
                    <c:when test="${orderQuantity == 1}">
                        ${orderbom.quantity * orderQuantity}
                    </c:when>
                    <c:otherwise>
                        ${orderbom.quantity} * ${orderQuantity} = ${orderbom.quantity * orderQuantity}
                    </c:otherwise>
                </c:choose>

            </td>
            <c:if test="${status.equals('New') && value != ('company')}">

                <c:forEach var="hashmapObj" items="${hashmap}">

                    <c:if test="${hashmapObj.key == orderbom.pcode}">

                        <td> ${hashmapObj.value}</td>

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

});

function showModelBox1(id){

    $.get("/getControllerData?id=" + id, function (data) {

        if (data.hasOwnProperty("generic")){

            alert("Generic Count = " + data.generic + ", Power Count = "+ data.power);
        }

    });

}
</script>

</body>
</html>