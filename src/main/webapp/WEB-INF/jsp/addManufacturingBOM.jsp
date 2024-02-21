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
        .spanerror{
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
    <span>Manufacturing > </span>
    <span onclick="window.location='/getManufacturingBOM'">BOM</span>
    <span onclick="window.location='/productBOMlist/${productCode}'"> > ${productName}</span>
    <span> > ${type} product</span>
</h3>

<c:if test="${type.equals('add')}">

<form action="/addManufacturingBOMForm" method="get" id="form">

    </c:if>

    <c:if test="${type.equals('edit')}">

    <form action="/updateManufacturingBOMForm/${productBOM.id}/" method="get" id="form">

        </c:if>

        <div class="center">

            <div class="form-group col-md-8" hidden>
                <label for="id">ID<span class="spanerror">*</span></label>
                <input type="text" name="id" class="form-control" <c:if test="${type.equals('add')}">value="${size}"</c:if> value="${productBOM.id}" id="id" readonly="readonly" required>
            </div>

            <div class="form-group col-md-8">
                <label for="name">Raw material name<span class="spanerror">*</span></label>
                <select  class="form-select required" name="name"  aria-label="Default select example" onchange="getid(this)" id="name">
                    <option value="none" disabled selected hidden>Select Raw material</option>
                    <c:forEach var="item" items="${productsbomrawmaterial}">
                        <option value="${item}" <c:if test="${productBOM.name == item}"> selected </c:if>>${item} </option>
                    </c:forEach>

                </select>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="code">Item Code<span class="spanerror">*</span></label>
                <input type="text" name="code" class="form-control" value="${productBOM.code}" id="code" readonly="readonly" required>
            </div>

            <div class="form-group col-md-8">
                <label for="quantity">Quantity <span class="spanerror">*</span></label>
                <input type="text" name="quantity"
                       onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                       maxlength = "5"
                       value="${productBOM.quantity}" class="form-control" id="quantity" required>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="productCode">Product Code<span class="spanerror">*</span></label>
                <input type="text" name="productCode" class="form-control" <c:if test="${type.equals('add')}">value="${productCode}"</c:if> value="${productBOM.productCode}" id="productCode" readonly="readonly" required>
            </div>

            <br><br>

            <c:if test="${type.equals('add')}">

                <button type="submit" class="btn btn-primary btn-sm" >Save</button>
            </c:if>

            <c:if test="${type.equals('edit')}">
                <button type="submit" class="btn btn-success btn-sm"  >update</button>
            </c:if>

        </div>
    </form>

    <script>

        $(document).ready(function() {

            $("#form").validate();
        });

    </script>

<script type="text/javascript">

    function getid(selectObject) {

        var value = selectObject.value;

        $.get("/getitemid?name="+ value, function (data) {

            $('#code').val(data);

        });

    }

</script>

</body>
</html>