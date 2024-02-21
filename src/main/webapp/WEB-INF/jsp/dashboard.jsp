<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang='en'>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"
            integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI=" crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css"
          integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

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

    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/data.js"></script>
    <script src="https://code.highcharts.com/modules/drilldown.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>

    <style>

        body {
            overflow: -moz-scrollbars-none;
        }

        .highcharts-figure,
        .highcharts-data-table table {
            min-width: 310px;
            max-width: 800px;
            margin: 1em auto;
        }

        #container {
            height: 400px;
        }

        .highcharts-data-table table {
            font-family: Verdana, sans-serif;
            border-collapse: collapse;
            border: 1px solid #ebebeb;
            margin: 10px auto;
            text-align: center;
            width: 100%;
            max-width: 500px;
        }

        .highcharts-data-table caption {
            padding: 1em 0;
            font-size: 1.2em;
            color: #555;
        }

        .highcharts-data-table th {
            font-weight: 600;
            padding: 0.5em;
        }

        .highcharts-data-table td,
        .highcharts-data-table th,
        .highcharts-data-table caption {
            padding: 0.5em;
        }

        .highcharts-data-table thead tr,
        .highcharts-data-table tr:nth-child(even) {
            background: #f8f8f8;
        }

        .highcharts-data-table tr:hover {
            background: #f1f7ff;
        }

        .highcharts-credits {
            display: none;
            visibility: hidden;
        }
    </style>

</head>
<body class="theme-body" style="overflow-x: auto">

<c:if test="${dashboard.equals('salesPartnerDashboard') && level == '0'}">
    <h3 id="display_name">
        <span>Client > </span>
        <span onclick="window.location='/salesPartner'">Sales Partner List</span>
        <span> > ${name} Dashboard</span>
    </h3><br>
</c:if>

<c:if test="${dashboard.equals('salesPartnerDashboard') && level > '0'}">
    <h3 id="display_name">
        <span onclick="window.location='/salesPartner'">Sales Partner List</span>
        <span> > ${name} Dashboard</span>
    </h3><br>
</c:if>

<c:if test="${dashboard.equals('dashboard')}">
    <h3 id="display_name">
        <span onclick="window.location='/dashboard'">Dashboard</span>
    </h3><br>
</c:if>


<c:if test="${dashboard.equals('salesPartnerDashboard')}">
    <div id="container" style="min-width: 310px; height: 350px; margin: 0 auto"></div>
</c:if>

<c:if test="${dashboard.equals('dashboard')}">
    <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
</c:if>

<br><br>

<c:if test="${employeeLoggedIn == 'false'}">

        <select style="width: 35%; display: inline" class="form-select required mx-2" name="state" aria-label="Default select example"
                id="childPartnerData" required>
            <option disabled selected value="Select item category" readonly="true">Select Month / Year</option>
            <option value="month">
                Month
            </option>
            <option value="year">
                Year
            </option>
        </select>

        <select style="width: 35%; display: inline" class="form-select required mx-2" name="state" aria-label="Default select example"
                id="childPartnerName" <c:if test="${level > '0'}">hidden</c:if> required>
            <option disabled selected readonly="true">Select Sales Partner</option>
            <c:forEach var="item" items="${salesPartners}">
                    <option value="${item}"  <c:if test="${item == salesPartnerName}">selected</c:if> >${item} </option>
            </c:forEach>
        </select>

        <button type="button" onclick="getData()" class="btn btn-primary btn-sm">Submit</button>

</c:if>

<figure class="highcharts-figure">
    <div id="container1"></div>

</figure>

<br>

<figure class="highcharts-figure" id="chart_container" hidden>
    <div id="container2"></div>
</figure>
<br>
<%--<c:if test="${level == '0'}">--%>

<h3> Find Data between Dates</h3>
<br>

<form action="/findDataBetweenDates/${dashboard}/${salesPartnerID}" method="get" id="form">

    <div class="container-fluid">
        <div class="row">

            <div class="col-md-3">
                <label for="firstDate">From</label>
                <input type="date" name="firstDate" value=""
                       class="form-control" id="firstDate" required>
            </div>
            <div class="col-md-3">
                <label for="secondDate">To</label>
                <input type="date" name="secondDate" value=""
                       class="form-control" id="secondDate" required>
            </div>
            <div class="col-md-3">
                <button type="submit" style="margin-top: 14%" class="btn btn-primary btn-sm">Find</button>
            </div>

        </div>
    </div>
</form>

<br><br>

<%--</c:if>--%>

