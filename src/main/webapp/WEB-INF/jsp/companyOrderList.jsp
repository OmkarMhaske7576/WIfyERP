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

<c:if test="${isSalesEmployeeLoggedIn.equals('true')}">
<h3 id="display_name">
    <span onclick="window.location='/companyOrdersList'">Orders</span>
</h3><br>
</c:if>

<c:if test="${isSalesEmployeeLoggedIn.equals('false')}">
    <h3 id="display_name">
        <span onclick="window.location='/companyOrdersList'">Company Orders</span>
    </h3><br>
</c:if>

<%--<h2>Total Orders: ${ordersCount}</h2>
<br>--%>


<c:if test="${level > ('1') || isSalesEmployeeLoggedIn.equals('true')}">

    <h2>Total Orders: ${orderlist.size()}</h2>
    <br>

    <table id="example2" class="table table-striped" style="width:100%">
        <thead>
        <tr>
            <th>Client Name</th>
            <th>Status</th>
            <th>Order Date</th>
            <th>Estimate Date</th>
            <th>Installed By</th>
            <th>Action</th>
            <th <c:if test="${isSalesEmployeeLoggedIn.equals('true')}">hidden</c:if> >Self</th>
            <th>Client</th>
        </tr>
        </thead>
        <tbody>


        <c:forEach var="orderObj" items="${orderlist}">
            <tr>
                <td>${orderObj.clientName}</td>
                <td>${orderObj.status}</td>
                <td>${orderObj.orderDate}</td>
                <td>${orderObj.estDate}</td>
                <c:choose>
                    <c:when test="${orderObj.installerName.equals('')}">
                        <td>-</td>
                    </c:when>
                    <c:otherwise>
                        <td>${orderObj.installerName}</td>
                    </c:otherwise>
                </c:choose>

                <td>
                    <button type="button" class="btn btn-success btn-sm"
                            onclick="window.location='/orderBOM/${orderObj.quotationId}/${orderObj.id}/${"company"}'">
                        Products
                    </button>

                    <c:if test="${orderObj.status.equals('Pending')}">
                        <button type="button" class="btn btn-success btn-sm ml-2" <c:if test="${isSalesEmployeeLoggedIn.equals('true')}">hidden</c:if>
                                onclick="window.location='/confirmOrder/${orderObj.id}'">
                            Confirm Order
                        </button>
                    </c:if>
                </td>

                <td <c:if test="${isSalesEmployeeLoggedIn.equals('true')}">hidden</c:if>>
                    <button type="button"
                            <c:if test="${orderObj.status != ('Completed')}">disabled</c:if>
                            class="btn btn-success btn-sm ml-2"
                            onclick="window.location='/generateInvoice/${orderObj.clientId}/${orderObj.quotationId}/${orderObj.companyID}/${"self"}'">
                        Invoice
                    </button>
                </td>

                <td>
                    <button type="button"
                            <c:if test="${orderObj.status != ('Completed')}">disabled</c:if>
                            class="btn btn-success btn-sm ml-2"
                            onclick="window.location='/generateInvoice/${orderObj.clientId}/${orderObj.quotationId}/${orderObj.companyID}/${"client"}'">
                        Invoice
                    </button>
                </td>

            </tr>
        </c:forEach>

        </tbody>

    </table>

</c:if>

