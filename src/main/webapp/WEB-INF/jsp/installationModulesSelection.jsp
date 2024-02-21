<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang='en'>
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
    <link rel="stylesheet" href="/js/plugins/datepicker/datepicker.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>

    <link rel="stylesheet" type="text/css" href="/css/dripicon.css"/>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <link rel="stylesheet" type="text/css" href="/css/responsive.css"/>

    <style>

        #display_name {
            cursor: pointer;
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
        <span> > ${type} boards</span>
    </h3>
</c:if>

<c:if test="${clientType.equals('lead') && level > '0'}">
    <h3 id="display_name">
        <span onclick="window.location='/leads'">Leads</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${quotationNum}/${quotationID}'"> > Quotation No: ${quotationNum}</span>
        <span onclick="window.location='/viewBoardsData/${quotationID}'"> > Boards Data</span>
        <span> > ${type} boards</span>
    </h3>
</c:if>

<c:if test="${clientType.equals('client') && level == '0'}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/clientList'">Client List</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${quotationNum}/${quotationID}'"> > Quotation No: ${quotationNum} </span>
        <span onclick="window.location='/viewBoardsData/${quotationID}'"> > Boards Data</span>
        <span> > ${type} boards</span>

    </h3>
</c:if>

<c:if test="${clientType.equals('client') && level > '0'}">
    <h3 id="display_name">
        <span onclick="window.location='/clientList'">Client List</span>
        <span onclick="window.location='/quotationList/${clientID}'"> > ${clientName} </span>
        <span onclick="window.location='/quotationBOMlist/${quotationNum}/${quotationID}'"> > Quotation No: ${quotationNum}</span>
        <span onclick="window.location='/viewBoardsData/${quotationID}'"> > Boards Data</span>
        <span> > ${type} boards</span>
    </h3>
</c:if>


<br>

<%--
<div class="row g-3">
    <div class="col">
        <input type="text" class="form-control" placeholder="First name" aria-label="First name">
    </div>
    <div class="col">
        <input type="text" class="form-control" placeholder="Last name" aria-label="Last name">
    </div>
</div>
<br><br>--%>

<script>
    var forLoopCount = 1;

    var boardsCountData;
</script>

<c:if test="${type.equals('add')}">
    <form action="/saveBoardsCountData/${quotationID}" class="row g-3">

        <div class="col-md-6">
            <label for="roomName" class="form-label"> Rooms </label>
            <select id="roomName" name="roomName" class="form-select">
                <option selected disabled>Select Room</option>
                <option  <c:if test="${roomName == 'Bedroom'}"> selected </c:if> >Bedroom</option>
                <option <c:if test="${roomName == 'Basement'}"> selected </c:if> >Basement</option>
                <option <c:if test="${roomName == 'Kitchen'}"> selected </c:if> >Kitchen</option>
                <option <c:if test="${roomName == 'Lobby'}"> selected </c:if> >Lobby</option>
                <option <c:if test="${roomName == 'Parking'}"> selected </c:if> >Parking</option>
            </select>
        </div>

        <div class="col-md-4" hidden>
            <label for="boardCount" class="form-label"> Boards Count </label>
            <select id="boardCount" name="boardCount" class="form-select">
                <option value="1" selected >1</option>
            </select>
        </div>

        <div class="col-2">
            <button type="submit" <%--<c:if test="${boardsCount != 0 }"> hidden </c:if>--%>
                    style="margin-top: 30px" <%--onclick="addBoards()"--%> class="btn btn-primary">Save
            </button>
        </div>

    </form>
    <br>
</c:if>


