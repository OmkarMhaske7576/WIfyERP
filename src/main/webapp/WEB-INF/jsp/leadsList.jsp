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

<%--<c:set var = "now" value = "<% = new java.util.Date()%>" />--%>

<c:set var="now" value="<%= new java.util.Date()%>"/>

<c:if test="${level == '0'}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/leads'">Leads</span>
    </h3><br>
</c:if>

<c:if test="${level > '0'}">
    <h3 id="display_name">
        <span>Leads</span>
        <span onclick="window.location='/leads/${leadtype}'"> > ${leadtype} leads</span>
    </h3><br>
</c:if>

<c:if test="${level == '0'}">

    <c:if test="${partner1 != null}">

        <ul class="nav nav-pills mb-3" id="pills-tab1" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="pills-home-first" data-toggle="pill" href="#home-first" role="tab"
                   aria-controls="pills-home" aria-selected="true">${partner1}</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="pills-profile-first" data-toggle="pill" href="#profile-first" role="tab"
                   aria-controls="pills-profile" aria-selected="false">${partner2}</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="pills-follow-first" data-toggle="pill" href="#follow-first" role="tab"
                   aria-controls="pills-follow" aria-selected="false">${partner3}</a>
            </li>
        </ul>

        <div class="tab-content" id="pills-tabContent">

                <%-------------------------------- Croissance Leads  orderListshow active ---------------------------------------%>

            <div class="tab-pane fade active show" id="home-first" role="tabpanel" aria-labelledby="pills-home-tab">


                <h2>Total Leads: ${orderList1.size()}</h2>
                <br>

                <table id="example4" class="table table-striped">
                    <thead>
                    <tr>
                        <th>Sr.No</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Mobile no</th>
                        <th>Status</th>
                        <th>Lead Type</th>
                        <th>Quotations</th>

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
                            <td>${clientObj.name}</td>
                            <td>${clientObj.address}</td>
                            <td>${clientObj.mobile}</td>
                            <td>${clientObj.stage}</td>
                            <td>${clientObj.category}</td>
                            <td>
                                <button type="button" class="btn btn-success btn-sm"
                                        onclick="window.location='/quotationList/${clientObj.id}'">
                                    Quotations
                                </button>
                            </td>
                        </tr>
                    </c:forEach>

                    </tbody>

                </table>

            </div>

                <%-------------------------------- Self Leads ---------------------------------------%>

            <div class="tab-pane fade" id="profile-first" role="tabpanel" aria-labelledby="pills-profile-tab">

                <h2>Total Leads: ${orderList2.size()}</h2>
                <br>

                <table id="example5" class="table table-striped">
                    <thead>
                    <tr>
                        <th>Sr.No</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Mobile no</th>
                        <th>Status</th>
                        <th>Lead Type</th>
                        <th>Quotations</th>
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
                            <td>${clientObj.name}</td>
                            <td>${clientObj.address}</td>
                            <td>${clientObj.mobile}</td>
                            <td>${clientObj.stage}</td>
                            <td>${clientObj.category}</td>
                            <td>
                                <button type="button" class="btn btn-success btn-sm"
                                        onclick="window.location='/quotationList/${clientObj.id}'">
                                    Quotations
                                </button>
                            </td>
                        </tr>
                    </c:forEach>

                    </tbody>

                </table>
            </div>

                <%-------------------------------- Follow up Leads ---------------------------------------%>

            <div class="tab-pane fade" id="follow-first" role="tabpanel" aria-labelledby="pills-follow-tab">

                <h2>Total Leads: ${orderList3.size()}</h2>
                <br>

                <table id="example6" class="table table-striped">
                    <thead>
                    <tr>
                        <th>Sr.No</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Mobile no</th>
                        <th>Status</th>
                        <th>Lead Type</th>
                        <th>Quotations</th>
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
                            <td>${clientObj.name}</td>
                            <td>${clientObj.address}</td>
                            <td>${clientObj.mobile}</td>
                            <td>${clientObj.stage}</td>
                            <td>${clientObj.category}</td>
                            <td>
                                <button type="button" class="btn btn-success btn-sm"
                                        onclick="window.location='/quotationList/${clientObj.id}'">
                                    Quotations
                                </button>
                            </td>
                        </tr>
                    </c:forEach>

                    </tbody>

                </table>

            </div>
        </div>

    </c:if>

</c:if>

