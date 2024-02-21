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

        #link:hover {
            font-weight: bold;
            color: blue;
            cursor: pointer;
        }

        #display_name {
            cursor: pointer;
        }
    </style>

    <script>
        var totalCount = 0;
    </script>

</head>
<body class="theme-body" style="overflow-x: auto">

<c:if test="${clientType.equals('lead') && level == '0'}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/leads'">Leads</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
    </h3>
</c:if>

<c:if test="${clientType.equals('lead') && level > '0'}">
    <h3 id="display_name">
        <span>Leads</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
    </h3>
    <br>

    <button type="button" id="btn" class="btn btn-success btn-sm"
            onclick="window.location='/addQuotation/${"add"}/${"null"}/${clientID}'">Add Quotation
    </button>
</c:if>

<c:if test="${clientType.equals('client') && level == '0'}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/clientList'">Client List</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
    </h3>
</c:if>

<c:if test="${clientType.equals('client') && level > '0'}">
    <h3 id="display_name">
        <span onclick="window.location='/clientList'">Client List</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
    </h3>
    <br>

    <button type="button" id="btn" class="btn btn-success btn-sm"
            onclick="window.location='/addQuotation/${"add"}/${"null"}/${clientID}'">Add Quotation
    </button>
</c:if>

<br><br>

<table id="example" class="table table-striped" style="width:100%">
    <thead>
    <tr>
        <th>Quotation No</th>
        <th>Extra discount</th>
        <th>Action</th>
        <th>Quotation</th>
        <th>Transactions</th>
        <c:if test="${clientType.equals('client')}">
            <th>Order</th>
        </c:if>
    </tr>
    </thead>
    <tbody>


    <c:forEach var="quotation" items="${quotationlist}" varStatus="counter">
        <tr>
            <td>
                    ${quotation.qNum}
                    <%-- <c:if test="${counter.index+1 < 10}">
                         0${counter.index+1}
                     </c:if>

                     <c:if test="${counter.index+1 > 9}">
                         ${counter.index+1}
                     </c:if>
     --%>
            </td>
            <td>${quotation.extraDiscount} %</td>
            <td>
                <c:forEach var="orderCompletedCheckObj" items="${orderCompletedCheck}">

                    <c:if test="${orderCompletedCheckObj.key == quotation.id}">
                    <button type="button" id="btn1" class="btn btn-success btn-sm ml-2"
                            <c:if test="${orderCompletedCheckObj.key == quotation.id && orderCompletedCheckObj.value == true}">disabled</c:if>
                            onclick="window.location='/addQuotation/${"edit"}/${quotation.id}/${clientID}'">Edit
                    </button>
                    </c:if>
                </c:forEach>
                <button type="button" id="btn2" class="btn btn-success btn-sm ml-2"
                        onclick="window.location='/quotationBOMlist/${quotation.qNum}/${quotation.id}'">
                    Products
                </button>
            </td>
            <td>
                <button type="button" class="btn btn-warning btn-sm ml-2"
                    <%--                        onclick="window.location='/generatequotation/${quotation.qNum}/${quotation.id}'"--%>
                        onclick="showAlert('${quotation.qNum}','${quotation.id}','${"generatequotation"}','${clientID}')"
                >GenerateQuotation
                </button>
            </td>

            <td>
                <button type="button5" class="btn btn-success btn-sm"
                        onclick="window.location='/transactionsList/${quotation.id}'">Transaction List
                </button>
            </td>

            <c:if test="${clientType.equals('client')}">
                <c:forEach var="orderAddedCheckObj" items="${orderAddedCheck}">

                    <c:if test="${orderAddedCheckObj.key == quotation.id}">

                        <td>
                            <button type="button" id="btn4" class="btn btn-success btn-sm btn-success"
                                    <c:if test="${orderAddedCheckObj.key == quotation.id && orderAddedCheckObj.value == true}">disabled</c:if>
                                <%--                                onclick="getProdcutsStatus('${quotation.id}')"--%>
                                    onclick="showAlert('${quotation.qNum}','${quotation.id}','${"addOrder"}','${clientID}')"
                                <%--                                onclick="showAlert('${"addOrder"}')"--%>
                                    title="Add Orders">Place Order
                            </button>
                        </td>
                    </c:if>
                </c:forEach>

            </c:if>

        </tr>
    </c:forEach>

    </tbody>

