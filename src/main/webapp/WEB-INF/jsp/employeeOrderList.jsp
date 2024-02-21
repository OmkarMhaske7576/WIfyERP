<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang='en'>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <%--    <script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"--%>
    <%--            integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI=" crossorigin="anonymous"></script>--%>

    <%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"--%>
    <%--            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"--%>
    <%--            crossorigin="anonymous"></script>--%>

    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.4/css/jquery.dataTables.min.css">
    <script src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js" defer></script>

    <%--    <link rel="stylesheet" href="/js/plugins/colorpicker/bootstrap-colorpicker-plus.min.css">--%>
    <link rel="stylesheet" href="/js/plugins/scrollbar/jquery.mCustomScrollbar.min.css">
    <%--    <link rel="stylesheet" href="/js/plugins/intro-tour/introjs.min.css">--%>
    <%--    <link rel="stylesheet" href="/js/plugins/intro-tour/themes/introjs-modern.css">--%>
    <link rel="stylesheet" href="/js/plugins/datepicker/datepicker.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <%--    <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>--%>

    <%--    <link rel="stylesheet" type="text/css" href="/css/dripicon.css"/>--%>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <%--    <link rel="stylesheet" type="text/css" href="/css/responsive.css"/>--%>


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

<c:if test="${isEmployeeLoggedIn.equals('true')}">
    <h3>
        <span id="display_name" onclick="window.location='/employeeOrdersList'">Orders</span>
    </h3><br>
</c:if>

<c:if test="${isEmployeeLoggedIn.equals('false')}">
    <h3 id="display_name">
        <span>Employee > </span>
        <span onclick="window.location='/employeelist'">Employee List</span>
        <span onclick="window.location='/viewEmployeeOrdersList/${employeeID}'"> > ${employeeName}</span>
    </h3><br>
</c:if>

<table id="example" class="table table-striped">
    <thead>
    <tr>
        <th>Client</th>
        <th>Status</th>
        <th>Pay Status</th>
        <th
                <c:if test="${isEmployeeLoggedIn.equals('false')}">hidden</c:if>  >Action
        </th>
        <th
                <c:if test="${isEmployeeLoggedIn.equals('false')}">hidden</c:if> >Transactions
        </th>
    </tr>
    </thead>
    <tbody>

    <c:forEach var="employeeOrderObj" items="${employeeOrderList}">
        <tr>
            <td>${employeeOrderObj.clientName}</td>
            <td>${employeeOrderObj.status}</td>
            <td>${employeeOrderObj.payStatus}</td>
            <td
                    <c:if test="${isEmployeeLoggedIn.equals('false')}">hidden</c:if> >
                <button type="button" class="btn btn-success btn-sm ml-2"
                        onclick="window.location='/addOrder/${"edit"}/${employeeOrderObj.id}/${employeeOrderObj.quotationId}/${"order"}'">
                    Edit
                </button>
            </td>
            <td <c:if test="${isEmployeeLoggedIn.equals('false')}">hidden</c:if> >
                <button type="button5" class="btn btn-success btn-sm"
                        onclick="window.location='/transactionsList/${employeeOrderObj.quotationId}'">Transaction List
                </button>
            </td>
        </tr>
    </c:forEach>

    </tbody>

</table>


<script>$(document).ready(function () {

    $('#example').dataTable({

        "pageLength": 100
    });

});
</script>

</body>
</html>