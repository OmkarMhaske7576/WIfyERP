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
<%--
<c:if test="${clientType.equals('lead')}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/leads'">Leads</span>
        <span onclick="window.location='/quotationList/${clientID}'" > > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${orderid}/${quotationID}'" > > Products</span>
        <span> > ${qoutationBOMAddType}</span>
    </h3>
</c:if>

<c:if test="${clientType.equals('client')}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/clientList'">Client List</span>
        <span onclick="window.location='/quotationList/${clientID}'" > > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${orderid}/${quotationID}'" > > Products</span>
        <span> > ${qoutationBOMAddType}</span>
    </h3>
</c:if>


--%>


<c:if test="${clientType.equals('lead') && level == '0'}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/leads'">Leads</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${orderid}/${quotationID}'"> > Quotation No: ${orderid}</span>
        <span> > ${qoutationBOMAddType}</span>
    </h3>
</c:if>

<c:if test="${clientType.equals('lead') && level > '0'}">
    <h3 id="display_name">
        <span onclick="window.location='/leads'">Leads</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${orderid}/${quotationID}'"> > Quotation No: ${orderid}</span>
        <span> > ${qoutationBOMAddType}</span>
    </h3>
</c:if>

<c:if test="${clientType.equals('client') && level == '0'}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/clientList'">Client List</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${orderid}/${quotationID}'"> > Quotation No: ${orderid}</span>
        <span> > ${qoutationBOMAddType}</span>
    </h3>
</c:if>

<c:if test="${clientType.equals('client') && level > '0'}">
    <h3 id="display_name">
        <span onclick="window.location='/clientList'">Client List</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${orderid}/${quotationID}'"> > Quotation No: ${orderid}</span>
        <span> > ${qoutationBOMAddType}</span>
    </h3>
</c:if>
<br>

<c:if test="${type.equals('add')}">

<form action="/addQuotationBOMForm/${name}" method="get" id="form" name="myForm">
    </c:if>

    <c:if test="${type.equals('edit')}">

    <form action="/updateQuotationBOMForm/${orderbom.id}" method="get" id="form">

        </c:if>

        <c:if test="${name.equals('addPackage')}">
            <div class="form-group col-md-8"><label for="package_name">Package Name <span
                    class="spanerror">*</span></label>
                <select class="form-select required" name="package_name" aria-label="Default select example"
                        id="package_name" required>
                    <option value="none" disabled selected hidden>Select Package Name</option>
                    <c:forEach var="packageList" items="${packageList}">
                        <option value="${packageList}">${packageList}</option>
                    </c:forEach>
                </select>
            </div>
        </c:if>

        <c:if test="${name.equals('addProduct') || name.equals('editProduct')}">
        <div class="center">
            <div class="form-group col-md-8"><label for="installer_id">Product name<span class="spanerror">*</span>
            </label>
                <select class="form-select required" name="pname" aria-label="Default select example" id="installer_id"
                        onchange="getid(this)">
                    <option value="none" disabled selected hidden>Select Product Name</option>
                    <c:forEach var="productlist" items="${productlist}">
                        <option value="${productlist}"
                                <c:if test="${orderbom.pname == productlist}"> selected </c:if> >${productlist}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="pcode">Product code <span class="spanerror">*</span></label>
                <input type="text" name="pcode" readonly="readonly" value="${orderbom.pcode}" class="form-control"
                       id="pcode" required>
            </div>

            <div class="form-group col-md-8">
                <label for="quantity">Quantity <span class="spanerror">*</span></label>
                <input type="number" name="quantity"
                       onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                       maxlength="5"
                       value="${orderbom.quantity}" class="form-control" id="quantity" min="0" required>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="price1">Price <span class="spanerror">*</span></label>
                <input type="number" name="price"
                       onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                       maxlength="8"
                       readonly="readonly" value="${orderbom.price}" class="form-control" id="price1" min="0" required>
            </div>

            </c:if>

            <div class="form-group col-md-8" hidden>
                <label for="quotationID">quotationID<span class="spanerror">*</span></label>
                <input type="text" name="quotationID"
                       <c:if test="${type.equals('add')}">value="${quotationID}"</c:if> readonly="readonly"
                       value="${orderbom.quotationID}" class="form-control"
                       id="quotationID" required>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="roomName">Room Name<span class="spanerror">*</span></label>
                <input type="text" name="roomName" readonly="readonly"
                       <c:if test="${type.equals('add')}">value=""</c:if> value="${orderbom.roomName}"
                       class="form-control"
                       id="roomName">
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

        });

    </script>

    <script type="text/javascript">

        function getid(selectObject) {

            var value = selectObject.value;

            if (value == "Undefined") {

                alert("value12345678: " + value);

                $('#pcode').val(value);
                $('#quantity').val(0);
                $('#price1').val(0);

            } else {

                $.get("/getqid?name=" + value, function (data) {

                    $('#pcode').val(data);

                });
                $.get("/getqprice?name=" + value, function (data) {

                    $('#price1').val(data);

                });
            }

        }

    </script>

</body>
</html>