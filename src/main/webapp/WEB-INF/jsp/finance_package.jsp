<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang='en'>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

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

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />


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
    <span>Finance > </span>
    <span id="display_name" onclick="window.location='/finance_package'">Package List</span>
</h3><br>

<button type="button" class="btn btn-success btn-sm" onclick="window.location='/addPackage/${"add"}/${"null"}'" >Create Package</button>
<br><br>
<table id="example" class="table table-striped" style="width:100%">
    <thead>
    <tr>
        <th>Package Name</th>
        <th>Total Amount</th>
        <th>Discount</th>
        <th>Discounted Price</th>
        <th>Products</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>

<c:forEach var="packageobj" items="${packagelist}">

        <tr>

            <td>${packageobj.name}</td>
            <td>
                <fmt:formatNumber value="${packageobj.total}" minFractionDigits="0" maxFractionDigits="0"/>
            </td>
            <td>${packageobj.discount}%</td>
            <td>
                    ${packageobj.finalTotal}
<%--                <fmt:formatNumber value="${packageobj.total - packageobj.total * packageobj.discount / 100}" minFractionDigits="0" maxFractionDigits="0"/>--%>
            </td>
            <td>
                <button type="button" id="btn3" class="btn btn-success btn-sm" onclick="window.location='/packageBOM/${packageobj.id}'" >Products</button>
            </td>
            <td>
                <button type="button" id="btn2" class="btn btn-success btn-sm ml-2" onclick="window.location='/addPackage/${"edit"}/${packageobj.id}'" data-toggle="tooltip" title=" Edit Package"><i class="fa-solid fa-pen-to-square"></i></button>

                <button type="button" id="btn1" onclick="delFunction('${packageobj.id}','${packageobj.name}')" class="btn btn-danger btn-sm" title="Delete Package">Delete </button>
            </td>
        </tr>

</c:forEach>

<script>
    function delFunction(key,package_name){

        if (confirm("Delete Package " + package_name + " ??") == true) {

            window.location.href = "/deletePackage" +"/"+ key;
        }
        else {

        }
    }
</script>

<script>
    var deletekey;
    var package_name;

    function open_popup(key,packagename){
        deletekey = key;
        package_name = packagename;

    $('#set_content').text("Do you want Delete "+package_name+" Package ??");
    $('#modelWindow').modal('show');
}

function deletePackage(){

        $.get("/deletePackage?deletekey="+ deletekey,{ });

        $('#modelWindow').modal('hide');
}
</script>

<div class="modal fade" id="modelWindow" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Delete Package</h5>
            </div>
            <div class="modal-body">
                <p id="set_content"></p>
            </div>
            <div class="modal-footer">
                <button type="button" id="cancal" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-danger" onclick="deletePackage()" >Delete</button>
            </div>
        </div>
    </div>
</div>



    </tbody>

</table>

<script>
    $(document).ready(function () {
        $('#example').dataTable( {
            "aLengthMenu": [25, 50, 75, 100],
            "pageLength": 100
        } );

        $('#cancal').click(function() {
            $('#modelWindow').modal('hide');
        });

});

</script>

</body>
</html>
