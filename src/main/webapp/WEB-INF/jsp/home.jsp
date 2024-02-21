<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang='en'>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Wify ERP</title>

    <link rel="icon" href="/images/wify.png" type="image/x-icon" style="width: 100%">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">


    <script type="text/javascript" src="//code.jquery.com/jquery-1.11.3.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
          integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/css/grid_stack.min.css"/>
    <link rel="stylesheet" href="/js/plugins/jquery_confirm/jquery_confirm.css">
    <link rel="stylesheet" href="/js/plugins/colorpicker/bootstrap-colorpicker-plus.min.css">
    <link rel="stylesheet" href="/js/plugins/scrollbar/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="/js/plugins/intro-tour/introjs.min.css">
    <link rel="stylesheet" href="/js/plugins/intro-tour/themes/introjs-modern.css">
    <link rel="stylesheet" href="js/plugins/datepicker/datepicker.css">


    <link rel="stylesheet" type="text/css" href="/css/dripicon.css"/>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <link rel="stylesheet" type="text/css" href="/css/responsive.css"/>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
          integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

    <style>
        @import url("https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.4.0/font/bootstrap-icons.min.css");
    </style>

    <style>

        body {
            margin: 0;
        }

        .iframe-container {
            height: 30px;
        }

        iframe {

            display: block;
            border: none;
            /*height: calc(130vh);*/
            /*height: 800px;*/
       <c:if test="${level > '0' }"> height: 88vh;
        </c:if><c:if test="${level == '0' || level == ''}"> height: 112vh;
        </c:if> width: 100%;

        }

        a.fa-bell {
            position: relative;
            font-size: 2em;
            color: blue;
            cursor: pointer;
        }

        span.fa-comment {
            position: absolute;
            font-size: 0.6em;
            top: -4px;
            color: red;
            right: -4px;
        }

        span.num {
            position: absolute;
            font-size: 0.3em;
            top: 1px;
            color: #fff;
            right: 2px;
        }

        .fa-stack[data-count]:after {
            position: absolute;
            right: 0%;
            top: 1%;
            content: attr(data-count);
            font-size: 40%;
            padding: .6em;
            border-radius: 999px;
            line-height: .75em;
            color: white;
            background: rgba(255, 0, 0, .85);
            text-align: center;
            min-width: 2em;
            font-weight: bold;
        }

        .get_pn {

            cursor: pointer;
        }

        .sidebar-header {

            margin: 10px 0 0;
        }

        .console-menu {

            margin-top: 10px;
        }

        .example::-webkit-scrollbar { display: none; }

    </style>

    <script
            type="text/javascript">

        function clientclick() {

            /* $.get("/setDateInGlobal?name="+"client", {

             });*/

            clientNotification = 0;

            clientCount = 0;

            $("#models1").modal('hide');

            $('#myIframe').attr('src', '/clientlist/${"null"}/${"null"}');

            $('#notification').each(function (index) {

                count = count - 1;

                $(this).attr('data-count', count);
            });
        }

        function orderclick() {

            /* $.get("/setDateInGlobal?name="+"order", {

             });*/

            orderNotification = 0;

            orderCount = 0;

            $("#models1").modal('hide');

            if (${level =="0" && isEmployeeLoggedIn.equals('false')}) {

                $('#myIframe').attr('src', '/orderlist');
            }

            if (${level =="0" && isEmployeeLoggedIn.equals('true')}) {

                $('#myIframe').attr('src', '/employeeOrdersList');
            }

            if (${level > "0"}) {

                $('#myIframe').attr('src', '/companyOrdersList');
            }

            $('#notification').each(function (index) {

                count = count - 1;

                $(this).attr('data-count', count);
            });
        }

        function dashboard() {

            $('#myIframe').attr('src', '/dashboard');

        }

        function loadUrl(data) {

            $('#myIframe').attr('src', '/' + data);

        }

    </script>

</head>
<body class="theme-body example">

