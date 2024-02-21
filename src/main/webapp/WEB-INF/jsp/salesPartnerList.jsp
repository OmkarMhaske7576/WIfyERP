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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css"
          integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

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

        body {
            overflow: -moz-scrollbars-none;
        }
    </style>

</head>
<body class="theme-body" style="overflow-x: auto">

<c:if test="${level == '0'}">
<h3 id="display_name">
    <span>Client > </span>
    <span onclick="window.location='/salesPartner'">Sales Partner List</span>
</h3><br>
</c:if>

<c:if test="${level > '0'}">
    <h3 id="display_name">
        <span onclick="window.location='/salesPartner'">Sales Partner List</span>
    </h3><br>
</c:if>

<button type="button" class="btn btn-success btn-sm"
        onclick="window.location='/addSalesPartner/${"add"}/${"null"}'">Add Sales Partner
</button>
<br><br>

<table id="example" class="table table-striped">
    <thead>
    <tr>
        <th>Name</th>
        <th>Address</th>
        <th>Mobile no</th>
        <th>Registration Date</th>
        <th>Action</th>
        <th>View</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach var="clientObj" items="${hashmap}">
        <tr>
            <td>${clientObj.name}</td>
            <td>${clientObj.address}</td>
            <td>${clientObj.mobile}</td>
            <td>${clientObj.date}</td>
            <td>
                <button type="button" id="btn1" class="btn btn-success btn-sm"
                   onclick="window.location='/addSalesPartner/${"edit"}/${clientObj.id}'">Edit
                </button>
            </td>
            <td>
                <button type="button" id="btn2" class="btn btn-success btn-sm"
                        onclick="window.location='/viewSalesPartnerData/${clientObj.id}'">View
                </button>
            </td>

            </c:forEach>

        </tr>

    </tbody>

</table>

<script>
    $(document).ready(function () {

        $('#example').dataTable({
            "aLengthMenu": [25, 50, 75, 100],
            "pageLength": 100
        });

    });

</script>

</body>
</html>