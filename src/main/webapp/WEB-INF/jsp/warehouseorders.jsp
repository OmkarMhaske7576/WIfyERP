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

        table, th, tr {
            width: 100px;
            text-align: center;
        }

        tr {
            cursor: pointer;
        }

        #display_name {
            cursor: pointer;
        }

        .blink_me {
            animation-duration: 3000ms;
            animation-name: blink;
            animation-iteration-count: infinite;
            animation-direction: alternate;
            -webkit-animation: blink 1200ms infinite; /* Safari and Chrome */
        }

        @keyframes blink {
            from {
                color: red;
                font-weight: bold;
                font-size: medium;

            }
            to {
                color: red;
            }

        }

    </style>

</head>
<body class="theme-body" style="overflow-x: auto">

<h3 id="display_name">
    <span>Warehouse > </span>
    <span onclick="window.location='/warehouseorders'"> Received Orders</span>
</h3><br>

<table id="example" class="table table-striped" style="width:100%">
    <thead>
    <tr>
        <th>Client Name</th>
        <th>Order Date</th>
        <th>Estimates Date</th>
        <th>Payment Status</th>
        <th>Status</th>
        <th>Action</th>
        <th>Transactions</th>

    </tr>
    </thead>
    <tbody>

    <c:forEach var="orderObj" items="${orderlist}">
        <tr>
            <td>${orderObj.clientName}</td>
            <td>${orderObj.orderDate}</td>
            <td>${orderObj.estDate}</td>
            <td>${orderObj.payStatus}</td>
            <c:choose>
                <c:when test="${orderObj.status.equals('New')}">
                    <c:forEach var="hashmapObj" items="${hashmap}">

                        <c:if test="${hashmapObj.key == orderObj.id}">

                            <td
                                    <c:if test="${hashmapObj.value.equals('Stock unAvailable')}">class="blink_me"</c:if>> ${hashmapObj.value}</td>
                            <td>
                                <button type="button"
                                        <c:if test="${hashmapObj.value.equals('Stock unAvailable')}">disabled</c:if>
                                        class="btn btn-success btn-sm ml-2"
                                        onclick="window.location='/addOrder/${"edit"}/${orderObj.id}/${orderObj.quotationId}/${"warehouse"}'">
                                    Edit
                                </button>

                                <button type="button" id="btn2" class="btn btn-success btn-sm ml-2"
                                        onclick="window.location='/orderBOM/${orderObj.quotationId}/${orderObj.id}/${"warehouse"}'">
                                    Products
                                </button>
                            </td>

                        </c:if>

                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <td>${orderObj.status} </td>
                    <td>
                        <button type="button" class="btn btn-success btn-sm ml-2"
                                onclick="window.location='/addOrder/${"edit"}/${orderObj.id}/${orderObj.quotationId}/${"warehouse"}'">
                            Edit
                        </button>

                        <button type="button" class="btn btn-success btn-sm ml-2"
                                onclick="window.location='/orderBOM/${orderObj.quotationId}/${orderObj.id}/${"warehouse"}'">
                            Products
                        </button>
                    </td>
                </c:otherwise>
            </c:choose>

                <%--  <td>
                      <button type="button" disabled id="btn4" class="btn btn-success btn-sm ml-2"
                              onclick="window.location='/transactionsList/${orderObj.id}'">Transactions
                      </button>
                  </td>--%>

            <td>
                <button type="button" class="btn btn-success btn-sm"
                        onclick="window.location='/transactionsList/${orderObj.quotationId}'">Transaction List
                </button>
            </td>
        </tr>
    </c:forEach>

    </tbody>

</table>


<script>$(document).ready(function () {

    $('#example').DataTable({

        "aLengthMenu": [25, 50, 75, 100],

        "pageLength": 100,

        // "order": [[1, 'asc']],

        "order": [[4, 'desc']],

        "aoColumns": [
            {"sWidth": "20%"},
            {"sWidth": "11%"},
            {"sWidth": "10%"},
            {"sWidth": "10%"},
            {"sWidth": "22%"},
            {"sWidth": "18%"},
            {"sWidth": "9%"}
        ]

    });

    // $.get("/getWarehouseOrderStatus", function (data) {
    //
    //     for (var i = 0, keys = Object.keys(data), ii = keys.length; i < ii; i++) {
    //
    //         $("#post-" + keys[i]).text(data[keys[i]]);
    //
    //         // alert(i + " --> "+ keys[i] + " --> "+ data[keys[i]]);
    //
    //     }
    // });

    /*$.get("/getPaymentStatus",function (data) {

        alert("-------------------->");
        /!*for (var i = 0, keys = Object.keys(data), ii = keys.length; i < ii; i++) {

            $("#post-"+keys[i]).text(data[keys[i]]);

            // alert(i + " --> "+ keys[i] + " --> "+ data[keys[i]]);

        }*!/
    });*/
});


</script>

</body>
</html>
