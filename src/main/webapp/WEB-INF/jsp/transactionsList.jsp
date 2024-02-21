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

        #display_name {
            cursor: pointer;
        }

    </style>

</head>

<script>
    var amountPaid = 0;

    var remaining = 0;
</script>
<body class="theme-body" style="overflow-x: auto">

<c:if test="${level == '0' && isEmployeeLoggedIn.equals('false')}">
    <h3 id="display_name">
        <span onclick="window.location='/orderlist'"> Orders > </span>
        <span onclick="window.location='/transactionsList/${quotationId}'">${clientName}</span>
    </h3><br>
</c:if>

<c:if test="${level == '0' && isEmployeeLoggedIn.equals('true')}">
    <h3 id="display_name">
        <span onclick="window.location='/employeeOrdersList'" >Orders > </span>
        <span onclick="window.location='/transactionsList/${quotationId}'">${clientName}</span>
    </h3><br>
</c:if>

<c:if test="${clientType.equals('lead') && level > '0'}">
    <h3 id="display_name">
        <span >Leads</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/transactionsList/${quotationId}'" > > Quotation No: ${quotationNo}</span>
    </h3>
</c:if>

<c:if test="${clientType.equals('client') && level > '0'}">
    <h3 id="display_name">
        <span onclick="window.location='/clientList'">Client List</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/transactionsList/${quotationId}'"> > Quotation No: ${quotationNo} </span>
    </h3>
</c:if>

<br>

<c:if test="${level > '0'}">
    <button type="button" class="btn btn-success btn-sm"
            onclick="window.location='/addTransaction/${"add"}/${"null"}/${quotationId}'">Add Transaction
    </button>
    <br><br>
</c:if>

<table id="example" class="table table-striped">
    <thead>
    <tr>
        <th>Payment type</th>
        <th>Payment Mode</th>
        <th>Amount</th>
        <th>Date</th>
        <th>Transaction ID</th>
        <th
                <c:if test="${level == '0'}">hidden</c:if> >Action
        </th>
        <th
                <c:if test="${level == '0'}">hidden</c:if> >Receipt
        </th>
    </tr>
    </thead>
    <tbody>

    <c:forEach var="item" items="${transactions}">
        <tr>

            <td>${item.payment_type}</td>
            <td>${item.payment_mode}</td>
            <td>${item.amount}</td>
            <td>${item.transaction_date}</td>
            <td>${item.transaction_id}</td>

            <td <c:if test="${level == '0'}">hidden</c:if> >
                <button type="button" class="btn btn-success btn-sm"
                        onclick="window.location='/addTransaction/${"edit"}/${item.id}/${quotationId}'">Edit Transaction
                </button>
            </td>
            <td <c:if test="${level == '0'}">hidden</c:if> >
                <button type="button" class="btn btn-success btn-sm"
                        onclick="window.location='/printReceipt/${item.id}'">Receipt
                </button>
            </td>
        </tr>
        <script>
            amountPaid = amountPaid + ${item.amount};
        </script>
    </c:forEach>

    </tbody>

    <script>
        remaining = ${TotalAmount} -amountPaid;
    </script>

</table>

<span>
        <h3>
            Total Amount : ${TotalAmount}
        </h3>
        <h3>
            Paid : <script>document.write(amountPaid.toLocaleString())</script>
        </h3>
        <h3>
            Remaining : <script>document.write(remaining.toLocaleString())</script>
        </h3>
    </span>

<script>$(document).ready(function () {

    $('#example').dataTable({

        "pageLength": 100
    });

});
</script>

</body>
</html>