<script>
    function getData() {

        var month = document.getElementById("childPartnerData").value;

        var partner = document.getElementById("childPartnerName").value;

        console.log("month >>"+ month);

        if (month == "Select item category" || partner == "Select Sales Partner"){

            alert("Plz select data ");

            return;
        }

        var v = month + "=" + partner;

        $.get("/getChildPartnerData?data=" + v, function (data) {

            var graphData = JSON.parse(data);
            // alert("Data >> "+ JSON.stringify(graphData));
            showGraph(month, graphData, partner);
        })
    }

    function showGraph(type, data, partner) {

        document.getElementById("chart_container").removeAttribute("hidden");

        console.log(">>>> data >>>>" + JSON.stringify(data));

        var catagories = [];

        var series = [];
        var data1 = [];
        var data2 = [];
        var data3 = [];

        for (var key in data) {

            if (type == 'month') {

                console.log(key);
                catagories.push(key);
                data1.push(data[key].booked);
                data2.push(data[key].self);
                data3.push(data[key].client);
            } else if (type == 'year') {
                console.log(key);
                catagories.push(key);
                data1.push(data[key].booked);
                data2.push(data[key].self);
                data3.push(data[key].client);

            }

        }

        console.log(">>>> data 1 >>>>" + data1);

        Highcharts.chart('container2', {
            chart: {
                type: 'column'
            },
            title: {
                text: type + "ly data"
            },
            xAxis: {
                categories: catagories,
                crosshair: true
            },
            yAxis: {
                min: 0,
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                    '<td style="padding:0"><b>{point.y}</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: [
                {
                    name: 'Booked',
                    data: data1
                },
                {
                    name: 'Self',
                    data: data2
                },
                {
                    name: 'Client',
                    data: data3
                }
            ]
        });
    }

</script>
<%--<button type="button" class="btn btn-success btn-sm ml-2" onclick="window.location='/addPhoto'">Add Photo</button>--%>

<%--<br>--%>
<%--<h1>View Photo</h1>--%>

<%--<img src="data:image/jpg;base64,${image}" width="240" height="300"/>--%>

<script>
    /* ----------------- Month wise Sale -----------------------------------------------*/

    var monthObj = {

    <c:forEach items="${monthwiseSale}" var="item" varStatus="loop">

    ${item.key}:
    '${item.value}'
    ${not loop.last ? ',' : ''}

    </c:forEach>

    }
    ;
    /* ----------------- Year wise Sale -----------------------------------------------*/

    var yearObj = {

    <c:forEach items="${yearWiseSale}" var="item" varStatus="loop">

    ${item.key}:
    '${item.value}'
    ${not loop.last ? ',' : ''}

    </c:forEach>

    }
    ;

    var yearly = [];

    var monthly = [];

    for (var key1 in yearObj) {

        var obj = {
            name: key1,
            y: yearObj[key1] * 1,
            drilldown: key1
        }

        yearly.push(obj);
    }

    for (var key2 in monthObj) {

        var obj2 = {
            name: key2,
            y: monthObj[key2] * 1,
            drilldown: key2
        }

        monthly.push(obj2);
    }

    var drill_down_data = [];

    $.each(JSON.parse(JSON.stringify(yearly)), function (idx, obj) {

        $.each(JSON.parse(JSON.stringify(monthly)), function (idx, obj1) {

            if (obj1.name.includes(obj.name)) {

                if (drill_down_data.length != 0) {

                    for (var i = 0; i < drill_down_data.length; i++) {

                        if (drill_down_data[i].id == obj.name) {

                            var a = [];

                            a.push(obj1.name);

                            a.push(obj1.y);

                            drill_down_data[i].data.push(a);

                            break;

                        } else {

                            var drilldown_user = {};

                            drilldown_user.id = obj.name;

                            drilldown_user.data = [];

                            var a = [];

                            a.push(obj1.name);

                            a.push(obj1.y);

                            drilldown_user.data.push(a);

                            drill_down_data.push(drilldown_user);

                            break;
                        }

                    }
                } else {

                    var drilldown_user = {};

                    drilldown_user.id = obj.name;

                    drilldown_user.data = [];

                    var a = [];

                    a.push(obj1.name);

                    a.push(obj1.y);

                    drilldown_user.data.push(a);

                    drill_down_data.push(drilldown_user);

                }
            }
        });

    });

    /* ----------------------------------- Chart --------------------------------------------  */

    Highcharts.chart('container', {
        chart: {type: 'column'},
        title: {text: 'Yearly Sale'},
        // subtitle: {text: 'Branch + Count of Job'},
        xAxis: {type: 'category', crosshair: true},
        yAxis: {title: {text: 'Sale in Rupees'}},
        plotOptions: {series: {borderWidth: 0, dataLabels: {enabled: true}, colorByPoint: true}},
        tooltip: {shared: true},
        legend: {enabled: true},

        series: [{
            name: 'Year',
            colorByPoint: true,
            data: yearly
        }],

        drilldown: {
            series: drill_down_data
        }
    });

</script>

</body>
</html>
