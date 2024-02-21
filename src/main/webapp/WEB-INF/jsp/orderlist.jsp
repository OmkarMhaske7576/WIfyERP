<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

        #link:hover {
            font-weight: bold;
            color: blue;
            cursor: pointer;
        }

        #display_name {
            cursor: pointer;
        }

    </style>

</head>
<body class="theme-body" style="overflow-x: auto">

<h3 id="display_name">
    <span>Orders > </span>
    <span onclick="window.location='/orderlist'">Order List</span>
</h3><br>

<h2>Total Orders: ${orderlist.size()}</h2>
<br>

<%--<button type="button" class="btn btn-success btn-sm" onclick="window.location='/addorder/${"add"}/${"null"}'" >Add Order</button> --%>

<table id="example" class="table table-striped" style="width:100%">
    <thead>
    <tr>
        <%--        <th>Order ID</th>--%>
        <th>Client Name</th>
        <th>Status</th>
        <th>Order Date</th>
        <th>Edit</th>
        <th>BOM</th>
        <th>Order by</th>
        <th>Transactions</th>
        <th>Quotation</th>
        <th>Invoice</th>
    </tr>
    </thead>
    <tbody>


    <c:forEach var="orderObj" items="${orderlist}">
        <tr>
                <%--            <td>${orderObj.id}</td>--%>
            <td>${orderObj.clientName}</td>
            <td>${orderObj.status}</td>

            <td>${orderObj.orderDate}</td>

            <td>
                <button type="button" class="btn btn-success btn-sm ml-2"
                        onclick="window.location='/addOrder/${"edit"}/${orderObj.id}/${orderObj.quotationId}/${"order"}'">
                    Edit
                </button>
            </td>
            <td>
                <button type="button" class="btn btn-success btn-sm"
                        onclick="window.location='/orderBOM/${orderObj.quotationId}/${orderObj.id}/${"order"}'">Products
                </button>
            </td>
                <%-- <td>
                     <button type="button" id="btn5" class="btn btn-success btn-sm ml-2" onclick="window.location='/transactionsList/${orderObj.order_id}'">Transactions</button>
                 </td>--%>

            <c:forEach var="hashmapObj" items="${hashmap}">

                <c:if test="${hashmapObj.key == orderObj.companyID}">

                    <td> ${hashmapObj.value}</td>

                </c:if>

            </c:forEach>
                <%--            <td>--%>
                <%--                <button type="button" <c:if test="${orderObj.status != ('Completed')}">disabled</c:if> class="btn btn-success btn-sm ml-2" onclick="window.location='/generateProFormaInvoice/${orderObj.clientId}/${orderObj.quotationId}/${orderObj.id}'">Proforma Invoice</button>--%>
                <%--            </td>--%>
            <td>
                <button type="button5" class="btn btn-success btn-sm"
                        onclick="window.location='/transactionsList/${orderObj.quotationId}'">Transaction List
                </button>
            </td>

            <td>
                <button type="button"
                        class="btn btn-success btn-sm ml-2"
                        <%--onclick="window.location='/generateInvoice/${orderObj.clientId}/${orderObj.quotationId}/${orderObj.companyID}/${"self"}'"--%>>
                    Quotation
                </button>
            </td>

            <td>
                <button type="button"
                        <c:if test="${orderObj.status != ('Completed')}">disabled</c:if>
                        class="btn btn-success btn-sm ml-2"
                        onclick="window.location='/generateInvoice/${orderObj.clientId}/${orderObj.quotationId}/${orderObj.companyID}/${"self"}'">
                    Invoice
                </button>
            </td>
        </tr>
    </c:forEach>

    </tbody>

</table>


<script>

    // var a = $.fn.dataTable.absoluteOrder({
    //     value:'Cancelled', position:'top'
    // });

    $(document).ready(function () {

        $('#example').dataTable({
            "aLengthMenu": [25, 50, 75, 100],
            "pageLength": 100,

            "order": [[2, 'desc']],
            "aoColumns": [
                {"sWidth": "15%"},
                {"sWidth": "10%"},
                {"sWidth": "12%"},
                {"sWidth": "10%"},
                {"sWidth": "10%"},
                {"sWidth": "13%"},
                {"sWidth": "10%"},
                {"sWidth": "12%"},
                {"sWidth": "8%"}
            ]
        });

    });

</script>

</body>
</html>