</table>

<script>

    function showAlert(quotationNo, QuotationId, value, clientID) {

        $.get("/checkProductsAddedinQuotation?name=" + QuotationId, function (data) {

            if (data == 'true') {

                if (value == 'addOrder') {

                    window.location.href = "/addOrder" + "/" + "add" + "/" + "null" + "/" + QuotationId + "/" + "quotation";

                }

                if (value == 'generatequotation') {

                    window.location.href = "/generatequotation" + "/" + quotationNo + "/" + QuotationId + "/" + clientID;

                }

            } else {

                alert("Please add Package/Products First");
            }

        });

    }

    function getProdcutsStatus(quotation_id) {

        $.get("/checkProductsAddedinQuotation?name=" + quotation_id, function (data) {

            if (data == 'true') {

                window.location.href = "/addOrder" + "/" + "add" + "/" + "null" + "/" + quotation_id + "/" + "quotation";
            } else {
                alert("Please add Package/Products First");
            }

        });

    }
</script>

<%--<c:choose>
    <c:when test="${clientType.equals('Business')}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/businessClient'">Business Client List</span>
        <span onclick="window.location='/quotation/${clientid}/${clientname}/${installerID}'"> > ${clientname}</span>
        </h3><br>
    </c:when>

    <c:otherwise>
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/clientlist/${"null"}/${"null"}'">Client List</span>
        <span onclick="window.location='/quotation/${clientid}/${clientname}/${installerID}'"> > ${clientname}</span>
    </h3><br>
    </c:otherwise>
</c:choose>



<button type="button" id="btn4" class="btn btn-success btn-sm" onclick="window.location='/addquotation/${"add"}/${"null"}'" >Add Quotation</button>
<br><br>

<table id="example" class="table table-striped" style="width:100%">
    <thead>
    <tr>
        <th>Quotation No</th>
        <th>Extra discount</th>
        <th>Action</th>
        <th>Quotation</th>
        <th>Order</th>
        <c:if test="${clientType.equals('Business')}">
            <th >Clients</th>
        </c:if>
        <th>Transactions</th>
    </tr>
    </thead>
    <tbody>


    <c:forEach var="quotation" items="${quotationlist}">
        <tr >
            <td>
                <script> totalCount=totalCount+1; </script>

                <script>
                    if (totalCount < 10){
                        document.write(String("0"+ totalCount));
                    }
                    else {
                        document.write(String(""+ totalCount));
                    }
                </script>
            </td>
            <td>${quotation.extraDiscount}%</td>
            <td>
                <button type="button" id="btn2" class="btn btn-success btn-sm ml-2" onclick="window.location='/addquotation/${"edit"}/${quotation.quotation_key}'">Edit</button>

                <button type="button" id="btn" class="btn btn-success btn-sm ml-2" onclick="window.location='/quotationBOMlist/${quotation.quotation_no}/${clientid}/${clientname}'">Products</button>
            </td>
            <td>
                <button type="button" id="btn1" class="btn btn-warning btn-sm ml-2" onclick="window.location='/generatequotation/${quotation.quotation_no}/${quotation.client_id}'">Generate Quotation</button>
            </td>

            <c:forEach var="a" items="${a}">

                <c:if test="${a.quotation_no==quotation.quotation_no}">

                    <c:set var="var1" value="${quotation.quotation_no}" scope="page"></c:set>

                </c:if>

            </c:forEach>
            <td>
                <button type="button" id="btn3" class="btn btn-success btn-sm btn-success" onclick="getProdcutsStatus('${quotation.client_id}','${quotation.quotation_no}','${clientid}','${clientname}','${installerID}')"

                     <c:if test="${var1==quotation.quotation_no}"> disabled</c:if>  title="Add Orders"

