<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<script>
    var today = new Date();
    var date = today.getDate() + '-' + (today.getMonth() + 1) + '-' + today.getFullYear();
</script>
<style>
    .btn-light {
        color: #757984;
        background-color: #f5f6f9;
        border-color: #dddfe4;
    }
</style>
<script>
    var totalcount = 0;
    var totalamount = 0;
    var amount = 0;
    var discount = 0;
</script>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.debug.js"></script>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"
            integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <title>Document</title>
</head>
<body style="overflow-x: auto">
<div class="conatiner" id="maindiv" style="border: 2px solid black; margin: 10px;">
    <div class="row">
        <img src="/css/wifylogo.png" alt="" height="150px " width="150px"
             style=" float: left;height: 100px;width: 100px;padding: 10px; margin-left: 10px; margin-bottom: 30px;">
        <div class="col-md-12">
            <div class="header_top text-center">
                <p style="margin-bottom: -5px; font-weight: bold; text-decoration: underline;margin-top: -100px;">
                    QUOTATION</p>
                <h2>${company.name}</h2>
                <h5>${company.address}</h5>
                <%--                <h2>WIFY SYSTEMS PVT.LTD</h2>--%>
                <%--                <h5>Harshal Realty,Opposite pcmc public school,Kiwale,Ravet-412101. </h5>--%>
            </div>
            <div class="gst_sec" style="border-top: 1px solid black;">
                <h6 class=" mx-3" style="float: left;">GSTIN NO : ${company.gst} </h6>
                <h6 class=" mx-3" style="float: right;">Original for Recipient </h6>
            </div>
        </div>
    </div>
    <div class="row" style="margin: 0px;">
        <div style="border-top: 1px solid black; width: 60%;">
        </div>
        <div style="/*border-left: 2px solid black;*/ border-top: 1px solid black; width: 40%;">
            <P style="margin: 0px; float: right">Date:
                <script>document.write(date);</script>
            </P>
        </div>
    </div>
    <div class="row" style="margin: 0px; background-color : skyblue">
        <div class="col col-md-6" style="border-top: 1px solid black;">
            <P style="margin: 0px;">Details of the Receiver (Billed To)</P>
        </div>
        <div class="col col-md-6" style="border-left: 1px solid black; border-top: 1px solid black;">
            <P style="margin: 0px;">Details of consignee(Shipped To)</P>
        </div>
    </div>
    <div class="row" style="margin: 0px;">
        <div class="col col-md-6" style="border-top: 1px solid black; border-bottom: 1px solid black;">
            <P style="margin: 0px; font-weight: bold; ">Name : ${clientdetails.name}</P>
            <P style="margin: 0px;"> ${clientdetails.address} </P>
            <P style="margin: 0px;"> ${clientdetails.mobile} </P>
            <P style="float: left;">GSTIN NO : </P>
            <P style="float: right;">State Code: 27</P>
        </div>
        <div class="col col-md-6"
             style="border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;">
            <P style="margin: 0px; font-weight: bold; ">Name : ${clientdetails.name}</P>
            <P style="margin: 0px;"> ${clientdetails.address} </P>
            <P style="margin: 0px;"> ${clientdetails.mobile} </P>
            <P style="float: left;">GSTIN NO : </P>
            <P style="float: right;">State Code: 27</P>
        </div>
    </div>
    <div class="table">
        <table class="table table-bordered text-center" width="100%">
            <thead>
            <tr>
                <th scope="col" width="5%">Sr no</th>
                <th scope="col">Description</th>
                <th scope="col">QTY</th>
                <th scope="col">Rate</th>
                <th scope="col">Total</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="orders" items="${orderdetails}">
                <tr>
                    <td scope="row">
                        <script> totalcount = totalcount + 1; </script>
                        <script>document.write(totalcount);</script>
                    </td>

                    <c:choose>
                        <c:when test="${orders.pname.equals('Generic')}">
                            <td>${orders.pname} (Cover 3 Switches)</td>
                        </c:when>
                        <c:when test="${orders.pname.contains('Controller')}">
                            <td>${orders.pname} (Generic = ${orders.generic}, Power = ${orders.power})</td>
                        </c:when>
                        <c:otherwise>
                            <td>${orders.pname}</td>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${orders.pname.contains('Track')}">
                            <td>${orders.quantity * orderQuantity} sq.ft</td>
                        </c:when>
                        <c:otherwise>
                            <td>${orders.quantity * orderQuantity}</td>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${orders.pname.contains('Track')}">
                            <td>${orders.price} (per sq.ft)</td>
                        </c:when>
                        <c:otherwise>
                            <td>${orders.price}</td>
                        </c:otherwise>
                    </c:choose>

                    <script>
                        <c:if test="${orders.packageName == ''}">
                            amount = amount + ${orders.price * (orders.quantity * orderQuantity)};
                        </c:if>

                        totalamount = totalamount +${(orders.price * (orders.quantity * orderQuantity))};
                    </script>

                    <td>
                        <script>
                            var FinalDiscountedPrice =  ${orders.price * orders.quantity * orderQuantity};
                            document.write(parseInt(FinalDiscountedPrice).toLocaleString());</script>

                            <%--                            ${orders.price * orders.quantity * orderQuantity}--%>
                    </td>

                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>
    <div class="row" style="margin: 0px;">
        <div class="col col-md-6" style="border-top: 1px solid black;">
            <P class="text-center" style="margin: 0px; font-size: 15px; text-decoration: underline;">Invoice Value In
                words: </P>word
            <div id="word" style="margin: 0px; font-weight: bold"></div>
            <br>

        </div>
        <div class="col col-md-6" style="border-left: 1px solid black; border-top: 1px solid black; margin: 0px;">
            <div class="row" style="margin: 0px;">
                <div style="width: 60%;">
                    <P style="margin: 0px; float: right;">Total: </P>
                </div>
                <div class="col col-md-4" style="width: 40%;">
                    <b>
                        <span>&#8377;</span>
                        <script>
                            amount = amount + ${finalAmountOfPackage};
                            document.write(parseInt(totalamount).toLocaleString());
                        </script>
                    </b>

                </div>
            </div>

            <div class="row" style="margin: 0px;"
                 <c:if test="${discount + extraDiscount == 0}">hidden</c:if> >
                <div style="width: 60%;">
                    <P style="margin: 0px; float: right;">Discount <%--(${discount + extraDiscount})%--%> : </P>
                </div>
                <div class="col col-md-4" style="width: 40%;">
                    - <span>&#8377;</span>
                    <script>

                        var aaaa = amount - amount * ${extraDiscount} /100;
                        var bbbb = amount - aaaa;
                        var discountss = totalamount - (amount) + bbbb;

                        discount = ${extraDiscount};
                        document.write(parseInt(discountss).toLocaleString());</script>

                </div>
            </div>

            <div class="row" style="margin: 0px; ">
                <div style="width: 60%;">
                    <P style="margin: 0px; float: right; font-weight: bold">Grand Total : </P>
                </div>
                <div style="width: 40%;">
                    <P style="margin: 0px;">
                        <b>
                            <span>&#8377;</span>
                            <script>
                                document.write(parseInt(amount - amount * discount / 100).toLocaleString());</script>
                        </b>
                    </P>
                </div>
            </div>

        </div>
    </div>

    <div class="row" style="margin: 0px;">
        <div class="col col-md-6" style="border-top: 1px solid black;">
            <P class="text-center" style="margin: 0px; font-weight: bold; text-decoration: underline; ">Bank Details
                : </P>
            <P style="margin: 0px;">Name and Branch : HDFC BANK,RAVET,Pune</p>
            <P style="margin: 0px;">Account Number : 50200053375703</p>
            <P style="margin: 0px;">IFSC Code : HDFC0009606</p>
        </div>
        <div class="col col-md-6 text-center"
             style="border-left: 1px solid black; border-top: 1px solid black; margin: 0px">
            <P class="text-center" style="margin: 0px; font-weight: bold; text-decoration: underline; ">
                For ${company.name}</P>
        </div>

    </div>

