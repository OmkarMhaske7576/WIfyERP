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

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.4/jquery.validate.min.js"></script>

    <link rel="stylesheet" type="text/css" href="/css/responsive.css"/>
    <title>Document</title>

    <style>
        .currencyinput {
            border: 1px inset #ccc;
        }
        .col-md-4,.col-md-12,.col-md-5,.col-md-11{
            border: 2px solid black;
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

<c:if test="${category.equals('Product') && value.equals('inventory')}">
<h3 id="display_name">
    <span>Inventory > </span>
    <span onclick="window.location='/inventoryProductionlist/${value}'">Production Request</span>
    <span> > ${type} Production request </span>
</h3>
</c:if>

<c:if test="${category.equals('Raw')}">
    <h3 id="display_name">
        <span>Inventory > </span>
        <span onclick="window.location='/rawRequestProductionList'">Raw Material Purchase Request</span>
        <span> > ${type} Raw Production request </span>
    </h3>
</c:if>

<c:if test="${value.equals('warehouse') }">
    <h3 id="display_name">
        <span>Warehouse > </span>
        <span onclick="window.location='/inventoryProductionlist/${value}'">Production Request</span>
        <span> > ${type} Production request </span>
    </h3>
</c:if>

<c:if test="${type.equals('add')}">

<form action="/addInventoryProductionForm/${typeValue}" method="get" id="form">

    </c:if>

    <c:if test="${type.equals('edit')}">

    <form action="/updateInventoryProductionForm/${iproduction.request}/${typeValue}" method="get" id="form">

        </c:if>

        <div class="center">

            <div class="form-group col-md-8" hidden>
                <label for="id">ID<span class="spanerror">*</span></label>
                <input type="text" name="id"
                       <c:if test="${type.equals('add')}">value="${id}"</c:if>
                       value="${iproduction.id}"
                       readonly="readonly" class="form-control" id="id" required>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="request">Request No<span class="spanerror">*</span></label>
                <input type="text" name="request"
                       <c:if test="${type.equals('add')}">value="${size}"</c:if>
                       value="${iproduction.request}"
                       readonly="readonly" class="form-control" id="request" required>
            </div>

            <div class="form-group col-md-8">
                <label for="name">Product Name<span class="spanerror">*</span> </label>
                <select  class="form-select required" name="name"  aria-label="Default select example" onchange="getid(this)" id="name">
                    <option value="none" disabled selected hidden>Select Product name</option>
                    <c:forEach var="item" items="${productsbommaterial}">
                        <option value="${item}" <c:if test="${iproduction.name == item}"> selected </c:if> >${item}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="code">Product code <span class="spanerror">*</span></label>
                <input type="text" name="code" readonly="readonly" value="${iproduction.code}"  class="form-control" id="code" required>
            </div>

            <div class="form-group col-md-8">
                <label for="quantity">Quantity <span class="spanerror">*</span></label>
                <input type="number" name="quantity"
                       onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                       maxlength = "5"
                       value="${iproduction.quantity}"  class="form-control" id="quantity" min="1" required>
            </div>

            <div class="form-group col-md-8" <c:if test="${type.equals('add')}">hidden="hidden" </c:if>>
                <label for="status">Product Status<span class="spanerror">*</span></label>
                <select class="form-select required" name="status"   aria-label="Default select example" id="status"  onchange="jsFunction(this.value);">

                    <option value="none" disabled selected hidden>Select status</option>
                    <option value="New"  <c:if test="${iproduction.status =='New'}" >selected </c:if> > New</option>
                    <option value="WIP"
                            <c:if test="${statusChange.equals('Raw material is Unavailable')}">hidden</c:if>
                            <c:if test="${iproduction.status =='WIP'}"> selected </c:if> >WIP
                    </option>
                    <option value="Hold"
                            <c:if test="${statusChange.equals('Raw material is Unavailable')}">hidden</c:if>
                            <c:if test="${iproduction.status =='Hold'}"> selected </c:if>> Hold
                    </option>
                    <option value="Testing"
                            <c:if test="${statusChange.equals('Raw material is Unavailable')}">hidden</c:if>
                            <c:if test="${iproduction.status =='Testing'}"> selected </c:if> >Testing
                    </option>
                    <option value="Complete"
                            <c:if test="${statusChange.equals('Raw material is Unavailable')}">hidden</c:if>
                            <c:if test="${iproduction.status =='Complete'}"> selected </c:if>>Complete
                    </option>

                </select>
            </div>
            <br>

            <div class="form-group col-md-8" hidden >
                <label for="date">Request Date </label>
                <input type="date" name="date" readonly="readonly" value="${iproduction.date}" class="form-control" id="date" required>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="category">Category<span class="spanerror">*</span></label>
                <input type="text" name="category"
                       <c:if test="${type.equals('add')}">value="${category}"</c:if>
                       value="${iproduction.category}"
                       readonly="readonly" class="form-control" id="category" required>
            </div>

            <div class="form-group col-md-8">
                <label for="comment">Comments</label>
                <textarea class="text-area" autocomplete="off" name="comment" id="comment" cols="100" rows="5">${iproduction.comment}</textarea>

            </div> <br><br>

            <c:if test="${type.equals('edit') && category.equals('Product')}">
            <div class="container">
                <div class="row">
                   <div class="col-md-12 my-2 text-center" <c:if test="${Request.production_request == 'true'}">style="background-color: limegreen;"</c:if>
                         id ="productionrequest" style="background-color: #e6e6e6;" onclick="changecolor(this)">
                        <h2>Production Request</h2>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="row">
                            <div class="col-md-5 my-2 text-center"  <c:if test="${Request.pcb_production == 'true'}">style="background-color: limegreen;"</c:if>
                                 onclick="changecolor1(this)" id="pcbproduction" style="background-color: #e6e6e6; "margin-right: 10px ;">
                            PCB production
                        </div>
                        <div class="col-md-1"></div>
                        <div class="col-md-5 my-2 ml-1 text-center" <c:if test="${Request.raw_component == 'true'}">style="background-color: limegreen;"</c:if>
                             onclick="changecolor2(this)" id="rawcomponent" style="background-color: #e6e6e6;">
                            RAW components gathering
                        </div>
                        <div class="col-md-11  text-center" <c:if test="${Request.mounting == 'true'}">style="background-color: limegreen;"</c:if>
                             onclick="changecolor3(this)" id="mounting" style="background-color: #e6e6e6;">
                            Mounting
                        </div>
                    </div>
                </div>
                <div class="col-md-4 text-center" <c:if test="${Request.node_mcu == 'true'}">style="background-color: limegreen;"</c:if>
                     onclick="changecolor4(this)" id="nodemcu" style="background-color: #e6e6e6;">
                    Node MCU code burn
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 my-2 text-center" <c:if test="${Request.node_mcu_mounting == 'true'}">style="background-color: limegreen;"</c:if>
                     id ="nodemcumounting" style="background-color: #e6e6e6;" onclick="changecolor5(this)" >
                    <h2>Node MCU Mounting</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 my-2 text-center" <c:if test="${Request.testing == 'true'}">style="background-color: limegreen;"</c:if>
                     id ="testing" style="background-color: #e6e6e6;" onclick="changecolor6(this)" >
                    <h2>Testing</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 my-2 text-center" <c:if test="${Request.box_packaging == 'true'}">style="background-color: limegreen;"</c:if>
                     id ="boxpackaging" style="background-color: #e6e6e6;" onclick="changecolor7(this)" >
                    <h2>Box Packaging</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 my-2 text-center" <c:if test="${Request.warehouse == 'true'}">style="background-color: limegreen;"</c:if>
                     id ="warehouse" style="background-color: #e6e6e6;" onclick="changecolor8(this)" >
                    <h2>Warehouse</h2>
                </div>
            </div>
            </c:if>
        </div>
            <br>


            <c:if test="${type.equals('add')}">

                <button type="submit" class="btn btn-primary btn-sm" >Save</button>
            </c:if>

            <c:if test="${type.equals('edit')}">
                <button type="submit" class="btn btn-success btn-sm"  >update</button>
            </c:if>

            <c:if test="${type.equals('add')}">
                <script>
                    document.getElementById('date').value = new Date().toISOString().substring(0, 10);
                </script>
            </c:if>


</form>


    <script>

        $(document).ready(function() {

            $("#form").validate();

        });

       function jsFunction(val){

           const flag="false";

           if (flag=="false"){
               if(val=="WIP"){
                   changecolor();
                   changecolor1();
                   changecolor2();
                   flag="true";
               }
           }
        }

    </script>

        <script type="text/javascript">

            function getid(selectObject) {

                var value = selectObject.value;

                $.get("/getinventoryitemid?name="+ value, function (data) {

                    $('#code').val(data);

                });
            }

        </script>

</body>
</html>