&lt;%&ndash;                        onclick="window.location='/addorder/${"add"}/${quotation.client_id}/${quotation.quotation_no}/${"quotation"}/${clientid}/${clientname}/${installerID}'" &ndash;%&gt;

                >Place Order</button>

&lt;%&ndash;                <i class="fa-solid fa-trash" style=" margin-left:auto;margin-top: auto; font-size: large; color: red;" onclick="delFunction('${quotation.client_id}','${quotation.quotation_no}')"></i>&ndash;%&gt;

                    &lt;%&ndash;                <button type="button" id="btn2" class="btn btn-danger btn-sm ml-2" onclick="delFunction('${quotation.client_id}','${quotation.quotation_no}')" >Delete Quotation</button>&ndash;%&gt;

            </td>
            <c:if test="${clientType.equals('Business')}">
            &lt;%&ndash;<td>
                <button type="button" class="btn btn-success btn-sm"
                        <c:if test="${var1 != quotation.quotation_no}"> disabled</c:if>
                        onclick="window.location='/addclient/${"add"}/${"businessClientofClients"}/${quotation.quotation_no}'">Add Client
                </button>

                <button type="button" id="btn6"
                        <c:if test="${var1 != quotation.quotation_no}"> disabled</c:if>
                        onclick="window.location='/clientlist/${"businessClientofClients"}/${quotation.quotation_no}'"
                        class="btn btn-success btn-sm btn-success" title="View Client"  >View Clients</button>
            </td>&ndash;%&gt;
                <td>
                    <button type="button" class="btn btn-success btn-sm"
                            <c:if test="${var1 != quotation.quotation_no}"> disabled</c:if>
                            onclick="window.location='/addBuilderClient/${"add"}/${"businessClientofClients"}/${quotation.quotation_no}/${clientid}/${clientname}/${installerID}/${"null"}'">Add Client
                    </button>

                    <button type="button" id="btn6"
                            <c:if test="${var1 != quotation.quotation_no}"> disabled</c:if>
                            onclick="window.location='/builderClientList/${"businessClientofClients"}/${clientid}/${clientname}/${installerID}/${quotation.quotation_no}'"
                            class="btn btn-success btn-sm btn-success" title="View Client"  >View Clients</button>
                </td>
            </c:if>
            <td>
                <button type="button" class="btn btn-success btn-sm"
                        <c:if test="${var1 != quotation.quotation_no}"> disabled</c:if>
                        onclick="window.location='/addTransaction/${"add"}/${"null"}/${quotation.quotation_no}'">Add Transaction
                </button>
            </td>

        </tr>
    </c:forEach>

    </tbody>

</table>

<script>
    function delFunction(clientID,quotationNo){

        if (confirm("Delete Quotation " + " ??") == true) {

            window.location.href = "/deletequotation" +"/"+ clientID + "/" + quotationNo;
        }
        else {

        }
    }

    function getProdcutsStatus(client_id,quotation_no,clientid,clientname,installerID) {

        $.get("/checkProductsAddedinQuotation?name="+ quotation_no, function (data) {

            if (data =='true'){

                window.location.href= "/addorder" + "/" + "add" +"/"+ client_id + "/" + quotation_no + "/" + "quotation" +"/"+ clientid + "/" + clientname + "/" +installerID;
            }
            else{
                alert("Please add Package/Products First");
            }

        });

    }
</script>

--%>

<script>$(document).ready(function () {

    $('#example').dataTable({
        "aLengthMenu": [25, 50, 75, 100],
        "pageLength": 100,
        "aoColumns": [
            {"sWidth": "15%"},
            {"sWidth": "15%"},
            {"sWidth": "20%"},
            {"sWidth": "20%"},
            {"sWidth": "15%"},
            <c:if test="${clientType.equals('client')}">
            {"sWidth": "15%"}</c:if>
        ]
    });

});

</script>


</body>
</html>
