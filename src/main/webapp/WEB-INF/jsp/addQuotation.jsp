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

    <script src="https://code.jquery.com/jquery-migrate-3.0.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/dripicon.css"/>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
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

    </style>

</head>
<body id="body11" style="overflow-x: auto">

<br>

<c:if test="${clientType.equals('lead') && level == '0'}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/leads'">Leads</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span> > ${type} quotation</span>
    </h3>
</c:if>

<c:if test="${clientType.equals('lead') && level > '0'}">
    <h3 id="display_name">
        <span onclick="window.location='/leads'">Leads</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span> > ${type} quotation</span>
    </h3>
</c:if>

<c:if test="${clientType.equals('client') && level == '0'}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/clientList'">Client List</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span> > ${type} quotation</span>
    </h3>
</c:if>

<c:if test="${clientType.equals('client') && level > '0'}">
    <h3 id="display_name">
        <span onclick="window.location='/clientList'">Client List</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span> > ${type} quotation</span>
    </h3>
</c:if>

<c:if test="${type.equals('add')}">

<form action="/addQuotationForm" method="get" id="form" name="myForm">

    </c:if>

    <c:if test="${type.equals('edit')}">

    <form action="/updateQuotationForm/${quotation.id}" method="get" id="form">

        </c:if>

        <c:if test="${type.equals('add')}">

            <div class="form-group col-md-8"><label for="client_type">Order Type <span class="spanerror">*</span>
            </label>
                <select class="form-select required" onchange="displayfields(this)"
                        name="client_type" aria-label="Default select example" id="client_type">
                    <option value="none" selected disabled hidden>Select client type</option>
                    <option value="Individual"> Individual</option>
                    <option value="Business"> Bulk</option>
                </select>
            </div>

        </c:if>

        <div class="form-group col-md-8" hidden>
            <label for="id">Quotation ID<span class="spanerror">*</span></label>
            <input type="text" autocomplete="off" name="id"
                   value="${quotation.id}" style="text-transform:capitalize" class="form-control required"
                   id="id" autocapitalize="sentences">
        </div>

        <div class="form-group col-md-8">
            <label for="qNum">Quotation No<span class="spanerror">*</span></label>
            <input type="text" name="qNum"
                    <c:if test="${type.equals('edit')}">readonly="readonly"</c:if>
                   <c:if test="${type.equals('add')}">value="${quotation_No}"</c:if>
                   <c:if test="${type.equals('edit')}">value="${quotation.qNum}"</c:if>
                   class="form-control" id="qNum" required>
        </div>

        <div class="form-group col-md-8" hidden>
            <label for="clientId">Client ID <span class="spanerror">*</span></label>
            <input type="text" name="clientId"
                   <c:if test="${type.equals('add')}">value="${clientID}"</c:if> readonly="readonly"
                   value="${quotation.clientId}" class="form-control" id="clientId" required>
        </div>

        <div class="form-group col-md-8" id="id1" hidden>

            <label for="extraDiscount">Extra Discount</label>
            <input type='number'
                   onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                   oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                   maxlength="2" min="0"
                   <c:if test="${type.equals('edit')}">value="${quotation.extraDiscount}"</c:if> value="0"
                   name='extraDiscount' id="extraDiscount"/>

        </div>

        <div class="form-group col-md-8" id="id2" hidden
        <%-- <c:if test="${clientType.equals('Individual')}">hidden</c:if> --%>>

            <label for="orderQuantity">Order Quantity</label>
            <input type='number'
                   onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                   oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                   maxlength="10" min="1"
                   <c:if test="${type.equals('edit')}">value="${quotation.orderQuantity}"</c:if> value="1"
                   name='orderQuantity' id="orderQuantity"/>

        </div>

        <br>

        <c:if test="${type.equals('add')}">
            <button type="submit" class="btn btn-primary btn-sm">Save</button>
        </c:if>

        <c:if test="${type.equals('edit')}">
            <button type="submit" class="btn btn-success btn-sm">update</button>
        </c:if>

        </div>
    </form>

    <script>

        $(document).ready(function () {

            $("#form").validate();

            if (${type == 'edit'}) {

                $("#id1").removeAttr("hidden");

                $("#id2").removeAttr("hidden");
            }

        });

        function displayfields(field) {

            var val = field.value;

            if (val == 'Individual') {

                $("#id1").removeAttr("hidden");
            } else {

                $("#id1").removeAttr("hidden");

                $("#id2").removeAttr("hidden");
            }

        }

    </script>


    <%--<c:choose>
        <c:when test="${clientType.equals('Business')}">
            <h3 id="display_name">
                <span>Client > </span>
                <span onclick="window.location='/businessClient'">Business Client List</span>
                <span onclick="window.location='/quotation/${clientid}/${clientname}/${installerid}'"> > ${clientname}</span>
                <span> > ${type} Quotation</span>
            </h3><br>
        </c:when>
        <c:otherwise>
            <h3 id="display_name">
                <span>Client > </span>
                <span onclick="window.location='/clientlist/${"null"}/${"null"}'">Client List</span>
                <span onclick="window.location='/quotation/${clientid}/${clientname}/${installerid}'"> > ${clientname}</span>
                <span> > ${type} Quotation</span>
            </h3><br>
        </c:otherwise>
    </c:choose>--%>

    <%--
    <c:if test="${type.equals('add')}">

    <form action="/addQuotationForm" method="get" id="form" name="myForm">

        </c:if>

        <c:if test="${type.equals('edit')}">

        <form action="/updateQuotationForm/${quotation.quotation_key}" method="get" id="form">

            </c:if>

            <c:if test="${type.equals('add')}">

                <div class="form-group col-md-8"><label for="client_type">Order Type <span class="spanerror">*</span>
                </label>
                    <select class="form-select required" onchange="displayfields(this)"
                            name="client_type" aria-label="Default select example" id="client_type">
                        <option value="none" selected disabled hidden>Select client type</option>
                        <option value="Individual"> Individual</option>
                        <option value="Business"> Bulk</option>
                    </select>
                </div>

            </c:if>

            <div class="form-group col-md-8">
                <label for="quotation_no">Quotation No<span class="spanerror">*</span></label>
                <input type="text" name="quotation_no"
                       <c:if test="${type.equals('add')}">value="${quotation_No}"</c:if>
                       <c:if test="${type.equals('edit')}">value="${quotation.quotation_no}"</c:if>
                        class="form-control" id="quotation_no" required>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="client_id">Client ID <span class="spanerror">*</span></label>
                <input type="text" name="client_id"
                       <c:if test="${type.equals('add')}">value="${clientid}"</c:if> readonly="readonly"
                       value="${quotation.client_id}" class="form-control" id="client_id" required>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="cname">Client name <span class="spanerror">*</span></label>
                <input type="text" autocomplete="off" name="client_name"
                       <c:if test="${type.equals('add')}">value="${clientname}"</c:if>
                       value="${quotation.client_name}" style="text-transform:capitalize" class="form-control required"
                       id="cname" autocapitalize="sentences">
            </div>

            <div class="form-group col-md-8" id="id1" hidden>

                <label for="extraDiscount">Extra Discount</label>
                <input type='number'
                       onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                       maxlength="2" min="0"
                       <c:if test="${type.equals('edit')}">value="${quotation.extraDiscount}"</c:if> value="0"
                       name='extraDiscount' id="extraDiscount"/>

            </div>

            <div class="form-group col-md-8" id="id2" hidden
                 <c:if test="${clientType.equals('Individual')}">hidden</c:if> >

                <label for="orderQuantity">Order Quantity</label>
                <input type='number'
                       onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                       maxlength="10" min="1"
                       <c:if test="${type.equals('edit')}">value="${quotation.orderQuantity}"</c:if> value="1"
                       name='orderQuantity' id="orderQuantity"/>

            </div>

            <br>

            <c:if test="${type.equals('add')}">
                <button type="submit" class="btn btn-primary btn-sm">Save</button>
            </c:if>

            <c:if test="${type.equals('edit')}">
                <button type="submit" class="btn btn-success btn-sm">update</button>
            </c:if>

            </div>
        </form>

        <script>

            $(document).ready(function () {

                $("#form").validate();

                if (${type == 'edit'}) {

                    $("#id1").removeAttr("hidden");

                    $("#id2").removeAttr("hidden");
                }

            });

            function displayfields(field) {

                var val = field.value;

                if (val == 'Individual') {

                    $("#id1").removeAttr("hidden");
                } else {

                    $("#id1").removeAttr("hidden");

                    $("#id2").removeAttr("hidden");
                }

            }

        </script>
    --%>

</body>
</html>