<c:if test="${level > ('0')}">

    <%-------------------------------- Digital leads ---------------------------------------%>

    <c:if test="${leadtype.equals('digital')}">

        <c:if test="${level.equals('1') && isSalesEmployeeLoggedIn.equals('false')}">
            <button type="button" class="btn btn-success btn-sm"
                    onclick="window.location='/addLeads/${"add"}/${"Digital"}'">Add Leads
            </button>
            <br><br>
        </c:if>

        <table id="example3" class="table table-striped">
            <thead>
            <tr>
                    <%--                    <th>Sr.No</th>--%>
                <th>Name</th>
                <th>Address</th>
                <th>Mobile no</th>
                <th>Status</th>

                <c:if test="${level.equals('1')  && isSalesEmployeeLoggedIn.equals('false')}">
                    <th>Captured By</th>
                </c:if>
                <c:if test="${level > ('0') && isSalesEmployeeLoggedIn.equals('true')}">
                    <th>Capture lead</th>
                </c:if>

                <c:if test="${level > ('1') && isSalesEmployeeLoggedIn.equals('false')}">
                    <th>Capture lead</th>
                </c:if>

            </tr>
            </thead>
            <tbody>

            <c:forEach var="clientObj" items="${sharedLeads}" varStatus="counter">

                <%--                    <c:if test="${clientObj.category.equals('Digital')}">--%>

                <tr>
                        <%--                        <td>--%>
                        <%--                            <c:if test="${counter.index+1 < 10}">--%>
                        <%--                                0${counter.index+1}--%>
                        <%--                            </c:if>--%>

                        <%--                            <c:if test="${counter.index+1 > 9}">--%>
                        <%--                                ${counter.index+1}--%>
                        <%--                            </c:if>--%>

                        <%--                        </td>--%>
                    <td>${clientObj.name}</td>
                    <td>${clientObj.address}</td>
                    <td>${clientObj.mobile}</td>
                    <td>${clientObj.stage}</td>

                    <c:if test="${level.equals('1') && isSalesEmployeeLoggedIn.equals('false')}">
                        <td>${clientObj.captureBy}</td>
                    </c:if>
                    <c:if test="${level > ('0') && isSalesEmployeeLoggedIn.equals('true')}">
                        <td>
                            <button type="button" class="btn btn-success btn-sm"
                                    onclick="window.location='/captureLead/${clientObj.id}'">Capture
                            </button>
                        </td>
                    </c:if>
                    <c:if test="${level > ('1') && isSalesEmployeeLoggedIn.equals('false')}">

                        <td>
                            <button type="button" class="btn btn-success btn-sm"
                                    onclick="window.location='/addLeads/${"edit"}/${clientObj.id}'">Capture
                            </button>
                        </td>
                    </c:if>
                </tr>
                <%--                    </c:if>--%>
            </c:forEach>

            </tbody>

        </table>

    </c:if>


    <%-------------------------------- Follow Ups  ---------------------------------------%>

    <c:if test="${leadtype.equals('booked')}">

        <table id="example2" class="table table-striped">
            <thead>
            <tr>
                    <%--                    <th>Sr.No</th>--%>
                <th>Name</th>
                <th>Address</th>
                <th>Mobile no</th>
                <th>stage</th>
                <c:if test="${isSalesEmployeeLoggedIn.equals('false')}">
                    <th>Employee</th>
                </c:if>
                <c:if test="${isSalesEmployeeLoggedIn.equals('true')}">
                    <th>Client</th>
                </c:if>
                <th>Action</th>
                <th>Quotations</th>
            </tr>
            </thead>
            <tbody>

            <c:forEach var="clientObj" items="${bookedLeads}" varStatus="counter">

                <tr>
                    <td>${clientObj.name}</td>
                    <td>${clientObj.address}</td>
                    <td>${clientObj.mobile}</td>
                    <td>${clientObj.stage}</td>

                    <c:forEach var="employeeNamesObj" items="${employeeNames}">

                        <c:if test="${employeeNamesObj.key == clientObj.salesEmpID}">

                            <td>${employeeNamesObj.value}</td>

                        </c:if>

                    </c:forEach>

                    <c:choose>
                        <c:when test="${clientObj.stage.equals('Qualify') && isSalesEmployeeLoggedIn.equals('true')}">
                            <td>
                                <button type="button" class="btn btn-success btn-sm"
                                        onclick="window.location='/addClient/${"add"}/${clientObj.id}'">Add Client
                                </button>
                            </td>
                        </c:when>
                        <c:when test="${clientObj.stage ne ('Qualify') && isSalesEmployeeLoggedIn.equals('true')}">
                            <td>-</td>
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>

                  <%--  <c:if test="${clientObj.stage.equals('Qualify') && isSalesEmployeeLoggedIn.equals('true')}">
                        <td>
                            <button type="button" class="btn btn-success btn-sm"
                                    onclick="window.location='/addClient/${"add"}/${clientObj.id}'">Add Client
                            </button>
                        </td>
                    </c:if>--%>
                    <td>
                        <button type="button" class="btn btn-success btn-sm"
                                onclick="window.location='/addLeads/${"edit"}/${clientObj.id}'">Edit
                        </button>

                    </td>

                    <td>
                        <button type="button" class="btn btn-success btn-sm"
                                onclick="window.location='/quotationList/${clientObj.id}'">
                            Quotations
                        </button>
                    </td>
                </tr>

            </c:forEach>

            </tbody>

        </table>

    </c:if>

    <%--     ---------------- self leads --------------------------------------------%>

    <c:if test="${leadtype.equals('self')}">

        <div>

            <button type="button" class="btn btn-success btn-sm"
                    onclick="window.location='/addLeads/${"add"}/${"Self"}'">Add Leads
            </button>
            <br><br>

            <table id="example1" class="table table-striped">
                <thead>
                <tr>
                    <th>Sr.No</th>
                    <th>Name</th>
                    <th>Address</th>
                    <th>Mobile no</th>
                    <th>Status</th>
                    <th
                            <c:if test="${isSalesEmployeeLoggedIn.equals('true')}">hidden</c:if> >Employee
                    </th>
                    <th>Action</th>
                    <th>Quotations</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach var="clientObj" items="${hashmap}" varStatus="counter">
                    <%--                    <c:if test="${clientObj.category != ('Digital')}">--%>
                    <tr>
                        <td>
                            <c:if test="${counter.index+1 < 10}">
                                0${counter.index+1}
                            </c:if>

                            <c:if test="${counter.index+1 > 9}">
                                ${counter.index+1}
                            </c:if>

                        </td>
                        <td>${clientObj.name}</td>
                        <td>${clientObj.address}</td>
                        <td>${clientObj.mobile}</td>
                        <td>${clientObj.stage}</td>

                        <c:forEach var="employeeNamesObj" items="${employeeNames}">

                            <c:if test="${employeeNamesObj.key == clientObj.salesEmpID}">

                                <td>${employeeNamesObj.value}</td>

                            </c:if>

                        </c:forEach>

                        <td>
                            <button type="button" class="btn btn-success btn-sm"
                                    onclick="window.location='/addLeads/${"edit"}/${clientObj.id}'">Edit
                            </button>

                            <c:if test="${clientObj.stage.equals('Qualify')}">
                                <button type="button" class="btn btn-success btn-sm"
                                        onclick="window.location='/addClient/${"add"}/${clientObj.id}'">Add Client
                                </button>
                            </c:if>

                        </td>
                        <td>
                            <button type="button" class="btn btn-success btn-sm"
                                    onclick="window.location='/quotationList/${clientObj.id}'">
                                Quotations
                            </button>
                        </td>
                    </tr>
                    <%--                    </c:if>--%>
                </c:forEach>

                </tbody>

            </table>

        </div>

    </c:if>

