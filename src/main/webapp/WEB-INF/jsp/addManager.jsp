<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<%--    <script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"--%>
<%--            integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI=" crossorigin="anonymous"></script>--%>

  <%--  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
            crossorigin="anonymous"></script>--%>

 <%--   <link rel="stylesheet" href="https://cdn.datatables.net/1.11.4/css/jquery.dataTables.min.css">
    <script src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js" defer></script>--%>

    <%--<link rel="stylesheet" href="/js/plugins/colorpicker/bootstrap-colorpicker-plus.min.css">
    <link rel="stylesheet" href="/js/plugins/scrollbar/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="/js/plugins/intro-tour/introjs.min.css">
    <link rel="stylesheet" href="/js/plugins/intro-tour/themes/introjs-modern.css">--%>

    <%--    <link rel="stylesheet" href="js/plugins/datepicker/datepicker.css">--%>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<%--    <link rel="stylesheet" type="text/css" href="/css/dripicon.css"/>--%>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>

<%--    <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>--%>
    <script src="/js/validate.js"></script>

<%--    <link rel="stylesheet" type="text/css" href="/css/responsive.css"/>--%>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.4/jquery.validate.min.js"></script>

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
            margin-left: 10px;
        }

    </style>
</head>
<body style="overflow-x: auto">
<br>

<c:if test="${level == '0'}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/managersList'">Self Managers List</span>
        <span>> ${type} Manager Form</span>
    </h3>
</c:if>

<c:if test="${level > '0'}">
    <h3 id="display_name">
        <span onclick="window.location='/managersList'">Managers List</span>
        <span>> ${type} Manager Form</span>
    </h3>
</c:if>

<c:if test="${type.equals('add')}">

<form action="/addManagerForm" method="get" id="form">

    </c:if>

    <c:if test="${type.equals('edit')}">

    <form action="/updateManagerForm" method="get" id="form">

        </c:if>

        <div class="center">

            <div class="form-group col-md-8" hidden>
                <label for="id">ID</label>
                <input type="text" name="id" readonly="readonly" value="${manager.id}" class="form-control" id="id"
                       required>
            </div>

            <div class="form-group col-md-8">
                <label for="name">Name <span class="spanerror">*</span></label>
                <input type="text" name="name" autocomplete="off" value="${manager.name}" class="form-control"
                       id="name" required>
            </div>

            <div class="form-group col-md-8">
                <label for="mobile">Mobile no<span class="spanerror">*</span></label>
                <input type="number"
                       onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                       name="mobile" value="${manager.mobile}" class="form-control" id="mobile"
                       placeholder="Mobile no"
                       maxlength="10" minlength="10" required>
            </div>

            <div class="form-group col-md-8">
                <label for="address">Address <span class="spanerror">*</span></label>
                <input type="text" autocomplete="off" name="address" value="${manager.address}"
                       class="form-control" id="address" required>
            </div>

            <div class="form-group col-md-8">
                <label for="email">Email<span class="spanerror">*</span></label>
                <input type="email" name="email" placeholder="Enter you Email" value="${manager.email}"
                       class="form-control" id="email" required>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="date">Registration Date<span class="spanerror">*</span></label>
                <input type="date" name="date" value="${manager.date}"
                       class="form-control" id="date" required>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="level">Level<span class="spanerror">*</span></label>
                <input type="text" name="level" autocomplete="off" readonly="readonly"
                <c:if test="${type.equals('add')}"> value="${level}"</c:if> value="${manager.level}"
                       class="form-control" id="level" required>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="companyID">Company ID<span class="spanerror">*</span></label>
                <input type="text" name="companyID" autocomplete="off" readonly="readonly"
                <c:if test="${type.equals('add')}"> value="${companyID}"</c:if> value="${manager.companyID}"
                       class="form-control" id="companyID" required>
            </div>

            <div class="form-group col-md-8" hidden><label for="status">Employee Status<span class="spanerror">*</span></label></label>
                <select class="form-select required" name="status" aria-label="Default select example" id="status">
                    <option disabled selected value="Select item category" readonly="true">Select Employee Status</option>
                    <option value="Active" <c:if test="${type.equals('add')}">selected</c:if>
                            <c:if test="${manager.status == 'Active'}"> selected </c:if>  >Active
                    </option>
                    <option value="Inactive" <c:if test="${manager.status == 'Inactive'}"> selected </c:if> >
                        Inactive
                    </option>
                </select>
            </div>

            <div class="form-group col-md-8"><label for="comment">Comment </label>
                <input type="text" name="comment" value="${manager.comment}"
                       class="form-control" autocomplete="off" id="comment">
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

<%--    <c:if test="${type.equals('add')}">--%>
    <script>
        document.getElementById('date').value = new Date().toISOString().substring(0, 10);
    </script>
<%--    </c:if>--%>

    <script>


        $(document).ready(function () {

            $("#form").validate();

        });

    </script>

</body>
</html>