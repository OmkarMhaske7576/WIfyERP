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

    <%--    <link rel="stylesheet" href="js/plugins/datepicker/datepicker.css">--%>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <%--    <script src="https://code.jquery.com/jquery-migrate-3.0.0.min.js"></script>--%>
    <link rel="stylesheet" type="text/css" href="/css/dripicon.css"/>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
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
            width: 300px;
            font-family: "Times New Roman";
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

        input[type="text"] {

            font-size: 16px;

        }

        #display_name {
            cursor: pointer;
        }

    </style>

</head>
<body style="overflow-x: auto">

<br>
<c:if test="${category.equals('Product')}">
<h3 id="display_name">
    <span>Inventory ></span>
    <span onclick="window.location='/inventory_item_productList'">Product List</span>
    <span> > ${type} Inventory Product</span>
</h3>
</c:if>

<c:if test="${category.equals('Raw')}">
    <h3 id="display_name">
        <span>Inventory ></span>
        <span onclick="window.location='/inventory_item_rawMaterialList'">Raw Material List</span>
        <span> > ${type} Inventory Raw Product</span>
    </h3>
</c:if>

<c:if test="${type.equals('add')}">

<form action="/addInventoryProductsForm" method="get" id="form">

    </c:if>

    <c:if test="${type.equals('edit')}">

    <form action="/updateInventoryProductsForm/${category}" method="get" id="form">

        </c:if>

        <div class="center">

            <div class="form-group col-md-8" hidden>
                <label for="id">Id</label>
                <input type="text" name="id"
                       <c:if test="${type.equals('add')}">value="${size}" </c:if> readonly="true"
                       value="${WarehouseStock.id}" class="form-control" id="id" required>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="productCode">Product Code </label>
                <input type="text" name="productCode"
                       <c:if test="${type.equals('add')}">value="${productCode}" </c:if> readonly="true"
                       value="${WarehouseStock.productCode}" class="form-control" id="productCode" required>
            </div>

            <div class="form-group col-md-8">
                <label for="name">Product name <span class="spanerror">*</span></label>
                <input type="text" name="name"
                       value="${WarehouseStock.name}" class="form-control" id="name" required>
            </div>

            <div class="form-group col-md-8">
                <label for="stock">Quantity <span class="spanerror">*</span></label>
                <input type="number" name="stock"
                       onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                       maxlength="10"
                       value="${WarehouseStock.stock}"
                       class="form-control" id="stock" autocapitalize="sentences" min="0" required>
            </div>

            <div class="form-group col-md-8"<c:if test="${category.equals('Product')}">hidden</c:if> >
                <label for="price">Price per Product<span class="spanerror">*</span></label>
                <input type="number" step="0.01"
                     <%--  onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                      --%> maxlength="10"
                       <c:if test="${type.equals('add') && category.equals('Product')}">value="0" readonly="readonly"</c:if>
                        <c:choose>
                            <c:when test="${type.equals('edit') && WarehouseStock.category.equals('Product') && !category.equals('Finance')}">
                                value="${WarehouseStock.price}" readonly="readonly"
                            </c:when>
                            <c:when test="${type.equals('edit') && category.equals('Finance')}">
                                value="${WarehouseStock.price}"
                            </c:when>

                            <c:otherwise>
                                value="${WarehouseStock.price}"
                            </c:otherwise>
                        </c:choose>
                       name="price" class="form-control" id="price" required>

            </div>

            <div class="form-group col-md-8">
                <label for="stockAlert">Stock Alert <span class="spanerror">*</span></label>
                <input type="number" name="stockAlert"
                       onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                       maxlength="10"
                       value="${WarehouseStock.stockAlert}" class="form-control" id="stockAlert"
                       autocapitalize="sentences" min="0" required>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="category">Category<span class="spanerror">*</span></label>
                <input type="text" name="category"
                       <c:if test="${type.equals('add')}">value="${category}"</c:if>
                       value="${WarehouseStock.category}" class="form-control" id="category" required>
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

    <script>
        function close() {

            alert("Hide");

            $('#modalRegisterForm').modal('hide');
        }


        $(document).ready(function () {

            $("#form").validate();

            $('#example').DataTable();

        });
    </script>

    <!-- JavaScript Bundle with Popper for model box -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
            crossorigin="anonymous"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"
            integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ=="
            crossorigin="anonymous"></script>

</body>
</html>