</div>

<P class="text-left" style="margin-left: 10px ">* GST Applicable as per rules.</P>
<br>
<div class="page-tools">
    <div class="action-buttons">
        <a class="btn bg-primary btn-light mx-1px text-95 " id="btn" onclick="printpage()" href="#" data-title="Print">
            <i class="mr-1 fa fa-print text-primary-m1 text-120 w-2"></i>
            Print
        </a>
    </div>
</div>
<script>
    function float2int(value) {
        return value | 0;
    }
</script>
<script>
    function printpage() {
        var printButton = document.getElementById("btn");
        printButton.style.visibility = 'hidden';
        <%--document.title = window.parent.document.title = ${clientdetails.name};--%>
        window.print();
        printButton.style.visibility = 'visible';
    }

    window.onload = function () {
        word.innerHTML = convertNumberToWords(parseInt(amount - amount * discount / 100));
    }

    function convertNumberToWords(amount) {

        var words = new Array();
        words[0] = '';
        words[1] = 'One';
        words[2] = 'Two';
        words[3] = 'Three';
        words[4] = 'Four';
        words[5] = 'Five';
        words[6] = 'Six';
        words[7] = 'Seven';
        words[8] = 'Eight';
        words[9] = 'Nine';
        words[10] = 'Ten';
        words[11] = 'Eleven';
        words[12] = 'Twelve';
        words[13] = 'Thirteen';
        words[14] = 'Fourteen';
        words[15] = 'Fifteen';
        words[16] = 'Sixteen';
        words[17] = 'Seventeen';
        words[18] = 'Eighteen';
        words[19] = 'Nineteen';
        words[20] = 'Twenty';
        words[30] = 'Thirty';
        words[40] = 'Forty';
        words[50] = 'Fifty';
        words[60] = 'Sixty';
        words[70] = 'Seventy';
        words[80] = 'Eighty';
        words[90] = 'Ninety';
        amount = amount.toString();
        var atemp = amount.split(".");
        var number = atemp[0].split(",").join("");
        var n_length = number.length;
        var words_string = "";

        words_string += "Rupees: ";
        if (n_length <= 9) {
            var n_array = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0);
            var received_n_array = new Array();
            for (var i = 0; i < n_length; i++) {
                received_n_array[i] = number.substr(i, 1);
            }
            for (var i = 9 - n_length, j = 0; i < 9; i++, j++) {
                n_array[i] = received_n_array[j];
            }
            for (var i = 0, j = 1; i < 9; i++, j++) {
                if (i == 0 || i == 2 || i == 4 || i == 7) {
                    if (n_array[i] == 1) {
                        n_array[j] = 10 + parseInt(n_array[j]);
                        n_array[i] = 0;
                    }
                }
            }
            value = "";
            for (var i = 0; i < 9; i++) {
                if (i == 0 || i == 2 || i == 4 || i == 7) {
                    value = n_array[i] * 10;
                } else {
                    value = n_array[i];
                }
                if (value != 0) {
                    words_string += words[value] + " ";
                }
                if ((i == 1 && value != 0) || (i == 0 && value != 0 && n_array[i + 1] == 0)) {
                    words_string += "Crores ";
                }
                if ((i == 3 && value != 0) || (i == 2 && value != 0 && n_array[i + 1] == 0)) {
                    words_string += "Lacs ";
                }
                if ((i == 5 && value != 0) || (i == 4 && value != 0 && n_array[i + 1] == 0)) {
                    words_string += "Thousand ";
                }
                if (i == 6 && value != 0 && (n_array[i + 1] != 0 && n_array[i + 2] != 0)) {
                    words_string += "Hundred and ";
                } else if (i == 6 && value != 0) {
                    words_string += "Hundred ";
                }

            }
            words_string = words_string.split("  ").join(" ");
        }
        words_string += "only."
        return words_string;
    }


</script>
</body>
</html>