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
    <script src="/js/validate.js"></script>

    <link rel="stylesheet" type="text/css" href="/css/responsive.css"/>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.4/jquery.validate.min.js"></script>

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
<body style="overflow-x: auto">

<c:if test="${level.equals('0')}">
    <h3 id="display_name">
        <span onclick="window.location='/leads'">Leads</span>
        <span> > ${type} Lead</span>
    </h3><br>
</c:if>

<c:if test="${level > ('0')}">
    <h3 id="display_name">
        <span>Leads</span>
        <span> > ${type} Lead</span>
    </h3><br>
</c:if>

<c:if test="${type.equals('add')}">

<form action="/addLeadsForm" method="get" id="form" name="myForm">

    </c:if>

    <c:if test="${type.equals('edit')}">

    <form action="/updateLeadsForm/${data.id}" method="get" id="form">

        </c:if>

        <div class="center">

            <div class="form-group col-md-8" hidden>
                <label for="id">ID</label>
                <input type="text" name="id" readonly="readonly" value="${data.id}" class="form-control" id="id"
                       required>
            </div>

            <div class="form-group col-md-8">
                <label for="name">Client name <span class="spanerror">*</span></label>
                <input type="text" autocomplete="off" <%--onkeydown="return /[a-z,' ']/i.test(event.key)"--%> name="name"
                       value="${data.name}" <%--style="text-transform:capitalize"--%> class="form-control required" id="name"
                       autocapitalize="sentences">
            </div>

            <div class="form-group col-md-8">
                <label for="address">Address<span class="spanerror">*</span></label>
                <input type="text" name="address" style="text-transform:capitalize" autocomplete="off"
                       onkeydown="return /[a-z,0-9' ']/i.test(event.key)"
                       value="${data.address}" class="form-control" placeholder="Enter your Address" id="address"
                       required>
            </div>

            <div class="form-group col-md-8">
                <label for="mobile">Mobile no<span class="spanerror">*</span></label>
                <input type="number"
                       onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                       name="mobile" value="${data.mobile}" class="form-control" id="mobile"
                       placeholder="Mobile no"
                       maxlength="10" minlength="10" required>
            </div>

            <div class="form-group col-md-8">
                <label for="stage">Stage<span class="spanerror">*</span></label>
                <select class="form-select required" name="stage" aria-label="Default select example"
                        onchange="setFollowUpDate(this)" id="stage">
                    <option value="none" selected disabled hidden>Select stage</option>
                    <option value="New" <c:if test="${data.stage =='New' || type.equals('add')}"> selected </c:if> >New
                    </option>
                    <option value="Prospect" <c:if test="${data.stage =='Prospect'}"> selected </c:if> >Prospect
                    </option>
                    <option value="Qualify"  <c:if test="${data.stage =='Qualify'}"> selected </c:if> >Qualify</option>
                    <option value="Follow up required"  <c:if
                            test="${data.stage =='Follow up required'}"> selected </c:if> >Follow up required
                    </option>
                    <option value="Interested to buy"  <c:if
                            test="${data.stage =='Interested to buy'}"> selected </c:if> >Interested to buy
                    </option>
                    <option value="May but later"  <c:if test="${data.stage =='May but later'}"> selected </c:if> >May
                        but later
                    </option>
                    <option value="Not intersted"  <c:if test="${data.stage =='Not intersted'}"> selected </c:if> >Not
                        intersted
                    </option>
                </select>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="captureBy">Captured by<span class="spanerror">*</span></label>
                <input type="text" autocomplete="off" name="captureBy"
                       value="${data.captureBy}" class="form-control" id="captureBy">
            </div>

            <div class="form-group col-md-8" id="followUpDate" hidden>
                <label for="followDate">Follow up Date<span class="spanerror">*</span></label>
                <input type="date" name="followDate" value="${data.followDate}"
                       class="form-control" id="followDate" required>
            </div>

            <div class="form-group col-md-8">
                <label for="registration">Registration Date<span class="spanerror">*</span></label>
                <input type="date" name="registration" value="${data.registration}"
                       class="form-control" id="registration" required>
            </div>

            <div class="form-group col-md-8">
                <label for="leadType">Client Type <span class="spanerror">*</span></label>
                <select class="form-select required" name="leadType" aria-label="Default select example"
                        id="leadType">
                    <option value="none" selected disabled hidden>Select client type</option>
                    <option value="Individual"
                            <c:if test="${data.leadType == 'Individual'}"> selected </c:if> >Individual
                    </option>
                    <option value="Business"
                            <c:if test="${data.leadType =='Business'}"> selected </c:if> >Business
                    </option>
                </select>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="leadBy">Lead Generated By<span class="spanerror">*</span></label>
                <input type="text" autocomplete="off" name="leadBy"
                       <c:if test="${type.equals('add')}">value="${lead_generated}"</c:if>
                       value="${data.leadBy}" class="form-control" id="leadBy">
            </div>
            <div class="form-group col-md-8" hidden>
                <label for="category">Lead Category<span class="spanerror">*</span></label>
                <select class="form-select required" name="category" aria-label="Default select example"
                        id="category">
                    <option value="none" selected disabled hidden>Select Category type</option>
                    <option value="Self"
                            <c:if test="${level > ('1')}">selected hidden</c:if>
                            <c:if test="${data.category =='Digital'}"> hidden </c:if>
                            <c:if test="${data.category =='Self'}"> selected </c:if>
                            <c:if test="${category.equals('Self')}"> selected </c:if>
                            <c:if test="${category.equals('Digital')}"> hidden </c:if> >Self
                    </option>
                    <option value="Digital"
                            <c:if test="${level > ('1') && category =='Self'}">hidden</c:if>
                            <c:if test="${data.category =='Self'}">hidden</c:if>
                            <c:if test="${data.category =='Digital'}"> selected </c:if>
                            <c:if test="${category.equals('Digital')}"> selected </c:if>
                            <c:if test="${category.equals('Self')}"> hidden </c:if>>Digital
                    </option>
                </select>
            </div>

            <div class="form-group col-md-8"
                    <c:if test="${category.equals('Digital')}"> hidden </c:if>
                    <c:if test="${isSalesEmployeeLoggedIn.equals('true')}"> hidden </c:if>
                <%-- <c:if test="${type.equals('edit')}">hidden</c:if> --%>>
                <label for="salesEmpName">Sales Employee Name<span class="spanerror">*</span> </label>
                <select class="form-select required" name="salesEmpName"
                        aria-label="Default select example" onchange="getSalesEmpID(this)"
                        id="salesEmpName">
                    <option value="none" disabled selected hidden>Select Employee name</option>
                    <c:forEach var="employeeObj" items="${salesEmployeeList}">
                        <option  <%--<c:if test="${employeeObj.name ==order.installerName}"> selected </c:if>--%>
                                value="${employeeObj}">${employeeObj} </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="salesEmpID">Sales Employee Id <span class="spanerror">*</span></label>
                <input type="text" name="salesEmpID"
                       <c:if test="${type.equals('add') && isSalesEmployeeLoggedIn.equals('true')}">value="${salesEmployeeId}"</c:if>
                       value="${data.salesEmpID}"
                       readonly="readonly" class="form-control"
                       id="salesEmpID" required>
            </div>

            <div class="form-group col-md-8">
                <label for="comment">Comment </label>
                <input type="text" name="comment" value="${data.comment}"
                       class="form-control" autocomplete="off" id="comment">
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

    <c:if test="${type.equals('add')}">
    <script>
        document.getElementById('registration').value = new Date().toISOString().substring(0, 10);
    </script>
    </c:if>

    <script>

        $(document).ready(function () {

            $("#form").validate();

        });

        function getSalesEmpID(subject) {

            var v = subject.value;

            alert("Clicked >>> ");

            $.get("/getSalesEmployeeID?name=" + v, function (data) {

                $("#salesEmpID").val(data);

            });

        }

        function setFollowUpDate(sub) {

            var v = sub.value;

            if (v == 'Follow up required') {

                document.getElementById("followDate").value = "";

                $("#followUpDate").removeAttr("hidden");
            } else {
                document.getElementById("followUpDate").setAttribute("hidden", "hidden");

                document.getElementById("followDate").value = "2099-01-01";
            }
        }

    </script>

</body>
</html>