<div class="theme-wrapper">

    <%--   header start--%>
    <header>
        <div class="header-left">
            <div class="logo">
                <h3 id="title" style="text-align: center">WIFYERP</h3>
            </div><!-- Logo -->
            <div class="sidemenu-opener"><a href="#" title=""><i class="icon dripicons-align-left"></i></a></div>
        </div><!-- Header Left -->
        <div>
            <h3 style="text-align: right">Welcome ${loggedInName}</h3>
        </div>
        <div class="header-right" style="justify-content: end;" >

            <span id="notification" class="fa-stack fa-2x has-badge" style="cursor: pointer"
                  <c:if test="${isSalesEmployeeLoggedIn.equals('true') || isEmployeeLoggedIn.equals('true')}">hidden</c:if>
                  onclick="orderPopup()" <%--data-count="${Cal}" title="${Cal} new Orders"--%>>
                <i class="fa fa-circle fa-stack-2x"></i>
                <i class="fa fa-bell fa-stack-1x fa-inverse"></i>
            </span>

            <span id="notification1" class="fa-stack fa-2x has-badge" style="cursor: pointer"
                  onclick="logout()" <%--title="${company_email}"--%> title="Log Out">
                <i class="fa fa-circle fa-stack-2x"></i>
                <i class="fa fa-sign-out fa-stack-1x fa-inverse"></i>
            </span>

        </div>

    </header>
    <%--    header end--%>

    <div class="theme-content">
        <aside class="console-sidemenu active" id="sidemenu">
            <nav>
                <ul class="console-menu">

                    <c:if test="${isSalesEmployeeLoggedIn.equals('false') && isEmployeeLoggedIn.equals('false')}">
                        <li><a class="get_pn" id="dashboard"
                            <%-- title="" onclick="dashboard()"--%>><i class="fas fa-home" style="color: #0a6aa1"></i>
                            <span>Dashboard</span></a></li>

                        <li class="sidebar-header"></li>
                    </c:if>
                    <%--  <li><a class="get_pn" id="installationModulesSelection" >
                          <i class="fa-solid fa-bag-shopping" style="color: #0a6aa1"></i> <span>Modules</span></a>
                      </li>

                      <li class="sidebar-header"></li>--%>
                    <%--  <li>
                          <a class="get_pn" id="managersList">
                          <i class="fa-solid fa-user-group" style="color: #0a6aa1"></i>
                          <span>Managers</span></a>
                      </li>

                      <li class="sidebar-header"></li>--%>

                    <c:if test="${level == ''}">
                        <li><a class="get_pn" id="salesPartner">
                            <i class="fa-solid fa-user-group"
                               style="color: #0a6aa1; "></i><span>Sales Partner</span></a>
                        </li>
                    </c:if>

                    <c:if test="${level == '0' && isEmployeeLoggedIn.equals('false')}">

                        <li><a href="#" title=""><span>Finance</span></a>
                            <ul>
                                <li><a id="finance_productlist" class="get_pn"
                                    <%--class="get_pn" href="#" title="" onclick="finance_productlist()"--%>>
                                    <i class="fa-solid fa-list" style="color: #0a6aa1;"></i>
                                    <span>Product list</span></a>
                                </li>

                                <li><a class="get_pn" id="finance_package"
                                    <%-- href="#" title="" onclick="finance_package()"--%>>
                                    <i class="fa-solid fa-box-open" style="color: #0a6aa1;"></i>
                                    <span>Package list</span></a></li>

                            </ul>
                        </li>
                        <li class="sidebar-header"></li>

                        <li><a href="#" title=""> <span>Client</span></a>
                            <ul>

                                <c:if test="${isManagerLoggedIn.equals('false')}">
                                    <li>
                                        <a class="get_pn" id="managersList">
                                            <i class="fa-solid fa-user-group" style="color: #0a6aa1"></i>
                                            <span>Self Managers</span></a>
                                    </li>
                                </c:if>

                                <li><a class="get_pn" id="salesPartner">
                                    <i class="fa-solid fa-user-group"
                                       style="color: #0a6aa1; "></i><span>Sales Partner</span></a>
                                </li>

                                <li><a class="get_pn" id="salesEmployeeList">
                                    <i class="fa-solid fa-user-group"
                                       style="color: #0a6aa1;"></i><span>Sales Employee</span></a>
                                </li>

                                <li><a class="get_pn" id="clientList">
                                    <i class="fa-solid fa-user-group"
                                       style="color: #0a6aa1; "></i><span>Client List</span></a>
                                </li>

                                <li>
                                    <a class="get_pn" id="leads" style="cursor: pointer">
                                        <i class="fa fa-bullhorn" style="color: #0a6aa1" <%--aria-hidden="true"--%>></i>
                                        <span>Leads</span>
                                    </a>
                                </li>

                                <li><a class="get_pn" id="companyWiseOrderList" onclick="order()">
                                    <i class="fa-solid fa-list-check" style="color: #0a6aa1"></i>
                                    <span>Company Wise OrderList</span></a>
                                </li>

                            </ul>
                        </li>
                        <li class="sidebar-header"></li>

                    </c:if>

                    <c:if test="${level > '0' && isSalesEmployeeLoggedIn.equals('false')}">
                        <li><a class="get_pn" id="salesPartner">
                            <i class="fa-solid fa-user-group"
                               style="color: #0a6aa1; "></i><span>Sales Partner</span></a>
                        </li>
                        <li class="sidebar-header"></li>

                        <c:if test="${isManagerLoggedIn.equals('false')}">
                            <li>
                                <a class="get_pn" id="managersList">
                                    <i class="fa-solid fa-user-group" style="color: #0a6aa1"></i>
                                    <span>Managers</span></a>
                            </li>
                            <li class="sidebar-header"></li>
                        </c:if>

                        <li><a class="get_pn" id="salesEmployeeList">
                            <i class="fa-solid fa-user-group"
                               style="color: #0a6aa1;"></i><span>Sales Employee</span></a>
                        </li>
                        <li class="sidebar-header"></li>

                        <li><a class="get_pn" id="clientList">
                            <i class="fa-solid fa-user-group" style="color: #0a6aa1; "></i><span>Client List</span></a>
                        </li>
                        <li class="sidebar-header"></li>

                        <li><a href="#" title=""> <span>Leads</span></a>
                            <ul>

                                <li
                                        <%--<c:if test="${level > '1'}">hidden</c:if> --%>>
                                    <a class="get_pn" id="leads/digital" style="cursor: pointer">
                                        <i class="fa fa-bullhorn" style="color: #0a6aa1" aria-hidden="true"></i>
                                        <span>Digital Leads</span>
                                    </a>
                                </li>

                                <li>
                                    <a class="get_pn" id="leads/booked" style="cursor: pointer">
                                        <i class="fa fa-bullhorn" style="color: #0a6aa1" aria-hidden="true"></i>
                                        <span>Booked Leads</span>
                                    </a>
                                </li>

                                <li>
                                    <a class="get_pn" id="leads/self" style="cursor: pointer">
                                        <i class="fa fa-bullhorn" style="color: #0a6aa1" aria-hidden="true"></i>
                                        <span>Self Leads</span>
                                    </a>
                                </li>

                            </ul>
                        </li>

                        <%--  <li>
                              <a class="get_pn" id="leads" style="cursor: pointer">
                                  <i class="fa fa-bullhorn" style="color: #0a6aa1" &lt;%&ndash;aria-hidden="true"&ndash;%&gt;></i>
                                  <span>Leads</span>
                              </a>
                          </li>--%>
                        <li class="sidebar-header"></li>

                        <li><a class="get_pn" id="companyOrdersList">
                            <i class="fa-solid fa-list-check" style="color: #0a6aa1"></i>
                            <span>Company Orders</span></a></li>
                        <%--                        <li class="sidebar-header"></li>--%>

                    </c:if>


                    <%--<li><a href="#" title=""> <span>Client</span></a>
                        <ul>
                            &lt;%&ndash; <li><a class="get_pn" id="clientlist/null/null"
                             &lt;%&ndash;data-title="Web Analytics" href="#" id="clientid" c title=""&ndash;%&gt; >
                                 <i class="fa-solid fa-user-group" style="color: #0a6aa1; font-size: 1.75em;"></i><span>Client List</span></a>
                             </li>

                             <li><a class="get_pn" id="businessClient">
                                 <i class="fa-solid fa-user-group" style="color: #0a6aa1; font-size: 1.75em;"></i><span>Business Client List</span></a>
                             </li>&ndash;%&gt;



                        </ul>
                    </li>--%>

                    <c:if test="${level == '0' && isEmployeeLoggedIn.equals('false')}">
                        <li><a href="#" title=""> <span>Manufacturing</span></a>
                            <ul>

                                <li><a class="get_pn" id="getManufacturingBOM"
                                    <%--href="#" onclick="manufacturingbom()" title=""--%>>
                                    <i class="fas fa-industry" style="color: #0a6aa1; font-size: 1.75em"></i>
                                    <span>BOM</span></a></li>

                            </ul>
                        </li>

                        <li class="sidebar-header"></li>
                        <li><a href="#" title=""> <span>Inventory</span></a>
                            <ul>

                                <li><a class="get_pn" id="inventory_item_productList"
                                    <%--href="#" onclick="inventory_item_product()"  title=""--%>>
                                    <i class="fa-solid fa-box-open" style="color: #0a6aa1"></i>
                                    <span>Products</span></a>
                                </li>

                                <li><a class="get_pn" id="inventory_item_rawMaterialList"
                                    <%--href="#" onclick="inventory_item_raw()"  title=""--%>>
                                    <i class="fa-solid fa-sitemap" style="color: #0a6aa1"></i>
                                    <span>Raw Materials</span></a></li>

                                <li><a class="get_pn" id="inventoryProductionlist/inventory"
                                    <%-- onClick="inventory_production()"--%> title="">
                                    <i class="bi bi-bag-fill" style="color: #0a6aa1"></i> <span>Product Requests</span></a>
                                </li>

                                <li><a class="get_pn" id="rawRequestProductionList"
                                    <%--href="#" onclick="inventory_item_raw_request()"  title=""--%>>
                                    <i class="fa-solid fa-bag-shopping" style="color: #0a6aa1"></i> <span>Raw Material Purchase Request</span></a>
                                </li>

                            </ul>
                        </li>

                        <li class="sidebar-header"></li>
                        <li><a href="#" title=""><span>Orders</span></a>
                            <ul>
                                <li><a class="get_pn" id="orderlist" onclick="order()">
                                    <i class="fa-solid fa-list-check" style="color: #0a6aa1"></i>
                                    <span>Order List</span></a></li>

                            </ul>
                        </li>

                        <li class="sidebar-header"></li>
                        <li><a href="#" title=""> <span>Warehouse</span></a>
                            <ul>
                                <li><a class="get_pn"
                                       id="warehouseorders" <%--onclick="warehouseorders()" href="#" title=""--%>>
                                    <i class="fa-solid fa-cart-shopping" style="color: #0a6aa1"></i>
                                    <span>Received Orders</span></a>
                                </li>

                                <li><a class="get_pn"
                                       id="warehouseStockList" <%--onclick="warehousestock()" href="#" title=""--%>>
                                    <i class="fa-solid fa-box-open" style="color: #0a6aa1"></i>
                                    <span>Warehouse Stock</span></a>
                                </li>

                                <li><a class="get_pn" id="inventoryProductionlist/warehouse"
                                    <%--onclick="inventory_production_warehouse()"--%> >
                                    <i class="bi bi-bag-fill" style="color: #0a6aa1"></i>
                                    <span>Production Request</span></a></li>

                                <li><a class="get_pn"
                                       id="requiredModules" <%--onclick="warehouseorders()" href="#" title=""--%>>
                                    <i class="fa-solid fa-cart-shopping" style="color: #0a6aa1"></i>
                                    <span>Required Modules</span></a>
                                </li>
                            </ul>
                        </li>

                        <%--<li class="sidebar-header"></li>
                        <li><a href="#" title=""> <span>Installer</span></a>
                            <ul>
                                <li><a id="installerlist" class="get_pn" &lt;%&ndash;onclick="installer()" title=""&ndash;%&gt;>
                                    <i class="fa-solid fa-people-group" style="color: #0a6aa1; font-size: 1.75em"></i>
                                    <span>Installer List</span></a></li>
                            </ul>
                        </li>--%>

                        <li class="sidebar-header"></li>
                        <li><a href="#" title=""><span>Employee</span></a>
                            <ul>
                                <li><a class="get_pn" id="employeelist" <%--href="#" onclick="employee()" title=""--%>>
                                    <i class="fa-solid fa-user-tie" style="color: #0a6aa1; font-size: 1.75em;"></i>
                                    <span>Employee List</span></a>
                                </li>
                            </ul>
                        </li>

                        <li class="sidebar-header"></li>
                        <li><a href="#" title=""><span>Procurement</span></a>
                            <ul>
                                <li><a class="get_pn" id="supplierlist" <%--href="#" onclick="supplier()" title=""--%>>
                                    <i class="fa-solid fa-users-line" style="color: #0a6aa1; font-size: 1.75em"></i>
                                    <span>Supplier</span></a>
                                </li>
                            </ul>
                        </li>

                    </c:if>

                    <c:if test="${level == '0' && isEmployeeLoggedIn.equals('true')}">
                        <li><a class="get_pn" id="dashboard"
                            <%-- title="" onclick="dashboard()"--%>><i class="fas fa-home" style="color: #0a6aa1"></i>
                            <span>Dashboard</span></a></li>

                        <li class="sidebar-header"></li>

                        <li><a class="get_pn" id="employeeOrdersList">
                            <i class="fa-solid fa-list-check" style="color: #0a6aa1"></i>
                            <span>Orders</span></a></li>

                    </c:if>

                    <c:if test="${level > '0' && isSalesEmployeeLoggedIn.equals('true')}">

                        <li><a class="get_pn" id="dashboard"
                            <%-- title="" onclick="dashboard()"--%>><i class="fas fa-home" style="color: #0a6aa1"></i>
                            <span>Dashboard</span></a></li>

                        <li class="sidebar-header"></li>

                        <li><a class="get_pn" id="clientList">
                            <i class="fa-solid fa-user-group"
                               style="color: #0a6aa1; "></i><span>Client List</span></a>
                        </li>
                        <li class="sidebar-header"></li>

                        <li><a href="#" title=""> <span>Leads</span></a>
                            <ul>

                                <li>
                                    <a class="get_pn" id="leads/digital" style="cursor: pointer">
                                        <i class="fa fa-bullhorn" style="color: #0a6aa1" aria-hidden="true"></i>
                                        <span>Digital Leads</span>
                                    </a>
                                </li>

                                <li>
                                    <a class="get_pn" id="leads/booked" style="cursor: pointer">
                                        <i class="fa fa-bullhorn" style="color: #0a6aa1" aria-hidden="true"></i>
                                        <span>Booked Leads</span>
                                    </a>
                                </li>

                                <li>
                                    <a class="get_pn" id="leads/self" style="cursor: pointer">
                                        <i class="fa fa-bullhorn" style="color: #0a6aa1" aria-hidden="true"></i>
                                        <span>Self Leads</span>
                                    </a>
                                </li>

                            </ul>
                        </li>

                        <li class="sidebar-header"></li>

                        <li><a class="get_pn" id="companyOrdersList">
                            <i class="fa-solid fa-list-check" style="color: #0a6aa1"></i>
                            <span>Orders</span></a></li>

                    </c:if>

                </ul>
            </nav>

        </aside>

        <div class="content-area">
            <div class="grid-stack gs-area text-center iframe-container">

                <iframe src="" id="myIframe" name="myIframe" onload="$('.theme-body').scrollTop(0)"></iframe>

            </div>
        </div><!-- Content Area -->

    </div><!-- Theme Content -->

