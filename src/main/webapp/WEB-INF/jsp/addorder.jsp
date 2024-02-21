<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
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
    <link rel="stylesheet" href="js/plugins/datepicker/datepicker.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/dripicon.css"/>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>

    <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
    <%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js"></script>--%>
    <script src="/js/validate.js"></script>

    <link rel="stylesheet" type="text/css" href="/css/responsive.css"/>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.4/jquery.validate.min.js"></script>

    <title>Document</title>

    <style>
        .currencyinput {
            border: 1px inset #ccc;
        }

        .spanerror {
            color: red;
        }

        input {
            border-radius: 5px;
            border: 1px solid #ccc;
            padding: 4px;
            font-family: 'Lato';
            width: 300px;
            margin-top: 10px;
        }

        label {
            width: 300px;
            font-weight: bold;
            display: inline-block;
            margin-top: 20px;
        }

        label span {
            font-size: 1rem;
        }

        label.error {
            color: red;
            font-size: 1rem;
            display: block;
            margin-top: 5px;
        }

        input.error {
            border: 1px solid red;
            font-weight: 300;
            color: red;
        }

        [type="submit"], [type="reset"], button, html [type="button"] {
            margin-left: 0;
            border-radius: 0;
            border: none;
            font-weight: 300;
            padding: 10px 0;
            line-height: 1;
        }

        form {

            padding: 10px 10px 10px 10px;
        }

        #display_name {
            cursor: pointer;
        }


    </style>
</head>
<body style="overflow-x: auto">

<br>
<h3 id="display_name">

    <c:if test="${value.equals('quotation')}">
        <span>Client > </span>
        <span onclick="window.location='/clientList'">Client List</span>
        <span onclick="window.location='/quotationList/${client_id}'"> > ${clientname}</span>
        <span> > Place Order</span>
    </c:if>

    <c:if test="${value.equals('warehouse')}">
        <span>Warehouse > </span>
        <span onclick="window.location='/warehouseorders'">Received Orders</span>
        <span> > ${type} Order</span>
    </c:if>

    <c:if test="${value.equals('order')}">
        <span>Orders > </span>
        <span onclick="window.location='/orderlist'">Order List</span>
        <span> > ${type} Order</span>
    </c:if>

</h3>

<c:if test="${type.equals('add')}">

