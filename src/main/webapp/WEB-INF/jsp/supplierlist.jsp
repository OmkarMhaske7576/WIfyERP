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

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

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

        table,th,tr{
            width: 100px;
            text-align: center;
        }

        #display_name {
            cursor: pointer;
        }
    </style>

</head>
<body class="theme-body" style="overflow-x: auto">

<h3>
    <span>Procurement > </span>
    <span id="display_name" onclick="window.location='/supplierlist'">Supplier List</span>
</h3><br>

<button type="button" class="btn btn-success btn-sm" onclick="window.location='/addSupplier/${"add"}/${"null"}'" >Add Supplier</button>
<br><br>
<table id="example" class="table table-striped" style="width:100%">
    <thead>
    <tr>
<%--        <th>Supplier id</th>--%>
        <th>Supplier name</th>
        <th>Supplier goods </th>
        <th>Address</th>
        <th>Mobile No</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach var="supplierobj" items="${suppliers}">
        <tr>
<%--            <td>${supplierobj.id}</td>--%>
            <td>${supplierobj.name}</td>
            <td>${supplierobj.goods}</td>
            <td>${supplierobj.address}</td>
            <td>${supplierobj.mobile}</td>

            <td>
                <button type="button" id="btn2" class="btn btn-success btn-sm" onclick="window.location='/addSupplier/${"edit"}/${supplierobj.id}'" data-toggle="tooltip" title=" Edit Supplier"><i class="fa-solid fa-pen-to-square"></i> </button>

                <button type="button" id="btn1" class="btn btn-danger btn-sm" onclick="delFunction('${supplierobj.name}','${supplierobj.id}')"  data-toggle="tooltip" title="Delete Supplier"><i class="fa-solid fa-trash"></i></button>
            </td>
        </tr>
    </c:forEach>

    </tbody>

</table>


<script>

    function delFunction(name,deletekey){

        if (confirm("Delete " + name + " from Supplier List"+" ??") == true) {

            window.location.href = "/deleteSupplier" +"/"+ deletekey ;
        }
        else {
        }
    }

    $(document).ready(function () {

        $('#example').dataTable( {
            "aLengthMenu": [25, 50, 75, 100],
            "pageLength": 100,
            "aoColumns": [
                {"sWidth": "20%"},
                {"sWidth": "20%"},
                {"sWidth": "20%"},
                {"sWidth": "20%"},
                {"sWidth": "20%"}
            ]
        } );

    });
</script>

</body>
</html>
