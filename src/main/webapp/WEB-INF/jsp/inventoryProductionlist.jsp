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

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css"
          integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>


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

<c:if test="${value.equals('inventory')}">
    <h3 id="display_name">
        <span>Inventory > </span>
        <span onclick="window.location='/inventoryProductionlist/${value}'">Production Request</span>
    </h3><br>
</c:if>

<c:if test="${value.equals('warehouse')}">
    <h3 id="display_name">
        <span>Warehouse > </span>
        <span onclick="window.location='/inventoryProductionlist/${value}'">Production Request</span>
    </h3><br>
</c:if>

<button type="button" <%--<c:if test="${value.equals('inventory')}">hidden</c:if>--%> class="btn btn-success btn-sm"
        onclick="window.location='/addInventoryProduction/${"add"}/${"null"}/${"Product"}/${value}'">Add Production Request
</button>
<br><br>


<table id="example" class="table table-striped" style="width:100%">
    <thead>
    <tr>
        <th>Request No</th>
        <th>Product Name</th>
        <th>Quantity</th>
        <th>Status</th>
        <th>Request Date</th>
        <th>Products</th>
        <c:if test="${value.equals('inventory')}">
            <th>Action</th>
        </c:if>
    </tr>
    </thead>
    <tbody>

    <c:forEach var="iproductionobj" items="${iproduction}">
        <tr>
            <td>${iproductionobj.request}</td>
            <td>${iproductionobj.name}</td>
            <td>${iproductionobj.quantity}</td>

            <c:choose>
                <c:when test="${iproductionobj.status != 'New'}">
                    <td>${iproductionobj.status}</td>
                </c:when>
                <c:otherwise>
                    <c:forEach var="map" items="${map}">

                        <c:if test="${map.key == iproductionobj.code}">

                            <td>${map.value}</td>

                        </c:if>

                    </c:forEach>
                </c:otherwise>
            </c:choose>

            <td>
                    ${iproductionobj.date}</td>
            <td>

                <button type="button" id="btn3" class="btn btn-warning btn-sm"
                        onclick="window.location='/productionrequestBOM/${iproductionobj.code}/${iproductionobj.quantity}/${iproductionobj.name}/${value}/${iproductionobj.status}'">
                    Products
                </button>
            </td>

            <c:if test="${value.equals('inventory')}">
                <td>

                    <button type="button" id="btn2" class="btn btn-success btn-sm ml-2"
                            onclick="window.location='/addInventoryProduction/${"edit"}/${iproductionobj.id}/${iproductionobj.category}/${value}'"
                            data-toggle="tooltip" title=" Edit Production Request"><i
                            class="fa-solid fa-pen-to-square"></i></button>

                    <button type="button" id="btn1" class="btn btn-danger btn-sm"
                            onclick="delFunction('${iproductionobj.id}','${iproductionobj.name}','${iproductionobj.category}','${value}')"
                            data-toggle="tooltip" title="Delete Production Request"><i class="fa-solid fa-trash"></i>
                    </button>
                </td>
            </c:if>
        </tr>
    </c:forEach>

    </tbody>

</table>


<script>

    function delFunction(deletekey, item_name,category , typeValue) {

        if (confirm("Delete Production request of " + item_name + " ??") == true) {

            window.location.href = "/deleteInventoryProduction" + "/" + deletekey + "/" + category + "/" + typeValue;
        } else {
        }
    }

    $(document).ready(function () {

        $('#example').dataTable({
            "aLengthMenu": [25, 50, 75, 100],
            "pageLength": 100
        });

    });

</script>

</body>
</html>