</c:if>

<script>
    function loadModel(subject) {

        $("#modalAbandonedCart").modal('show');
    }
</script>

<script>

    $(document).ready(function () {

        if (${level > "0"}) {

            $('#example1').dataTable({
                "aLengthMenu": [25, 50, 75, 100],
                "pageLength": 100,

                "aoColumns": [
                    {"sWidth": "5%"},
                    {"sWidth": "20%"},
                    {"sWidth": "15%"},
                    {"sWidth": "15%"},
                    {"sWidth": "10%"},
                        <c:if test="${isSalesEmployeeLoggedIn.equals('false')}">{"sWidth": "20%"}, </c:if>
                    {"sWidth": "5%"},
                    {"sWidth": "10%"}
                ]
            });

            $('#example2').dataTable({
                "aLengthMenu": [25, 50, 75, 100],
                "pageLength": 100
            });

            $('#example3').dataTable({
                "aLengthMenu": [25, 50, 75, 100],
                "pageLength": 100
            });
        }

        <c:if test="${level == '0'}">

        $('#example4').dataTable({
            "aLengthMenu": [25, 50, 75, 100],
            "pageLength": 100,

        });

        $('#example5').dataTable({
            "aLengthMenu": [25, 50, 75, 100],
            "pageLength": 100
        });

        $('#example6').dataTable({
            "aLengthMenu": [25, 50, 75, 100],
            "pageLength": 100
        });

        </c:if>

    });

</script>

</body>
</html>