<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang='en'>

<head>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <%--    <script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"--%>
    <%--            integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI=" crossorigin="anonymous"></script>--%>

    <%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"--%>
    <%--            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"--%>
    <%--            crossorigin="anonymous"></script>--%>


    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.4/css/jquery.dataTables.min.css">
    <script src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js" defer></script>

    <link rel="stylesheet" href="/js/plugins/colorpicker/bootstrap-colorpicker-plus.min.css">
    <link rel="stylesheet" href="/js/plugins/scrollbar/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="/js/plugins/intro-tour/introjs.min.css">
    <link rel="stylesheet" href="/js/plugins/intro-tour/themes/introjs-modern.css">
    <link rel="stylesheet" href="/js/plugins/datepicker/datepicker.css">

    <%--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>--%>
    <%--    <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>--%>

    <link rel="stylesheet" type="text/css" href="/css/dripicon.css"/>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <link rel="stylesheet" type="text/css" href="/css/responsive.css"/>

    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/>


    <style>

        body {
            /*margin-top:20px;*/
            color: #484b51;
            size: A4;

        }

        .text-secondary-d1 {
            color: #728299 !important;
        }

        .page-header {
            margin: 0 0 1rem;
            padding-bottom: 1rem;
            padding-top: .5rem;
            border-bottom: 1px dotted #e2e2e2;
            display: -ms-flexbox;
            display: flex;
            -ms-flex-pack: justify;
            justify-content: space-between;
            -ms-flex-align: center;
            align-items: center;
        }

        .page-title {
            padding: 0;
            margin: 0;
            font-size: 1.75rem;
            font-weight: 300;
        }

        .brc-default-l1 {
            border-color: #dce9f0 !important;
        }

        .ml-n1, .mx-n1 {
            margin-left: -.25rem !important;
        }

        .mr-n1, .mx-n1 {
            margin-right: -.25rem !important;
        }

        .mb-4, .my-4 {
            margin-bottom: 1.5rem !important;
        }

        hr {
            margin-top: 1rem;
            margin-bottom: 1rem;
            border: 0;
            border-top: 1px solid rgba(0, 0, 0, .1);
        }

        .text-grey-m2 {
            color: #888a8d !important;
        }

        .text-success-m2 {
            color: #86bd68 !important;
        }

        .font-bolder, .text-600 {
            font-weight: 600 !important;
        }

        .text-110 {
            font-size: 110% !important;
        }

        .text-blue {
            color: #478fcc !important;
        }

        .pb-25, .py-25 {
            padding-bottom: .75rem !important;
        }

        .pt-25, .py-25 {
            padding-top: .75rem !important;
        }

        .bgc-default-tp1 {
            background-color: rgba(121, 169, 197, .92) !important;
        }

        .bgc-default-l4, .bgc-h-default-l4:hover {
            background-color: #f3f8fa !important;
        }

        .page-header .page-tools {
            -ms-flex-item-align: end;
            align-self: flex-end;
        }

        .btn-light {
            color: #757984;
            background-color: #f5f6f9;
            border-color: #dddfe4;
        }

        .w-2 {
            width: 1rem;
        }

        .text-120 {
            font-size: 120% !important;
        }

        .text-primary-m1 {
            color: #4087d4 !important;
        }

        .text-danger-m1 {
            color: #dd4949 !important;
        }

        .text-blue-m2 {
            color: #68a3d5 !important;
        }

        .text-150 {
            font-size: 150% !important;
        }

        .text-60 {
            font-size: 60% !important;
        }

        .text-grey-m1 {
            color: #7b7d81 !important;
        }

        .align-bottom {
            vertical-align: bottom !important;
        }



        @media print {
            body {
                -webkit-print-color-adjust: exact !important;
            }
        }

        /*  #page1 {
              size: A4;
              margin: 0;
          }*/

    </style>
</head>

<body style="-webkit-print-color-adjust: exact; overflow-x: auto">

