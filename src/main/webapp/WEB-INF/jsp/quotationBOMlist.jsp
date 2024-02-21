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

<c:if test="${clientType.equals('lead') && level == '0'}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/leads'">Leads</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${orderid}/${quotationID}'"> > Quotation No: ${orderid}</span>
    </h3>
</c:if>

<c:if test="${clientType.equals('lead') && level > '0'}">
    <h3 id="display_name">
        <span onclick="window.location='/leads'">Leads</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${orderid}/${quotationID}'"> > Quotation No: ${orderid}</span>
    </h3>
</c:if>

<c:if test="${clientType.equals('client') && level == '0'}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/clientList'">Client List</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${orderid}/${quotationID}'"> > Quotation No: ${orderid} </span>
    </h3>
</c:if>

<c:if test="${clientType.equals('client') && level > '0'}">
    <h3 id="display_name">
        <span onclick="window.location='/clientList'">Client List</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${orderid}/${quotationID}'"> > Quotation No: ${orderid}</span>
    </h3>
</c:if>

<br>

<%--<button type="button" class="btn btn-primary"
        <c:if test="${quotationAddedCheck.equals(true)}">disabled</c:if>
        onclick="window.location='/installationModulesSelection/${quotationID}'"
        data-bs-toggle="modal" data-bs-target="#exampleModal">Add Boards
</button>--%>

<button type="button" class="btn btn-primary"
        <c:if test="${quotationAddedCheck.equals(true)}">disabled</c:if>
        onclick="window.location='/addQuotationBOM/${"add"}/${"null"}/${"addPackage"}/${clientID}/${quotationID}'"
        data-bs-toggle="modal" data-bs-target="#exampleModal">Add Package
</button>

<button type="button" class="btn btn-primary"
        <c:if test="${quotationAddedCheck.equals(true)}">disabled</c:if>
        onclick="window.location='/addQuotationBOM/${"add"}/${"null"}/${"addProduct"}/${clientID}/${quotationID}'"
        data-bs-toggle="modal" data-bs-target="#exampleModal">Add Product
</button>

<button type="button" class="btn btn-primary"
        <c:if test="${quotationAddedCheck.equals(true)}">disabled</c:if>
        onclick="window.location='/viewBoardsData/${quotationID}'"
>Boards Data
</button>

<br><br>

<table id="example" class="table table-striped" style="width:100%">
    <thead>
    <tr>
        <th>Product name</th>
        <th>Quantity</th>
        <%--        <th>Package Discount</th>--%>
        <th>Discount</th>
        <th>Price per Product</th>
        <th>Total MRP</th>
        <th>Discount price</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach var="orderbom" items="${orderbom}">
        <tr>
            <td <c:if
                    test="${orderbom.pname.contains('Controller')}"> style="cursor: pointer" onclick="showModelBox('${orderbom.id}')" </c:if> >${orderbom.pname}<br>
                <p class="text-muted"><c:if test="${orderbom.packageName != ''}">(${orderbom.packageName})</c:if></p>
            </td>

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
                <%--            <td>${orderbom.discount}%</td>--%>
            <td>${packageDiscount} % + ${extraDiscount}%</td>
            <td>${orderbom.price}</td>
            <td>
                <fmt:formatNumber value="${orderbom.price * (orderbom.quantity * orderQuantity)}" minFractionDigits="0"
                                  maxFractionDigits="0"/>
            </td>
            <td>
                <c:if test="${orderbom.packageName == ''}">
                    <fmt:formatNumber
                            value="${orderbom.price * (orderbom.quantity * orderQuantity) - orderbom.price * (orderbom.quantity * orderQuantity) * (extraDiscount) / 100}"
                            minFractionDigits="0" maxFractionDigits="0"/>
                </c:if>
                <c:if test="${orderbom.packageName != ''}">
                    <script>
                        var applyPackageDiscount = ${orderbom.price * (orderbom.quantity * orderQuantity) - orderbom.price * (orderbom.quantity * orderQuantity) * (packageDiscount) / 100};
                        console.log("1 >> "+ applyPackageDiscount);
                        var applyExtraDiscount = applyPackageDiscount - applyPackageDiscount * ${extraDiscount} /100;

                        console.log("2 >> "+ applyExtraDiscount);
                        document.write((Math.round(applyExtraDiscount) ^ 0).toLocaleString());
                    </script>
