<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
<head>

    <!-- CSS only For model box-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

    <!-- MDB -->
    <script
            type="text/javascript"
            src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.1.0/mdb.min.js"
    ></script>


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

    <!-- Font Awesome -->
    <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
            rel="stylesheet"
    />
    <!-- Google Fonts -->
    <link
            href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
            rel="stylesheet"
    />
    <!-- MDB -->
    <link
            href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.1.0/mdb.min.css"
            rel="stylesheet"
    />

    <style>

        table, th, tr {
            width: 100px;
            text-align: center;
        }

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
    <span>Warehouse ></span>
    <span onclick="window.location='/warehouseStockList'">Warehouse Stock</span>
    <span> > Edit Warehouse Stock</span>
</h3>

<ul class="nav nav-tabs mb-3" id="ex1" role="tablist">
    <li class="nav-item" role="presentation">
        <a class="nav-link active" id="ex1-tab-1" data-mdb-toggle="tab"
           href="#ex1-tabs-1" role="tab" aria-controls="ex1-tabs-1" aria-selected="true">
            Edit Form
        </a>
    </li>
    <li class="nav-item" role="presentation">
        <a class="nav-link" id="ex1-tab-2" data-mdb-toggle="tab"
           href="#ex1-tabs-2" role="tab" aria-controls="ex1-tabs-2" aria-selected="false">
            Stock Maintain list
        </a>
    </li>

</ul>

<!-- Tabs navs -->

<!-- Tabs content -->
<div class="tab-content" id="ex1-content">
    <div class="tab-pane fade show active" id="ex1-tabs-1" role="tabpanel" aria-labelledby="ex1-tab-1">
        <!-- Tabs content -->

        <form action="/updateInventoryProductsForm" method="get" id="form">

            <div class="center">

                <div class="form-group col-md-8" hidden>
                    <label for="id">Id</label>
                    <input type="text" name="id" readonly="true"
                           value="${WarehouseStock.id}" class="form-control" id="id" required>
                </div>

                <div class="form-group col-md-8">
                    <label for="productCode">Product Code </label>
                    <input type="text" name="productCode" readonly="true"
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

                <div class="form-group col-md-8">
                    <label for="price">Price per Product<span class="spanerror">*</span></label>
                    <input type="number"
                           onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                           oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                           maxlength="10"
                           readonly="readonly" value="${WarehouseStock.price}"
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

                <div class="form-group col-md-8">
                    <label for="category">Category<span class="spanerror">*</span></label>
                    <input type="text" name="category"
                           value="${WarehouseStock.category}" class="form-control" id="category" required>
                </div>

                <br><br>


                <button type="submit" class="btn btn-success btn-sm">update</button>


            </div>
        </form>

    </div>
    <div class="tab-pane fade" id="ex1-tabs-2" role="tabpanel" aria-labelledby="ex1-tab-2">

        <div class="text-center">
            <button href="" class="btn btn-outline-success btn-rounded mb-4" data-bs-toggle="modal"
                    data-bs-target="#modalRegisterForm">Add Stock
            </button>
        </div>

        <table id="example" class="table table-striped" style="width:100%">
            <thead>
            <tr>
                <th>Date</th>
                <th>Stock</th>
                <th>Comment</th>
            </tr>
            </thead>
            <tbody>

            <c:forEach var="manuallyAddedObj" items="${manuallyAdded}">
                <tr>
                    <td>${manuallyAddedObj.date}</td>
                    <td>${manuallyAddedObj.stocks}</td>
                    <td>${manuallyAddedObj.comment}</td>
                </tr>
            </c:forEach>

            </tbody>

        </table>

        <div class="modal fade" id="modalRegisterForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header text-center">
                        <h4 class="modal-title w-100 font-weight-bold">Add stock</h4>
                    </div>

                    <div class="modal-body mx-2">

                        <form action="/addSeprateStockForm" method="get" id="form1">

                            <div class="center">

                                <div class="form-group col-md-8">
                                    <label for="date">Stock Added Date<span
                                            class="spanerror">*</span></label>
                                    <input type="date" min="01-01-2023" required pattern="[0-9]{2}-[0-9]{2}-[0-9]{4}"
                                           name="date" <%--value="${order.estimated_date}"--%>
                                           class="form-control" id="date" required>
                                </div>

                                <div class="form-group col-md-8">
                                    <label for="stocks">Quantity <span class="spanerror">*</span></label>
                                    <input type="number" name="stocks"
                                           onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                                           oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                           maxlength="10"
                                           class="form-control" id="stocks" autocapitalize="sentences" min="0" required>
                                </div>

                                <div class="form-group col-md-8">
                                    <label for="comment">Comment </label>
                                    <input type="text" name="comment" class="form-control" id="comment" required>
                                </div>

                                <div class="form-group col-md-8">
                                    <label for="productsCode">Product Code </label>
                                    <input type="text" name="productsCode" readonly="true"
                                           value="${WarehouseStock.productCode}"
                                           class="form-control" id="productsCode" required>
                                </div>
                                <br>

                                <button type="submit" class="btn btn-primary btn-rounded btn-sm">Save</button>
                                <button data-bs-dismiss="modal" aria-hidden="true" onclick="close()"
                                        class="btn btn-danger btn-rounded btn-sm">Close
                                </button>

                            </div>
                        </form>

                    </div>

                </div>
            </div>
        </div>

    </div>

</div>

<script>
    function close() {

        alert("Hide");

        $('#modalRegisterForm').modal('hide');
    }


    $(document).ready(function () {

        $("#form").validate();

        $('#example').DataTable();

        document.getElementById('date').value = new Date().toISOString().substring(0, 10);

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