<c:forEach var="i" begin="1" end="${boardsCount}">

    <c:if test="${type.equals('add')}">
        <form class="row g-3" action="/addInstallationModulesSelectionForm/${quotationID}" method="get" id="form-${i}">
    </c:if>

    <c:if test="${type.equals('edit')}">
        <form class="row g-3" action="/updateInstallationModulesSelectionForm/${roomBoardsObj.id}/${quotationID}" method="get" id="form-${i}">
    </c:if>
    <%--<form class="row g-3" action="/addInstallationModulesSelectionForm/${quotationID}" method="get" id="form">--%>

    <div class="col-md-2">
        <h3 style="margin-top: 25px">
            <c:if test="${type.equals('add')}">
            Board
            <script>
                document.write(" " + forLoopCount);

                $('<input/>').attr({
                    type: 'text',
                    name: "boardName",
                    id: forLoopCount,
                    value: "Board" + forLoopCount
                }).appendTo('#form-' + forLoopCount);

                $("#" + forLoopCount).css('display', 'none');
            </script>
            </c:if>
            <c:if test="${type.equals('edit')}">
                ${roomBoardsObj.boardName}
            </c:if>

        </h3>
    </div>

    <div class="col-md-2">
        <label for="lightPoint" class="form-label">Light Points</label>
        <select id="lightPoint" name="lightPoint" class="form-select">

            <option selected>0</option>
            <option <c:if test="${roomBoardsObj.lightPoint == 1}"> selected </c:if> >1</option>
            <option <c:if test="${roomBoardsObj.lightPoint == 2}"> selected </c:if> >2</option>
            <option <c:if test="${roomBoardsObj.lightPoint == 3}"> selected </c:if> >3</option>
            <option <c:if test="${roomBoardsObj.lightPoint == 4}"> selected </c:if> >4</option>
            <option <c:if test="${roomBoardsObj.lightPoint == 5}"> selected </c:if> >5</option>
            <option <c:if test="${roomBoardsObj.lightPoint == 6}"> selected </c:if> >6</option>
            <option <c:if test="${roomBoardsObj.lightPoint == 7}"> selected </c:if> >7</option>
            <option <c:if test="${roomBoardsObj.lightPoint == 8}"> selected </c:if> >8</option>
            <option <c:if test="${roomBoardsObj.lightPoint == 9}"> selected </c:if> >9</option>
            <option <c:if test="${roomBoardsObj.lightPoint == 10}"> selected </c:if> >10</option>
        </select>
    </div>

    <div class="col-md-2">
        <label for="rgb" class="form-label"> RGB </label>
        <select id="rgb" name="rgb" class="form-select">
            <option selected>0</option>
            <option <c:if test="${roomBoardsObj.rgb == 1}"> selected </c:if> >1</option>
            <option <c:if test="${roomBoardsObj.rgb == 2}"> selected </c:if> >2</option>
            <option <c:if test="${roomBoardsObj.rgb == 3}"> selected </c:if> >3</option>
            <option <c:if test="${roomBoardsObj.rgb == 4}"> selected </c:if> >4</option>
            <option <c:if test="${roomBoardsObj.rgb == 5}"> selected </c:if> >5</option>
            <option <c:if test="${roomBoardsObj.rgb == 6}"> selected </c:if> >6</option>
            <option <c:if test="${roomBoardsObj.rgb == 7}"> selected </c:if> >7</option>
            <option <c:if test="${roomBoardsObj.rgb == 8}"> selected </c:if> >8</option>
            <option <c:if test="${roomBoardsObj.rgb == 9}"> selected </c:if> >9</option>
            <option <c:if test="${roomBoardsObj.rgb == 10}"> selected </c:if> >10</option>
        </select>
    </div>

    <div class="col-md-2">
        <label for="fan" class="form-label">Fan</label>
        <select id="fan" name="fan" class="form-select">
            <option selected>0</option>
            <option <c:if test="${roomBoardsObj.fan == 1}"> selected </c:if> >1</option>
            <option <c:if test="${roomBoardsObj.fan == 2}"> selected </c:if> >2</option>
            <option <c:if test="${roomBoardsObj.fan == 3}"> selected </c:if> >3</option>
            <option <c:if test="${roomBoardsObj.fan == 4}"> selected </c:if> >4</option>
            <option <c:if test="${roomBoardsObj.fan == 5}"> selected </c:if> >5</option>
            <option <c:if test="${roomBoardsObj.fan == 6}"> selected </c:if> >6</option>
            <option <c:if test="${roomBoardsObj.fan == 7}"> selected </c:if> >7</option>
            <option <c:if test="${roomBoardsObj.fan == 8}"> selected </c:if> >8</option>
            <option <c:if test="${roomBoardsObj.fan == 9}"> selected </c:if> >9</option>
            <option <c:if test="${roomBoardsObj.fan == 10}"> selected </c:if> >10</option>
        </select>
    </div>

    <div class="col-md-2">
        <label for="power" class="form-label">Power</label>
        <select id="power" name="power" class="form-select">
            <option selected>0</option>
            <option <c:if test="${roomBoardsObj.power == 1}"> selected </c:if> >1</option>
            <option <c:if test="${roomBoardsObj.power == 2}"> selected </c:if> >2</option>
            <option <c:if test="${roomBoardsObj.power == 3}"> selected </c:if> >3</option>
            <option <c:if test="${roomBoardsObj.power == 4}"> selected </c:if> >4</option>
            <option <c:if test="${roomBoardsObj.power == 5}"> selected </c:if> >5</option>
            <option <c:if test="${roomBoardsObj.power == 6}"> selected </c:if> >6</option>
            <option <c:if test="${roomBoardsObj.power == 7}"> selected </c:if> >7</option>
            <option <c:if test="${roomBoardsObj.power == 8}"> selected </c:if> >8</option>
            <option <c:if test="${roomBoardsObj.power == 9}"> selected </c:if> >9</option>
            <option <c:if test="${roomBoardsObj.power == 10}"> selected </c:if> >10</option>
        </select>
    </div>

    <%--  <div class="col-md-1 aa">
          <button style="margin-top: 30px" title="Add Another Board" onclick="addData()" type="button"
                  class="btn btn-secondary">+
          </button>
      </div>--%>

    <script>forLoopCount++;</script>

    <div class="col-2">
        <button style="margin-top: 30px" type="submit" class="btn btn-primary">Submit</button>
    </div>

    </form>

</c:forEach>

<%-- <div class="col-12">
     <button type="button" onclick="addData()" class="btn btn-primary">Submit</button>
 </div>--%>


<script>

    function addBoards() {

        var boardsCount = document.getElementById('boardCount');

        boardsCountData = boardsCount.value;
        /*
                $.get("/saveBoardsCountData?name=" + boardsCountData, function (data) {

                    // alert("boardsCountData added !! ");
                });*/

        // location.reload();
        // $("#mainDiv").removeAttr("hidden");

    }


    $(document).ready(function () {

    });
</script>

</body>
</html>