<form action="/addOrderForm" method="get" id="form">

    </c:if>

    <c:if test="${type.equals('edit')}">

    <form action="/updateOrderForm/${order.id}/${value}" method="get" id="form">

        </c:if>
        <%--        <c:if test="${type.equals('editwarehouserorder')}">--%>

        <%--        <form action="/updatewarehouseorder/${order.order_key}/${order.order_status}" method="get" id="form">--%>

        <%--            </c:if>--%>

        <div class="center">

            <div class="form-group col-md-8" hidden>
                <label for="id">Order Id</label>
                <input type="text"
                       name="id" <%--<c:if test="${type.equals('add')}">value="${count}"</c:if>--%>
                       readonly="readonly" value="${order.id}" class="form-control" id="id">
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="clientId">Client ID <span class="spanerror">*</span></label>
                <input type="text" name="clientId"
                       <c:if test="${type.equals('add')}">value="${client_id}"</c:if>
                       <c:if test="${type.equals('edit')}">value="${order.clientId}"</c:if>
                <%--                           <c:if test="${type.equals('editwarehouserorder')}">value="${order.client_name}"</c:if>--%>
                       readonly="readonly" class="form-control" id="clientId" required>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="clientName">Client Name <span class="spanerror">*</span></label>
                <input type="text" name="clientName"
                       <c:if test="${type.equals('add')}">value="${clientname}"</c:if>
                       <c:if test="${type.equals('edit')}">value="${order.clientName}"</c:if>
                       readonly="readonly" class="form-control" id="clientName" required>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="quotationId">Quotation Id <span class="spanerror">*</span></label>
                <input type="text" name="quotationId"
                       <c:if test="${type.equals('edit')}">value="${order.quotationId}"</c:if>
                       readonly="readonly"
                       <c:if test="${type.equals('add')}">value="${quotationnumber}"</c:if> class="form-control"
                       id="quotationId" required>
            </div>

            <%--            <c:if test="${order.status =='Ready to install'}">--%>


            <%--            </c:if>--%>

            <div class="form-group col-md-8" <c:if test="${type.equals('add')}">hidden </c:if>>
                <label for="status">Status<span class="spanerror">*</span> </label>
                <select class="form-select required" name="status"
                        onchange="changeShipmentDate(this)" aria-label="Default select example" id="status">

                    <option disabled selected value="none" hidden>Select Status</option>
                    <option value="New"
                            <c:if test="${order.status =='New'}"> selected </c:if>
                            hidden>New
                    </option>

                    <%--                    <option value="Confirm"  <c:if test="${order.status =='Confirm'}"> selected </c:if>>Confirm</option>--%>
                    <option value="Preparing"
                            <c:if test="${order.status =='Preparing'}"> selected </c:if>
                            <c:if test="${value.equals('order')}">hidden</c:if>
                            <c:if test="${order.status =='Ready to install' || order.status == 'Shipped'}">hidden</c:if>
                    <%--                                <c:if test="${statusChange.equals('Stock Not Available')}">hidden</c:if>--%>
                    >Preparing
                    </option>

                    <%--                        <c:if test="${value.equals('warehouse')}">--%>

                    <option value="Ready to install"
                            <c:if test="${order.status =='Ready to install'}"> selected </c:if>
                            <c:if test="${value.equals('order')}">hidden</c:if>
                            <c:if test="${order.status =='New' || order.status == 'Shipped'}">hidden</c:if>
                    >Ready to install
                    </option>
                    <%--                        </c:if>--%>

                    <%--                        <c:if test="${order.status =='Ready to install'}">--%>

                    <option value="Shipped" onkeyup="changeShipmentDate()"
                            <c:if test="${order.status =='Shipped'}"> selected </c:if>
                            <c:if test="${value.equals('order')}">hidden</c:if>
                            <c:if test="${order.status =='New' || order.status == 'Preparing'}">hidden</c:if>
                    <%--                                <c:if test="${statusChange.equals('Stock Not Available')}">hidden</c:if>--%>

                    >Shipped
                    </option>
                    <%--                        </c:if>--%>

                    <option value="Completed"
                            <c:if test="${order.status =='Completed'}"> selected </c:if>
                            <c:if test="${order.status =='New' || order.status == 'Preparing' || order.status =='Ready to install' || order.status =='Cancelled'}">hidden</c:if>
                    <%--                                <c:if test="${value.equals('order')}">hidden</c:if>--%>
                            <c:if test="${value.equals('warehouse')}">hidden</c:if>
                    >Completed
                    </option>

                    <option value="Cancelled"
                            <c:if test="${order.status =='Completed'}"> hidden </c:if>
                            <c:if test="${order.status =='Cancelled'}"> selected </c:if>
                            <c:if test="${value.equals('warehouse')}">hidden</c:if>
                    >Cancelled
                    </option>

                    <option value="Pending" hidden
                            <c:if test="${order.status =='Pending'}"> selected </c:if>>Pending
                    </option>

                </select>
            </div>

            <div class="form-group col-md-8" id="id3" hidden
                 <c:if test="${value.equals('order')}">hidden</c:if> >
                <label for="installerName">Installer name<span class="spanerror">*</span> </label>
                <select class="form-select required" name="installerName"
                        aria-label="Default select example" onchange="getEmpID(this)"
                        id="installerName">
                    <option value="none" disabled selected hidden>Select Installer name</option>
                    <c:forEach var="employeeObj" items="${employeeList}">
                        <option  <c:if test="${employeeObj ==order.installerName}"> selected </c:if>
                                value="${employeeObj}">${employeeObj} </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group col-md-8"
                 <c:if test="${value.equals('order')}">hidden</c:if> hidden>
                <label for="installerID">Installer Id <span class="spanerror">*</span></label>
                <input type="text" name="installerID"
                       <c:if test="${type.equals('add')}">value=""</c:if>
                       value="${order.installerID}"
                       readonly="readonly" class="form-control"
                       id="installerID" required>
            </div>

          <%--  <div class="form-group col-md-8"
                 <c:if test="${type.equals('edit')}">hidden</c:if> >
                <label for="salesEmpName">Sales Employee Name<span class="spanerror">*</span> </label>
                <select class="form-select required" name="salesEmpName"
                        aria-label="Default select example" onchange="getSalesEmpID(this)"
                        id="salesEmpName">
                    <option value="none" disabled selected hidden>Select Employee name</option>
                    <c:forEach var="employeeObj" items="${salesEmployeeList}">
                        <option  &lt;%&ndash;<c:if test="${employeeObj.name ==order.installerName}"> selected </c:if>&ndash;%&gt;
                                value="${employeeObj.name}">${employeeObj.name} </option>
                    </c:forEach>
                </select>
            </div>--%>

            <div class="form-group col-md-8" hidden>
                <label for="salesEmpID">Sales Employee Id <span class="spanerror">*</span></label>
                <input type="text" name="salesEmpID"
                       <c:if test="${type.equals('add')}">value="${empID}"</c:if>
                       value="${order.salesEmpID}"
                       readonly="readonly" class="form-control"
                       id="salesEmpID" required>
            </div>

            <div class="form-group col-md-8">
                <label for="estDate">Estimated Date <span class="spanerror">*</span></label>
                <input type="date" min="01-01-2022" required pattern="[0-9]{2}-[0-9]{2}-[0-9]{4}"
                       name="estDate" value="${order.estDate}" class="form-control"
                       id="estDate" required>
            </div>

            <div class="form-group col-md-8"
                 <c:if test="${type.equals('add') || value.equals('order')}">hidden="hidden" </c:if>
                 <c:if test="${order.status !='Shipped'}">hidden </c:if> >
                <label for="shipDate">Shipment Date </label>
                <input type="date" name="shipDate"
                       <c:if test="${type.equals('add')}">value="2099-01-01"</c:if>
                       value="${order.shipDate}" class="form-control" id="shipDate" required>
            </div>

            <div class="form-group col-md-8"
            <%--<c:if test="${type.equals('editwarehouserorder')}">hidden="hidden" </c:if>--%>>
                <label for="warrPeriod">Warranty Period<span class="spanerror">*</span></label>
                <select class="form-select required" name="warrPeriod" aria-label="Default select example"
                        id="warrPeriod">

                    <option disabled selected value="none" hidden>Select Warranty Period</option>
                    <option value="1 Year" <c:if test="${order.warrPeriod =='1 Year'}"> selected </c:if>>1
                        Year
                    </option>
                    <option value="2 Year" <c:if test="${order.warrPeriod =='2 Year'}"> selected </c:if>>2
                        Year
                    </option>
                    <option value="3 Year" <c:if test="${order.warrPeriod =='3 Year'}"> selected </c:if>>3
                        Year
                    </option>
                    <option value="4 Year" <c:if test="${order.warrPeriod =='4 Year'}"> selected </c:if>>4
                        Year
                    </option>
                    <option value="5 Year" <c:if test="${order.warrPeriod =='5 Year'}"> selected </c:if>>5
                        Year
                    </option>
                </select>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="orderDate">Order Date</label>
                <input type="date" name="orderDate" value="${order.orderDate}" class="form-control" readonly="readonly"
                       id="orderDate" required>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="payStatus">Payment Status</label>
                <select class="form-select" name="payStatus" aria-label="Default select example"
                        id="payStatus">
                    <option value="none" selected disabled hidden>Select Payment Status</option>
                    <option value="Paid" <c:if test="${order.payStatus =='Paid'}"> selected </c:if>>
                        Paid
                    </option>
                    <option value="Unpaid"
                            <c:if test="${type.equals('add')}">selected</c:if>
                            <c:if test="${order.payStatus =='Unpaid'}"> selected </c:if>>
                        Unpaid
                    </option>
                </select>
            </div>

            <%--                <c:if test="${order.status =='Ready to install'}">--%>

            <div class="form-group col-md-8" id="id1"
                 <c:if test="${type.equals('add')}">hidden</c:if> hidden>
                <label for="transType">Transport Type<span class="spanerror">*</span></label>
                <select class="form-select required" name="transType" aria-label="Default select example"
                                            onchange="getCourier(this)"
                        id="transType">
                    <option value="" selected disabled hidden>Select Transport type</option>
                    <option value="By Courier" <c:if
                            test="${order.transType =='By Courier'}"> selected </c:if>>
                        By Courier
                    </option>
                    <option value="By Self" <c:if test="${order.transType =='By Self'}"> selected </c:if>>
                        By Self
                    </option>
                </select>
            </div>

            <div class="form-group col-md-8" id="name" hidden
                 <c:if test="${type.equals('add')}">hidden</c:if> hidden>
                <label for="courierName" id="label">Courier Name<span class="spanerror">*</span></label>
                <input type="text" autocomplete="off" name="courierName" value="${order.courierName}"
                       class="form-control" id="courierName" required>
            </div>

            <div class="form-group col-md-8" id="id2"
                 <c:if test="${type.equals('add')}">hidden</c:if> hidden>
                <label for="trackingNo">Tracking No<span class="spanerror">*</span></label>
                <input type="text" autocomplete="off" name="trackingNo" value="${order.trackingNo}"
                       class="form-control" id="trackingNo" required>
            </div>

            <%--                </c:if>--%>

            <div class="form-group col-md-8" hidden>
                <label for="companyID">Company ID</label>
                <input type="text"
                       name="companyID" <%--<c:if test="${type.equals('add')}">value="${count}"</c:if>--%>
                       readonly="readonly" value="${order.companyID}" class="form-control" id="companyID">
            </div>

            <div class="form-group col-md-8" hidden id="hostHidden">
                <label for="host">Host No</label>
                <input type="text" name="host" maxlength="10"
                value="${order.host}" class="form-control" id="host">
            </div>

            <div class="form-group col-md-8">
                <label for="comment">Comments</label>
                <input type="text" name="comment" value="${order.comment}"
                       class="form-control" autocomplete="off" id="comment">
            </div>

            <br><br>

            <c:if test="${type.equals('add')}">

                <button type="submit" class="btn btn-primary btn-sm">Save</button>
            </c:if>

            <c:if test="${type.equals('edit')}">
                <button type="submit" class="btn btn-success btn-sm">update</button>
            </c:if>

            <%--                <c:if test="${type.equals('editwarehouserorder')}">--%>
            <%--                    <button type="submit" class="btn btn-success btn-sm">update Warehouse order</button>--%>
            <%--                </c:if>--%>

        </div>
    </form>

    <c:if test="${type.equals('add')}">
    <script>
        document.getElementById('orderDate').value = new Date().toISOString().substring(0, 10);
    </script>
    </c:if>

    <script>

        $(document).ready(function () {

            $("#form").validate();

            if (${order.status =='Ready to install' || order.status =='Shipped' || order.status =='Completed'}){

                $("#id3").removeAttr("hidden");
            }
        });

        function getEmpID(subject) {

            var v = subject.value;

            $.get("/getEmployeeID?name=" + v, function (data) {

                // alert("Employee ID >> "+ data)

                $("#installerID").val(data);

            });

        }

      /*  function getSalesEmpID(subject) {

            var v = subject.value;

            $.get("/getSalesEmployeeID?name=" + v, function (data) {

                // alert("Employee ID >> "+ data)

                $("#salesEmpID").val(data);

            });

        }*/



    </script>
    <script type="text/javascript">

        function changeShipmentDate(subject) {

            var v = subject.value;

            if (v === "Shipped") {

                $("#id1").removeAttr("hidden");

                $("#name").removeAttr("hidden");

                $("#id2").removeAttr("hidden");

                document.getElementById('shipDate').value = new Date().toISOString().substring(0, 10);
            }
            if (v == "Ready to install") {

                $("#id3").removeAttr("hidden");
            }

            if (v == "Completed") {

                $("#hostHidden").removeAttr("hidden");
            }
        }

        function getCourier(courier) {

            var c = courier.value;

            if (c == 'By Self') {

                // document.getElementById('label').innerHTML
                //     = 'Installer Name';

                // $("#name").addAttr("hidden");

                $("#name").attr("hidden", "hidden");

                $("#id2").attr("hidden", "hidden");

                // $("#trackingNo").val("null");

               /* $.get("/getInstallerNameinOrder?name=" + installerID, function (data) {

                    $("#courierName").val(data);

                });*/
            } else {

                $("#name").removeAttr("hidden");

                document.getElementById('label').innerHTML
                    = 'Courier Name';
            }

        }

    </script>

    <script>
        $(document).ready(function () {

            $.fn.dataTable.moment('DD/MM/YYYY');

            // $('#estDate').DataTable();
        });

        /*window.onbeforeunload = function () {

            $.get("/notAddingOrder" ,function () {});

        }*/

    </script>

</body>
</html>