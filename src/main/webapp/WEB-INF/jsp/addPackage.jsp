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
    <span>Finance > </span>
    <span onclick="window.location='/finance_package'">Package List</span>
    <span>> ${type} Package</span>
</h3>

<c:if test="${type.equals('add')}">

<form action="/addPackageForm" method="get" id="form">

    </c:if>

    <c:if test="${type.equals('edit')}">

    <form action="/updatePackage/${package2.id}" method="get" id="form">

        </c:if>

        <div class="center">

            <div class="form-group col-md-8" hidden>
                <label for="id">Package ID <span class="spanerror">*</span></label>
                <input type="text"
                       <c:if test="${type.equals('add')}">value="${size}" </c:if>
                       name="id" value="${package2.id}"
                       class="form-control" id="id" autocapitalize="sentences" readonly="readonly" required>
            </div>

            <div class="form-group col-md-8"><label for="name">Package Name <span class="spanerror">*</span></label>
                <select class="form-select required" name="name" aria-label="Default select example" id="name" required>

                    <option disabled selected value="Select item category" readonly="true">Select Package</option>
                    <option value="1 BHK" <c:if test="${package2.name =='1 BHK'}"> selected </c:if>>1 BHK</option>
                    <option value="2 BHK" <c:if test="${package2.name =='2 BHK'}"> selected </c:if>>2 BHK</option>
                    <option value="3 BHK" <c:if test="${package2.name =='3 BHK'}"> selected </c:if>>3 BHK</option>
                    <option value="4 BHK" <c:if test="${package2.name =='4 BHK'}"> selected </c:if>>4 BHK</option>
                    <option value="5 BHK" <c:if test="${package2.name =='5 BHK'}"> selected </c:if>>5 BHK</option>
                    <option value="Bunglow" <c:if test="${package2.name =='Bunglow'}"> selected </c:if>>Bunglow</option>

                </select>
            </div>

            <div class="form-group col-md-8">
                <label for="discount">Package Discount (%) <span class="spanerror">*</span></label>
                <input type="number" step="0.01" readonly="readonly"
<%--                       onchange="changeFinalTotal()"--%>
                       <c:if test="${type.equals('add')}">value="0"</c:if> value="${package2.discount}" name="discount"
                       class="form-control" id="discount" min="0" required>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="total">Total Amount<span class="spanerror">*</span></label>
                <input type="number"
                       <c:if test="${type.equals('add')}">value="0" readonly="readonly"</c:if> value="${package2.total}" name="total"
                       onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                       maxlength="10"
                       class="form-control" id="total" min="0" required>
            </div>

            <div class="form-group col-md-8">
                <label for="finalTotal">Final Amount<span class="spanerror">*</span></label>
                <input type="number" onchange="changePercentage(this)"
                       <c:if test="${type.equals('add')}">value="0"</c:if> value="${package2.finalTotal}" name="finalTotal"
                       onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                       maxlength="10"
                       class="form-control" id="finalTotal" min="0" required>
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

        $(document).ready(function () {

            $("#form").validate();

        });

        function changePercentage(amount) {

            console.log(" >>>>>>>>>>>>>>. " + amount.value);

            var v = ((${package2.total} - amount.value)/ ${package2.total} ) * 100;

            <%--alert(((${package2.total} - amount.value)/ ${package2.total} ) * 100);--%>

            document.getElementById("discount").value = v.toFixed(2);

        }

        function changeFinalTotal() {

            // document.getElementById("finalTotal").value = "0";
        }

    </script>

</body>
</html>