</div><!-- Theme Wrapper -->

<div class="modal fade bd-example-modal-lg" id="models1" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel1">Notifications</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p id="clientID" style="color: black; cursor: pointer" onclick="clientclick()">
                    You have

                    <span id="clientCount"></span>

                    New Clients.
                </p>
                <p id="orderID" style="color: black; cursor: pointer" onclick="orderclick()">
                    You have
                    <span id="orderCount"></span>
                    New Orders.
                </p>
            </div>
        </div>
    </div>
</div>

<script>

    function clearCookies() {

        console.log("Inside clearCookies >> ");
        document.cookie.split(";").forEach(function(c) { document.cookie = c.replace(/^ +/, "").replace(/=.*/, "=;expires=" + new Date().toUTCString() + ";path=/"); });

        /*        cookieStore.getAll().then(cookies => cookies.forEach(cookie => {
            console.log('Cookie deleted:', cookie);
            console.log("-- processing --");
            cookieStore.delete(cookie.name);
        }));*/

        return new Promise(resolve => setTimeout(resolve, 1000));
    }

    async function logout() {

        await clearCookies();

        window.history.forward();

        window.location = '/home';

        /*  $.get("/logoutCheck", function (data) {

          if (data == "success") {

                window.location = '/';

               // location.reload();
            } else {

                alert(" Something went Wrong !!!!");

            }
        });*/
    }

    $(document).on("click", '.get_pn', function () {

        const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
        if (isMobile) {
            /* your code here */
            // alert("Mobile browser >>> ");
            document.getElementById("sidemenu").classList.remove("active");
        }
        else{
            // alert("PC browser >>> ");
        }

        let id = $(this).attr('id');

        var value = id.split("/");

        window.location.href = window.location.href.split('#')[0] + "#" + value[0];

        $("#myIframe").attr("src", "/" + id);

        if (value[1] == "warehouse") {

            window.location.href = window.location.href + "/" + "warehouse";

        }
        if (value[1] == "inventory") {

            window.location.href = window.location.href + "/" + "inventory";
        }

        if (value[1] == "digital") {

            window.location.href = window.location.href + "/" + "digital";

        }
        if (value[1] == "booked") {

            window.location.href = window.location.href + "/" + "booked";
        }
        if (value[1] == "self") {

            window.location.href = window.location.href + "/" + "self";

        }

    });

    function zoomOutMobile() {
        var viewport = document.querySelector('meta[name="viewport"]');

        if ( viewport ) {
            viewport.content = "initial-scale=0.1";
            viewport.content = "width=1200";
        }
    }


    $(document).ready(function () {

        const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
        if (isMobile) {
            /* your code here */

            // document.body.style.zoom=1.0;this.blur();

            document.getElementById("sidemenu").classList.remove("active");

            zoomOutMobile();
        }

        if (window.location.href != window.location.origin + "/") {

            // dashboard();

            // console.log(window.location.href.toString().indexOf("/home") !== -1); // true

            if (window.location.href.toString().indexOf("/home#") !== -1) {

                loadUrl(window.location.href.split('#')[1]);

            } else {

                dashboard();
            }
        } else {

            dashboard();
        }

    });


    var orderCount = 0;

    var clientCount = 0;

    function orderPopup() {

        if (count > 0) {

            if (clientCount == 0) {

                $("#clientID").attr("hidden", "hidden");
            } else {

                $("#clientID").removeAttr("hidden");
            }

            if (orderCount == 0) {

                $("#orderID").attr("hidden", "hidden");
            } else {

                $("#orderID").removeAttr("hidden");
            }

            $("#models1").modal('show');

        }

        document.getElementById("clientCount").innerHTML = clientCount;

        document.getElementById("orderCount").innerHTML = orderCount;
    }

    var count = 0;

    var clientNotification = 0;

    var orderNotification = 0;

    setInterval(function (e) {

        $.get("/getClientCount", function (data) {

            if (data > 0) {

                clientNotification = 1;

                clientCount = data;
            }
        });

        $.get("/getUpdateOrderCount", function (data) {

            if (data > 0) {

                orderNotification = 1;

                orderCount = data;
            }
        });

        count = clientNotification + orderNotification;

        $('#notification').each(function (index) {

            $(this).attr('data-count', count);
        });

    }, 10000);


</script>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>

<script src="/js/jquerymain_jquerytouch_jquerycookies.js"></script>
<script src="/js/plugins/loader/loadingoverlay.min.js"></script>
<script src="/js/plugins/scrollbar/jquery.mCustomScrollbar.concat.min.js"></script>
<!-- Bootstrap and Popper.js -->
<script src="/js/bootstrap_popper.min.js"></script>

<!-- Grid Stack Start -->
<script>var _tooltip = jQuery.fn.tooltip;</script>
<script src="/js/jquery_ui.min.js"></script>
<script>jQuery.fn.tooltip = _tooltip;</script>
<script src="/js/grid_stack_pack.min.js"></script>

<script src="/js/plugins/sparkline/jquery.sparkline.min.js"></script><!-- Sparkline -->
<script src="/js/plugins/chartjs/Chart.bundle.min.js"></script><!-- Chart JS -->
<script src="/js/plugins/colorpicker/bootstrap-colorpicker-plus.min.js"></script><!-- ColorPicker -->
<script src="/js/plugins/jquery_confirm/jquery_confirm.js"></script><!-- Confirm -->
<script src="/js/plugins/toaster/jquery.toaster.js"></script>
<script src="/js/script.js"></script><!-- Common Scripts -->

</body>
</html>