<c:if test="${level.equals('1') && isSalesEmployeeLoggedIn.equals('false')}">

    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab"
               aria-controls="pills-home" aria-selected="true">Self Orders</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="pills-pending-tab" data-toggle="pill" href="#pills-pending" role="tab"
               aria-controls="pills-pending" aria-selected="true">Pending Orders</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="pills-follow-tab" data-toggle="pill" href="#pills-follow" role="tab"
               aria-controls="pills-follow" aria-selected="false">Marketing Orders</a>
        </li>
    </ul>

    <div class="tab-content" id="pills-tabContent">

        <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">

            <h2>Total Orders: ${selfOrdersCount}</h2>
            <br>

            <table id="example" class="table table-striped" style="width:100%">
                <thead>
                <tr>
                    <th>Client Name</th>
                    <th>Status</th>
                    <th>Order Date</th>
                    <th>Estimate Date</th>
                    <th>Installed by</th>
                    <th>Action</th>
                    <th>Self</th>
                    <th>Client</th>
                </tr>
                </thead>
                <tbody>


                <c:forEach var="orderObj" items="${orderlist}">
                    <c:if test="${!orderObj.status.equals('Pending')}">
                        <tr>

                            <td>${orderObj.clientName}</td>
                            <td>${orderObj.status}</td>
                            <td>${orderObj.orderDate}</td>
                            <td>${orderObj.estDate}</td>

                            <c:choose>
                                <c:when test="${orderObj.installerName.equals('')}">
                                    <td>-</td>
                                </c:when>
                                <c:otherwise>
                                    <td>${orderObj.installerName}</td>
                                </c:otherwise>
                            </c:choose>


                            <td>
                                <button type="button" class="btn btn-success btn-sm"
                                        onclick="window.location='/orderBOM/${orderObj.quotationId}/${orderObj.id}/${"company"}'">
                                    Products
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

                            <td>
                                <button type="button"
                                        <c:if test="${orderObj.status != ('Completed')}">disabled</c:if>
                                        class="btn btn-success btn-sm ml-2"
                                        onclick="window.location='/generateInvoice/${orderObj.clientId}/${orderObj.quotationId}/${orderObj.companyID}/${"client"}'">
                                    Invoice
                                </button>
                            </td>

                        </tr>
                    </c:if>
                </c:forEach>

                </tbody>

            </table>

        </div>

            <%-------------------------------- Pending orders -----------------------------------------------%>

        <div class="tab-pane fade" id="pills-pending" role="tabpanel" aria-labelledby="pills-pending-tab">

            <h2>Total Orders: ${pendingOrdersCount}</h2>
            <br>

            <table id="example3" class="table table-striped" style="width:100%">
                <thead>
                <tr>
                    <th>Client Name</th>
                    <th>Status</th>
                    <th>Order Date</th>
                    <th>Estimate Date</th>
                    <th>Action</th>
                    <th>Confirm</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="orderObj" items="${orderlist}">
                    <c:if test="${orderObj.status.equals('Pending')}">
                        <tr>

                            <td>${orderObj.clientName}</td>
                            <td>${orderObj.status}</td>
                            <td>${orderObj.orderDate}</td>
                            <td>${orderObj.estDate}</td>

                            <td>
                                <button type="button" class="btn btn-success btn-sm"
                                        onclick="window.location='/orderBOM/${orderObj.quotationId}/${orderObj.id}/${"company"}'">
                                    Products
                                </button>

                            </td>
                            <td>
                                <button type="button" class="btn btn-success btn-sm ml-2"
                                        onclick="window.location='/confirmOrder/${orderObj.id}'">
                                    Confirm Order
                                </button>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>

                </tbody>

            </table>

        </div>

            <%-------------------------------- child Orders  ---------------------------------------%>

        <div class="tab-pane fade" id="pills-follow" role="tabpanel" aria-labelledby="pills-follow-tab">

            <h2>Total Orders: ${childOrderList.size()}</h2>
            <br>

            <table id="example1" class="table table-striped" style="width:100%">
                <thead>
                <tr>
                    <th>Client Name</th>
                    <th>Status</th>
                    <th>Order Date</th>
                    <th>Estimate Date</th>
                    <th>Action</th>
                    <th>Invoice</th>
                </tr>
                </thead>
                <tbody>


                <c:forEach var="orderObj" items="${childOrderList}">
                    <tr>
                        <td>${orderObj.clientName}</td>
                        <td>${orderObj.status}</td>
                        <td>${orderObj.orderDate}</td>
                        <td>${orderObj.estDate}</td>

                        <td>
                            <button type="button" class="btn btn-success btn-sm"
                                    onclick="window.location='/orderBOM/${orderObj.quotationId}/${orderObj.id}/${"company"}'">
                                Products
                            </button>
                                <%--  <c:if test="${orderObj.status.equals('Pending')}">
                                      <button type="button" class="btn btn-success btn-sm ml-2"
                                              onclick="window.location='/confirmOrder/${orderObj.id}'">
                                          Confirm Order
                                      </button>
                                  </c:if>--%>

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

        </div>

    </div>

</c:if>


<script>

    // var a = $.fn.dataTable.absoluteOrder({
    //     value:'Cancelled', position:'top'
    // });

    $(document).ready(function () {

        if (${level > "1" || isSalesEmployeeLoggedIn.equals('true')}) {

            $('#example2').dataTable({
                "aLengthMenu": [25, 50, 75, 100],
                "pageLength": 100,

                "order": [[2, 'desc']],
            });
        }

        if (${level =="1" && isSalesEmployeeLoggedIn.equals('false')}) {

            $('#example').dataTable({
                "aLengthMenu": [25, 50, 75, 100],
                "pageLength": 100,

                "order": [[2, 'desc']],
            });

            $('#example1').dataTable({
                "aLengthMenu": [25, 50, 75, 100],
                "pageLength": 100,

                "order": [[2, 'desc']],
            });

            $('#example3').dataTable({
                "aLengthMenu": [25, 50, 75, 100],
                "pageLength": 100,

                // "order": [[2, 'desc']],
            });
        }
    });

</script>

</body>
</html>
