<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<%--    <script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"--%>
<%--            integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI=" crossorigin="anonymous"></script>--%>

<%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"--%>
<%--            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"--%>
<%--            crossorigin="anonymous"></script>--%>

<%--    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.4/css/jquery.dataTables.min.css">--%>
<%--    <script src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js" defer></script>--%>

<%--    <link rel="stylesheet" href="/js/plugins/colorpicker/bootstrap-colorpicker-plus.min.css">--%>
<%--    <link rel="stylesheet" href="/js/plugins/scrollbar/jquery.mCustomScrollbar.min.css">--%>
<%--    <link rel="stylesheet" href="/js/plugins/intro-tour/introjs.min.css">--%>
<%--    <link rel="stylesheet" href="/js/plugins/intro-tour/themes/introjs-modern.css">--%>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<%--    <link rel="stylesheet" type="text/css" href="/css/dripicon.css"/>--%>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
<%--    <link rel="stylesheet" href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">--%>

<%--    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>--%>
<%--    <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>--%>
<%--    <script src="/js/validate.js"></script>--%>

<%--    <link rel="stylesheet" type="text/css" href="/css/responsive.css"/>--%>

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
<h3 id="display_name">
    <span>Employee > </span>
    <span onclick="window.location='/employeelist'">Employee List</span>
    <span>> ${type} Employee</span>
</h3>

<c:if test="${type.equals('add')}">

<form action="/addEmployeeForm" method="get" id="form" name="myForm">
    </c:if>

    <c:if test="${type.equals('edit')}">

    <form action="/updateEmployeeForm/${emp.id}" method="get" id="form">

        </c:if>

        <div class="center">

            <div class="form-group col-md-8" hidden>
                <label for="id">Employee ID <span class="spanerror">*</span></label>
                <input type="text"
                       name="id" value="${emp.id}"
                       class="form-control" id="id" autocapitalize="sentences" readonly="readonly" required>
            </div>

            <div class="form-group col-md-8">
                <label for="name">Name <span class="spanerror">*</span></label>
                <input type="text" style="font-family:Times New Roman" name="name" autocomplete="off"
                       value="${emp.name}" class="form-control" id="name"
                       onkeydown="return /[a-z,' ']/i.test(event.key)" autocapitalize="sentences" required>
            </div>

            <div class="form-group col-md-8"><label for="bgroup">Blood Group<span class="spanerror">*</span> </label>
                <select class="form-select required" name="bgroup" aria-label="Default select example" id="bgroup">
                    <option value="none" selected disabled hidden>Select Blood Group</option>
                    <option value="A+" <c:if test="${emp.bgroup =='A+'}"> selected </c:if>>A+</option>
                    <option value="A-" <c:if test="${emp.bgroup =='A-'}"> selected </c:if>>A-</option>
                    <option value="B+" <c:if test="${emp.bgroup =='B+'}"> selected </c:if>>B+</option>
                    <option value="B-" <c:if test="${emp.bgroup =='B-'}"> selected </c:if>>B-</option>
                    <option value="AB+" <c:if test="${emp.bgroup =='AB+'}"> selected </c:if>>AB+</option>
                    <option value="AB-" <c:if test="${emp.bgroup =='AB-'}"> selected </c:if>>AB-</option>
                    <option value="O+" <c:if test="${emp.bgroup =='O+'}"> selected </c:if>>O+</option>
                    <option value="O-" <c:if test="${emp.bgroup =='O-'}"> selected </c:if>>O-</option>
                </select>
            </div>

            <div class="form-group col-md-8">
                <label for="gender">Gender<span class="spanerror">*</span></label>
                <select class="form-select required" name="gender" aria-label="Default select example" id="gender">
                    <option value="none" selected disabled hidden>Select your gender</option>
                    <option value="Male" <c:if test="${emp.gender =='Male'}"> selected </c:if>>Male</option>
                    <option value="Female" <c:if test="${emp.gender =='Female'}"> selected </c:if>>Female</option>
                </select>
            </div>

            <div class="form-group col-md-8">
                <label for="address"> Address<span class="spanerror">*</span></label>
                <input type="text" name="address" autocomplete="off" value="${emp.address}" class="form-control"
                       placeholder="Enter your Address" id="address" required>
            </div>

            <div class="form-group col-md-8">
                <label for="designation">Designation<span class="spanerror">*</span></label>
                <select class="form-select required" name="designation" aria-label="Default select example"
                        id="designation">
                    <option value="none" selected disabled hidden>Select your Designation</option>
                    <option value="Marketing Executive" <c:if
                            test="${emp.designation =='Marketing Executive'}"> selected </c:if>>Marketing Executive
                    </option>
                    <option value="Marketing Lead" <c:if test="${emp.designation =='Marketing Lead'}"> selected </c:if>>
                        Marketing Lead
                    </option>
                    <option value="Installer" <c:if test="${emp.designation =='Installer'}"> selected </c:if>>
                        Installer
                    </option>
                </select>
            </div>

            <div class="form-group col-md-8">
                <label for="email">Email<span class="spanerror">*</span></label>
                <input type="email" name="email" value="${emp.email}" class="form-control" id="email"
                       placeholder="Enter your Email" required>
            </div>

            <div class="form-group col-md-8">
                <label for="mobile">Mobile no<span class="spanerror">*</span></label>
                <input type="number"
                       onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                       name="mobile" value="${emp.mobile}" class="form-control" id="mobile"
                       placeholder="Enter Mobile no"
                       maxlength="10" minlength="10" required>
            </div>

            <div class="form-group col-md-8">
                <label for="altmobile">Alternate Contact No<span class="spanerror">*</span></label>
                <input type="number"
                       onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                       name="altmobile" value="${emp.altmobile}" class="form-control" id="altmobile"
                       placeholder="Mobile no"
                       maxlength="10" minlength="10" required>
            </div>

            <div class="form-group col-md-8">
                <label for="join_date">Joining Date<span class="spanerror">*</span></label>
                <input type="date" name="join_date" value="${emp.join_date}" class="form-control" id="join_date"
                       required>
            </div>

            <div class="form-group col-md-8">
                <label for="dob">Date of Birth<span class="spanerror">*</span></label>
                <input type="date" name="dob" max="${emp.join_date}" value="${emp.dob}" class="form-control" id="dob"
                       required>
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

</body>
</html>