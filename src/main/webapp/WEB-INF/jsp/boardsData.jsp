<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang='en'>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"
            integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI=" crossorigin="anonymous"></script>

    <%--  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
              integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
              crossorigin="anonymous"></script>--%>
    <%-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css"
           integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw=="
           crossorigin="anonymous" referrerpolicy="no-referrer"/>--%>

    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.4/css/jquery.dataTables.min.css">
    <script src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js" defer></script>

    <%--    <link rel="stylesheet" href="/js/plugins/colorpicker/bootstrap-colorpicker-plus.min.css">
        <link rel="stylesheet" href="/js/plugins/scrollbar/jquery.mCustomScrollbar.min.css">
        <link rel="stylesheet" href="/js/plugins/intro-tour/introjs.min.css">
        <link rel="stylesheet" href="/js/plugins/intro-tour/themes/introjs-modern.css">
        <link rel="stylesheet" href="/js/plugins/datepicker/datepicker.css">--%>

    <%--
        <link rel="stylesheet" type="text/css" href="/css/dripicon.css"/>
    --%>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <%--    <link rel="stylesheet" type="text/css" href="/css/responsive.css"/>--%>

    <style>

        table, th, tr {
            width: 100px;
            text-align: center;
        }

        #display_name {
            cursor: pointer;
        }

        body {
            overflow: -moz-scrollbars-none;
        }
    </style>

</head>
<body class="theme-body" style="overflow-x: auto">


<c:if test="${clientType.equals('lead') && level == '0'}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/leads'">Leads</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${quotationNum}/${quotationID}'"> > Quotation No: ${quotationNum}</span>
        <span onclick="window.location='/viewBoardsData/${quotationID}'"> > Boards Data</span>
    </h3>
</c:if>

<c:if test="${clientType.equals('lead') && level > '0'}">
    <h3 id="display_name">
        <span onclick="window.location='/leads'">Leads</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${quotationNum}/${quotationID}'"> > Quotation No: ${quotationNum}</span>
        <span onclick="window.location='/viewBoardsData/${quotationID}'"> > Boards Data</span>
    </h3>
</c:if>

<c:if test="${clientType.equals('client') && level == '0'}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/clientList'">Client List</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${quotationNum}/${quotationID}'"> > Quotation No: ${quotationNum} </span>
        <span onclick="window.location='/viewBoardsData/${quotationID}'"> > Boards Data</span>
    </h3>
</c:if>

<c:if test="${clientType.equals('client') && level > '0'}">
    <h3 id="display_name">
        <span onclick="window.location='/clientList'">Client List</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${quotationNum}/${quotationID}'"> > Quotation No: ${quotationNum}</span>
        <span onclick="window.location='/viewBoardsData/${quotationID}'"> > Boards Data</span>
    </h3>
</c:if>
<br>

<button type="button" class="btn btn-primary"
<%--        <c:if test="${quotationAddedCheck.equals(true)}">disabled</c:if>--%>
        onclick="window.location='/installationModulesSelection/${"add"}/${"null"}/${quotationID}'"
        data-bs-toggle="modal" data-bs-target="#exampleModal">Add Boards
</button>
<br><br>

<table id="example" class="table table-striped">
    <thead>
    <tr>
        <th>Room</th>
        <th>Board</th>
        <th>Light</th>
        <th>RGB</th>
        <th>Fan</th>
        <th>Power</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach var="boardObj" items="${boardsData}">
        <tr>
            <td>${boardObj.roomName}</td>
            <td>${boardObj.boardName}</td>
            <td>${boardObj.lightPoint}</td>
            <td>${boardObj.rgb}</td>
            <td>${boardObj.fan}</td>
            <td>${boardObj.power}</td>
            <td>
                <button type="button" class="btn btn-success btn-sm ml-2"
                        onclick="window.location='/installationModulesSelection/${"edit"}/${boardObj.id}/${quotationID}'">
                    Edit
                </button>

                <button type="button" class="btn btn-danger btn-sm ml-2"
                        onclick="window.location='/deleteRoomBoard/${boardObj.id}/${quotationID}'">
                    Delete
                </button>
            </td>
        </tr>
    </c:forEach>


    </tbody>

</table>
<br>

<c:if test="${roomBoardSize > 0}">
    <button type="button" id="btn2" class="btn btn-success btn-sm ml-2"
            onclick="window.location='/saveDataInQuotationBOM/${quotationID}'">
        Submit
    </button>
</c:if>

<script>
    $(document).ready(function () {

        $('#example').dataTable({
            "aLengthMenu": [25, 50, 75, 100],
            "pageLength": 100,
            "aoColumns": [
                {"sWidth": "15%"},
                {"sWidth": "15%"},
                {"sWidth": "10%"},
                {"sWidth": "10%"},
                {"sWidth": "10%"},
                {"sWidth": "10%"},
                {"sWidth": "20%"}
            ]
        });

    });

</script>

</body>
</html>