<script>
    function printpage() {

        var printButton = document.getElementById("btn");

        printButton.style.visibility = 'hidden';

        window.print();

        printButton.style.visibility = 'visible';

    }
</script>

<script>
    var totalCount = 0;
    var totalAmount = 0;
    var discount = 0;
    var discountedPrice = 0;
    var extraDiscount = 0;
    var today = new Date();
    var date = today.getDate() + '-' + (today.getMonth() + 1) + '-' + today.getFullYear();
</script>

<div class="page-content container">
    <div class="page-header text-d2">
        <h1 class="page-title text-secondary-d1" style="font-weight: bold; color: #0c4bab" >
            WIFY Systems
        </h1>

        <div class="page-tools">
            <div class="action-buttons">
                <a class="btn bg-white btn-light mx-1px text-95" id="btn" onclick="printpage()" href="#"
                   data-title="Print">
                    <i class="mr-1 fa fa-print text-primary-m1 text-120 w-2"></i>
                    Print
                </a>
            </div>
        </div>
    </div>

    <div class="container px-0">
        <div class="row mt-4">
            <div class="col-12 col-lg-12">
                <%--                <hr class="row brc-default-l1 mx-n1 mb-4" />--%>

                <div class="row">
                    <div class="col-4 text-left">
                        <div>
                            <span class="text-sm text-center text-grey-m2 align-middle">To:</span>
                            <span class="text-600 text-110 text-blue align-middle" style="color: #0c4bab">${clientDetails.name}</span>
                        </div>
                        <div class="text-grey-m2">
                            <div class="my-1">
                                ${clientDetails.address}
                            </div>
                            <div class="my-1">
                                ${clientDetails.mail}
                            </div>
                            <div class="my-1"><i class="fa fa-phone fa-flip-horizontal text-secondary"></i>
                                <b>${clientDetails.mobileno}</b></div>
                        </div>
                    </div>

                    <div class="col-4 "></div>

                    <div class="col-4 text-left ">

                        <div class="mt-1 mb-2 text-secondary-m1 text-600 text-125">
                            Proforma Invoice
                        </div>

                        <div class="my-2"><i class="fa fa-circle text-blue-m2 text-xs mr-1"></i> <span
                                class="text-600 text-90">No:</span> <%--${invoice_no}--%>1 </div>

                        <div class="my-2"><i class="fa fa-circle text-blue-m2 text-xs mr-1"></i> <span
                                class="text-600 text-90">Issue Date:</span>
                            <script>document.write(date);</script>
                        </div>

                        <%--                            <div class="my-2"><i class="fa fa-circle text-blue-m2 text-xs mr-1"></i> <span class="text-600 text-90">Status:</span> <span class="badge badge-warning badge-pill px-25">Unpaid</span></div>--%>

                    </div>
                    <!-- /.col -->
                </div>

                <div class="mt-4">
                    <div class="row text-600 text-white bgc-default-tp1 py-25">
                        <div class="col-1">#</div>
                        <div class="col-5">Description</div>
                        <div class="col-2">Qty</div>
                        <div class="col-2">Unit Price</div>
                        <div class="col-2">Amount</div>
                    </div>

                    <c:forEach var="productObj" items="${products}">
                        <div class="text-95 text-secondary-d3" id="id1">
                            <div class="row mb-2 mb-sm-0 py-25 bgc-default-l4">
                                <div class="col-1">
                                    <fmt:parseNumber var="intDiscount" value="${productObj.discount}"
                                                     integerOnly="true"/>

                                    <c:choose>
                                        <c:when test="${not empty intDiscount}">
                                            <script>
                                                discount = ${productObj.discount + extraDiscount};
                                                extraDiscount = ${extraDiscount}
                                            </script>
                                        </c:when>
                                        <c:otherwise>
                                            <script>
                                                discount = discount;
                                            </script>
                                        </c:otherwise>
                                    </c:choose>

                                    <script>
                                        totalAmount = totalAmount + ${(productObj.quantity * orderQuantity) * productObj.price};
                                        totalCount = totalCount + 1;

                                    </script>
                                    <script>document.write(totalCount);</script>
                                </div>
                                <div class="col-5">${productObj.pname}</div>
                                <div class="col-2">${productObj.quantity} * ${orderQuantity} = ${productObj.quantity * orderQuantity}</div>
                                <div class="col-2">
                                    <fmt:formatNumber value="${productObj.price}" maxFractionDigits="2"/>
                                </div>
                                <div class="col-2">
                                    <fmt:formatNumber value="${(productObj.quantity * orderQuantity) * productObj.price}"
                                                      maxFractionDigits="2"/>
                                </div>
                            </div>

                                <%--  <div class="row mb-2 mb-sm-0 py-25">
                                      <div class="col-1">4</div>
                                      <div class="col-5">Consulting</div>
                                      <div class="col-2">1</div>
                                      <div class="col-2">$500</div>
                                      <div class="col-2">$500</div>
                                  </div>--%>
                        </div>
                    </c:forEach>

                    <div class="row border-b-2 brc-default-l2"></div>

                    <!-- or use a table instead -->
                    <!--
            <div class="table-responsive">
                <table class="table table-striped table-borderless border-0 border-b-2 brc-default-l1">
                    <thead class="bg-none bgc-default-tp1">
                        <tr class="text-white">
                            <th class="opacity-2">#</th>
                            <th>Description</th>
                            <th>Qty</th>
                            <th>Unit Price</th>
                            <th width="140">Amount</th>
                        </tr>
                    </thead>

                    <tbody class="text-95 text-secondary-d3">
                        <tr></tr>
                        <tr>
                            <td>1</td>
                            <td>Domain registration</td>
                            <td>2</td>
                            <td class="text-95">$10</td>
                            <td class="text-secondary-d2">$20</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            -->

                    <hr class="my-3">
                    <div class="row p-1 ml-2 mr-2">
                        <div class="col-7">
                        </div>
                        <div class="col-3" >

                            <p style="color: black">Grand Total</p>
                            <%--<p style="color: black">Discount (
                                <script>document.write(discount)</script>
                                % )
                            </p>--%>
                            <p>Discount ( ${discount } + <script>document.write(extraDiscount.toLocaleString())</script> %)

                            <hr class="my-3">
                            <p classs="my-1" style="color: black">Total</p>
                            <p style="color: black" >CGST ( 9% ) :</p>
                            <p style="color: black" >SGST ( 9% ) :</p>

                            <hr class="my-3">

                            <p style="color: black" >Payable :</p>

                        </div>
                        <div class="col-2">
                            <p style="color: black">
                                <script>document.write((totalAmount ^ 0).toLocaleString());</script>
                            </p>
                            <p style="color: black">- <span><script>
                                discountedPrice = totalAmount * discount / 100;
                                document.write((discountedPrice ^ 0).toLocaleString());
                            </script></span></p>
                            <hr class="my-3">
                            <p classs="my-1" style="color: black">
                                <span>&#8377; </span>
                                <script>
                                    document.write((totalAmount - discountedPrice ^ 0).toLocaleString());
                                </script>
                            </p>
                            <p style="color: black" >+
                                <script>
                                    document.write(((totalAmount - discountedPrice) * 9 /100 ^ 0).toLocaleString());
                                </script>
                            </p>
                            <p style="color: black" >+
                                <script>
                                    document.write(((totalAmount - discountedPrice) * 9 /100 ^ 0).toLocaleString());
                                </script>
                            </p>

                            <hr class="my-3">
                            <p style="color: black">
                                <span>&#8377; </span>
                                <script>
                                    document.write(((totalAmount - discountedPrice) + ((totalAmount - discountedPrice) * 9 /100) + ((totalAmount - discountedPrice) * 9 /100) ^ 0).toLocaleString());
                                </script>
                            </p>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
