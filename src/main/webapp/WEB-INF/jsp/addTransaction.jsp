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

        .hidden-form {
            visibility: hidden;
        }

        .show-form {
            visibility: visible !important;
        }
    </style>

</head>
<body style="overflow-x: auto">
<br>

<c:if test="${clientType.equals('lead')}">
    <h3 id="display_name">
        <span >Leads</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/transactionsList/${quotationId}'" > > Quotation No: ${quotationNo}</span>
        <span> > ${type} Transaction</span>
    </h3>
</c:if>

<c:if test="${clientType.equals('client')}">
    <h3 id="display_name">
        <span onclick="window.location='/clientList'">Client List</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/transactionsList/${quotationId}'"> > Quotation No: ${quotationNo} </span>
        <span> > ${type} Transaction</span>
    </h3>
</c:if>

<c:if test="${type.equals('add')}">

<form action="/addTransactionForm" method="get" id="form" name="myForm">
    </c:if>

    <c:if test="${type.equals('edit')}">

            <form action="/updateTransactionForm" method="get" id="form">

    </c:if>

    <div class="center">

        <div class="form-group col-md-8" hidden>
            <label for="id">ID</label>
            <input type="text"
                   name="id" value="${transactionObj.id}" readonly="readonly" class="form-control"
                   id="id">
        </div>

        <div class="form-group col-md-8" hidden>
            <label for="quotationId">quotationId<span class="spanerror">*</span></label>
            <input type="text" autocomplete="off" name="quotationId"
                   <c:if test="${type.equals('add')}">value="${quotationId}"</c:if>
                   value="${transactionObj.quotationId}"
                   class="form-control" id="quotationId" required>
        </div>

        <div class="form-group col-md-8">
            <label for="payment_type">Payment Type<span class="spanerror">*</span></label>
            <select class="form-select required" name="payment_type" aria-label="Default select example"
            <%--onchange="getdetails(this)"--%>
                    id="payment_type">
                <option value="none" selected disabled hidden>Select Payment type</option>
                <option value="Advance" <c:if test="${transactionObj.payment_type =='Advance'}"> selected </c:if>>
                    Advance
                </option>
                <option value="Partial" <c:if test="${transactionObj.payment_type =='Partial'}"> selected </c:if>>
                    Partial
                </option>
                <option value="Full Payment" <c:if
                            test="${transactionObj.payment_type =='Full Payment'}"> selected </c:if>>
                    Full Payment
                </option>
            </select>
        </div>

        <div class="form-group col-md-8">
            <label for="payment_mode">Payment Mode<span class="spanerror">*</span></label>
            <select class="form-select required" name="payment_mode" aria-label="Default select example"
                    onchange="changeID(this)"
                    id="payment_mode">
                <option value="none" selected disabled hidden>Select Payment Mode</option>
                <option value="Cash" <c:if test="${transactionObj.payment_mode =='Cash'}"> selected </c:if>>
                    Cash
                </option>
                <option value="UPI"  <c:if test="${transactionObj.payment_mode =='UPI'}"> selected </c:if>>
                    UPI
                </option>
                <option value="RTGS"  <c:if test="${transactionObj.payment_mode =='RTGS'}"> selected </c:if>>
                    RTGS
                </option>
            </select>
        </div>

        <div class="form-group col-md-8">
            <label for="amount">Amount<span class="spanerror">*</span></label>
            <input type="number"
                   onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                   oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                   name="amount" value="${transactionObj.amount}" class="form-control"
                   id="amount"
                   maxlength="30" minlength="1" min="0" required>
        </div>

        <div class="form-group col-md-8" id="id7" hidden>
            <label for="transaction_id" id="id1"><span class="spanerror">*</span></label>
            <input type="text" autocomplete="off"
                   name="transaction_id" value="${transactionObj.transaction_id}"
                   class="form-control" id="transaction_id" required>
        </div>

        <div class="form-group col-md-8" hidden>
            <label for="transaction_date">Transaction Date </label>
            <input type="date" name="transaction_date" value="${transactionObj.transaction_date}"
                   class="form-control"
                   id="transaction_date" required>
        </div>

        <br><br>

        <c:if test="${type.equals('add')}">

            <button type="submit" class="btn btn-primary btn-sm">Save</button>
        </c:if>

        <c:if test="${type.equals('edit')}">

            <button type="submit" class="btn btn-success btn-sm">update</button>
        </c:if>
    </div>
</form>

<c:if test="${type.equals('add')}">
    <script>
        document.getElementById('transaction_date').value = new Date().toISOString().substring(0, 10);
    </script>
</c:if>


<script>

    $(document).ready(function () {

        $("#form").validate();

    });

    /*  window.onbeforeunload = function () {

          $.get("/notAddingInstaller" ,function () {});

      }*/

    function changeID(payment_mode) {

        var v = payment_mode.value;

        if (v == 'Cash') {

            document.getElementById('id1').innerHTML
                = 'Installer Name';

            $("#id7").removeAttr("hidden");

        } else {

            $("#id7").removeAttr("hidden");

            document.getElementById('id1').innerHTML
                = 'Transaction ID';
        }

    }

</script>

</body>
</html>