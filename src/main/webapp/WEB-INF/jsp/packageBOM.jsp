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

        table,th,tr{
            width: 100px;
            text-align: center;
        }

        #display_name {
            cursor: pointer;
        }
    </style>

    <script>
        var total =0;

    </script>

</head>
<body class="theme-body" style="overflow-x: auto">

<h3 id="display_name">
    <span>Finance > </span>
    <span onclick="window.location='/finance_package'">Package List </span>
    <span onclick="window.location='/packageBOM/${packageID}'"> > ${package_name}</span>
</h3><br>

<button type="button" class="btn btn-success btn-sm" onclick="window.location='/addPackageBOM/${"add"}/${"null"}/${packageID}'" >Add products</button>
<br><br>

<table id="example" class="table table-striped" style="width:100%">
    <thead>
    <tr>
        <th>Product Code</th>
        <th>Product Name</th>
        <th>Quantity</th>
        <th>Total MRP</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach var="packagebom" items="${list}">
        <tr>
            <td>${packagebom.code}</td>
            <td>${packagebom.name}</td>
            <td>${packagebom.quantity}</td>
            <td>${packagebom.quantity * packagebom.price}</td>
            <script>
                total=total+${packagebom.quantity * packagebom.price};
            </script>
            <td>
                <button type="button" id="btn2" class="btn btn-success btn-sm" onclick="window.location='/addPackageBOM/${"edit"}/${packagebom.id}/${packageID}'">Edit</button>

                <button type="button" id="btn1" class="btn btn-danger btn-sm"
                        onclick="delFunction('${packagebom.id}','${package_name}','${packagebom.name}','${packageID}')">Delete</button>
            </td>
        </tr>
    </c:forEach>

    </tbody>

</table>


<script>

    function delFunction(key,packageName,productName, packageID){

        if (confirm("Delete " + productName + " from "+ packageName + " ??") == true) {

            window.location.href = "/deletePackageBom" +"/"+ key +"/" + packageID;
        }
        else {

        }
    }

    $(document).ready(function () {

        $('#example').dataTable( {
            "aLengthMenu": [25, 50, 75, 100],
            "pageLength": 100
        } );

        $.get("/getTotalAmount?total="+ total+"-${packageID}");

    });
</script>

</body>
</html>
