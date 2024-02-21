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


    <%--    -----------------------------------------------------------------------------%>

    <%--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
--%>
    <%-- <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
             integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
             crossorigin="anonymous"></script>--%>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
            crossorigin="anonymous"></script>
    <!-- MDB -->
    <%--<link
            href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.1.0/mdb.min.css"
            rel="stylesheet"
    />--%>
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

    <script> var totalCount = 0; </script>

</head>
<body class="theme-body" style="overflow-x: auto">

<h3 id="display_name">
    <span>Client > </span>
    <span onclick="window.location='/companyWiseOrderList'">Company wise OrderLst</span>
</h3><br>

<c:if test="${partner1 != null}">

    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab"
               aria-controls="pills-home" aria-selected="true">${partner1}</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="pills-follow-tab" data-toggle="pill" href="#pills-follow" role="tab"
               aria-controls="pills-follow" aria-selected="false">${partner2}</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="pills-shared-tab" data-toggle="pill" href="#pills-shared" role="tab"
               aria-controls="pills-shared" aria-selected="false">${partner3}
            </a>
        </li>
    </ul>

    <div class="tab-content" id="pills-tabContent">

        <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">

            <h2>Total Orders: ${orderList1.size()}</h2>
            <br>

            <table id="example1" class="table table-striped">
                <thead>
                <tr>
                    <th>Sr.No</th>
                    <th>Name</th>
                    <th>Status</th>
                    <th>Order Date</th>
                    <th>Pay Status</th>
                    <th>Products</th>
                    <td>Invoice</td>
                </tr>
                </thead>
                <tbody>

                <c:forEach var="clientObj" items="${orderList1}" varStatus="counter">
                    <tr>
                        <td>
                            <c:if test="${counter.index+1 < 10}">
                                0${counter.index+1}
                            </c:if>

                            <c:if test="${counter.index+1 > 9}">
                                ${counter.index+1}
                            </c:if>

                        </td>
                        <td>${clientObj.clientName}</td>
                        <td>${clientObj.status}</td>
                        <td>${clientObj.orderDate}</td>
                        <td>${clientObj.payStatus}</td>
                        <td>
                            <button type="button" class="btn btn-success btn-sm"
                                    onclick="window.location='/orderBOM/${clientObj.quotationId}/${clientObj.id}/${"company"}'">
                                Products
                            </button>
                        </td>
                        <td>
                            <button type="button"
                                    <c:if test="${clientObj.status != ('Completed')}">disabled</c:if>
                                    class="btn btn-success btn-sm ml-2"
                                    onclick="window.location='/generateInvoice/${clientObj.clientId}/${clientObj.quotationId}/${clientObj.companyID}/${"client"}'">
                                Invoice
                            </button>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>

            </table>

        </div>

            <%-------------------------------- Follow Ups  ---------------------------------------%>

        <div class="tab-pane fade" id="pills-follow" role="tabpanel" aria-labelledby="pills-follow-tab">

            <h2>Total Orders: ${orderList2.size()}</h2>
            <br>

            <table id="example2" class="table table-striped">
                <thead>
                <tr>
                    <th>Sr.No</th>
                    <th>Name</th>
                    <th>Status</th>
                    <th>Order Date</th>
                    <th>Pay Status</th>
                    <th>Products</th>
                    <td>Invoice</td>
                </tr>
                </thead>
                <tbody>

                <c:forEach var="clientObj" items="${orderList2}" varStatus="counter">
                    <tr>
                        <td>
                            <c:if test="${counter.index+1 < 10}">
                                0${counter.index+1}
                            </c:if>

                            <c:if test="${counter.index+1 > 9}">
                                ${counter.index+1}
                            </c:if>

                        </td>
                        <td>${clientObj.clientName}</td>
                        <td>${clientObj.status}</td>
                        <td>${clientObj.orderDate}</td>
                        <td>${clientObj.payStatus}</td>
                        <td>
                            <button type="button" class="btn btn-success btn-sm"
                                    onclick="window.location='/orderBOM/${clientObj.quotationId}/${clientObj.id}/${"company"}'">
                                Products
                            </button>
                        </td>
                        <td>
                            <button type="button"
                                    <c:if test="${clientObj.status != ('Completed')}">disabled</c:if>
                                    class="btn btn-success btn-sm ml-2"
                                    onclick="window.location='/generateInvoice/${clientObj.clientId}/${clientObj.quotationId}/${clientObj.companyID}/${"client"}'">
                                Invoice
                            </button>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>

            </table>

        </div>

            <%-------------------------------- Shared leads ---------------------------------------%>

        <div class="tab-pane fade" id="pills-shared" role="tabpanel" aria-labelledby="pills-shared-tab">

            <h2>Total Orders: ${orderList3.size()}</h2>
            <br>

            <table id="example3" class="table table-striped">
                <thead>
                <tr>
                    <th>Sr.No</th>
                    <th>Name</th>
                    <th>Status</th>
                    <th>Order Date</th>
                    <th>Pay Status</th>
                    <td>Products</td>
                    <td>Invoice</td>
                </tr>
                </thead>
                <tbody>

                <c:forEach var="clientObj" items="${orderList3}" varStatus="counter">
                    <tr>
                        <td>
                            <c:if test="${counter.index+1 < 10}">
                                0${counter.index+1}
                            </c:if>

                            <c:if test="${counter.index+1 > 9}">
                                ${counter.index+1}
                            </c:if>

                        </td>
                        <td>${clientObj.clientName}</td>
                        <td>${clientObj.status}</td>
                        <td>${clientObj.orderDate}</td>
                        <td>${clientObj.payStatus}</td>
                        <td>
                            <button type="button" class="btn btn-success btn-sm"
                                    onclick="window.location='/orderBOM/${clientObj.quotationId}/${clientObj.id}/${"company"}'">
                                Products
                            </button>
                        </td>
                        <td>
                            <button type="button"
                                    <c:if test="${clientObj.status != ('Completed')}">disabled</c:if>
                                    class="btn btn-success btn-sm ml-2"
                                    onclick="window.location='/generateInvoice/${clientObj.clientId}/${clientObj.quotationId}/${clientObj.companyID}/${"client"}'">
                                Invoice
                            </button>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>

            </table>

        </div>
    </div>

</c:if>

<script>

</script>

<script>

    $(document).ready(function () {

        $('#example1').dataTable({
            "aLengthMenu": [25, 50, 75, 100],
            "pageLength": 100,

        });

        $('#example2').dataTable({
            "aLengthMenu": [25, 50, 75, 100],
            "pageLength": 100
        });

        $('#example3').dataTable({
            "aLengthMenu": [25, 50, 75, 100],
            "pageLength": 100
        });

    });

</script>

</body>
</html>