<%--                    <fmt:formatNumber--%>
<%--                            value="${orderbom.price * (orderbom.quantity * orderQuantity) - orderbom.price * (orderbom.quantity * orderQuantity) * (packageDiscount + extraDiscount) / 100}"--%>
<%--                            minFractionDigits="0" maxFractionDigits="0"/>--%>
                </c:if>

                    <%-- <c:if test="${orderbom.discount != null && orderbom.extraDiscount != null }"> (${orderbom.discount}% + ${orderbom.extraDiscount}%)
                     </c:if>--%>

                    <%--<c:choose>
                    <c:when test="${extraDiscount == 0 && orderbom.discount == 0}">

                    </c:when>
                    <c:when test="${extraDiscount == 0}">
                        (${orderbom.discount}%)
                    </c:when>
                    <c:when test="${orderbom.discount != null && extraDiscount != null }">
                        (${orderbom.discount + extraDiscount}%)
                    </c:when>
                    <c:otherwise></c:otherwise>
                </c:choose>--%>
            </td>

            <script>
                <c:if test="${orderbom.packageName == ''}">

                total = total +${orderbom.price * (orderbom.quantity * orderQuantity)};

                </c:if>
                <%--total = total +${orderbom.price * (orderbom.quantity * orderQuantity) - orderbom.price * (orderbom.quantity * orderQuantity) * (packageDiscount + extraDiscount) / 100};--%>
            </script>

            <td>
                <button type="button" id="btn2"
                        <c:if test="${quotationAddedCheck.equals(true)}">disabled</c:if>
                    <%--                        <c:if test="${orderbom.packageName != ''}">disabled</c:if>--%>
                        <c:if test="${orderbom.pname.contains('Mini') || orderbom.pname.contains('Controller')}">disabled</c:if>
                        class="btn btn-success btn-sm ml-2"
                        onclick="window.location='/addQuotationBOM/${"edit"}/${orderbom.id}/${"editProduct"}/${clientID}/${quotationID}'">
                    Edit
                </button>

                <button type="button" id="btn1" class="btn btn-danger btn-sm"
                        <c:if test="${quotationAddedCheck.equals(true)}">disabled</c:if>
                    <%--                        <c:if test="${orderbom.packageName != ''}">disabled</c:if>--%>
                        <c:if test="${orderbom.pname.contains('Mini')}">disabled</c:if>
                        onclick="delFunction('${orderbom.id}','${orderid}','${orderbom.pname}','${quotationID}')">Delete
                </button>
            </td>
        </tr>
    </c:forEach>

    </tbody>

</table>

<h3>Total Amount :
    <script>
        total = total + ${finalAmountOfPackage};
        total = total - total * ${extraDiscount} / 100;
        document.write((total ^ 0).toLocaleString());

    </script>
    <span>&#8377;</span>
</h3>


<script>
    function delFunction(deletekey, quotationnumber, productName, quotationID) {

        if (confirm("Delete " + productName + " from Quotation No - " + quotationnumber + " ??") == true) {

            window.location.href = "/deleteQuotationBOM" + "/" + deletekey + "/" + quotationID;
        } else {
        }
    }

    function showModelBox(id) {

        $.get("/getControllerData?id=" + id, function (data) {

            if (data.hasOwnProperty("generic")) {

                alert("Generic Count = " + data.generic + ", Power Count = " + data.power);
            }

        });

    }

    $(document).ready(function () {

        $('#example').dataTable({
            "aLengthMenu": [25, 50, 75, 100],
            "pageLength": 100,
            // "order": [[0, 'desc']],
            "aoColumns": [
                {"sWidth": "20%"},
                {"sWidth": "10%"},
                {"sWidth": "10%"},
                {"sWidth": "13%"},
                {"sWidth": "13%"},
                {"sWidth": "14%"},
                {"sWidth": "20%"}
            ]
        });

    });

</script>

</body>
</html>
