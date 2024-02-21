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
    var amt = 0;
    var extraDiscount = 0;
    var percentage = ${percentage};

    var finalPrice = 0;
    var amount = 0;
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
        <img src="/css/wifylogo.png" alt="" height="150px " width="150px" style=" float: left;height: 100px;width: 100px;
padding: 10px; margin-left: 10px; margin-bottom: 30px;">
        <div class="col-md-12">
            <div class="header_top text-center">
                <p style="margin-bottom: -5px; font-weight: bold; text-decoration: underline;margin-top: -100px;">TAX
                    INVOICE</p>
                <h2>${companyName.name}</h2>
                <h5>${companyName.address}</h5>
            </div>
            <div class="gst_sec" style="border-top: 1px solid black;">
                <h6 class=" mx-3" style="float: left;">GSTIN NO : ${companyName.gst} </h6>
                <h6 class=" mx-3" style="float: right;">Original for Recipient </h6>
            </div>
        </div>
    </div>
    <div class="row" style="margin: 0px;">
        <div style="border-top: 1px solid black; width: 60%;">
            <%--<P style="margin: 0px;">State code :32</P>
            <P style="margin: 0px;">State code :32</P>
            <P style="margin: 0px;">State code :32</P>
            <P style="margin: 0px;">Date: <script>document.write(date);</script></P>--%>
        </div>
        <div style="/*border-left: 2px solid black;*/ border-top: 1px solid black; width: 40%;">
            <%-- <P style="margin: 0px;">State code :32</P>
            <P style="margin: 0px;">State code :32</P>
            <P style="margin: 0px;">State code :32</P>
            <P style="margin: 0px;">State code :32</P>--%>
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
            <P style="margin: 0px;"> ${clientdetails.address1} </P>
            <P style="margin: 0px;"> ${clientdetails.mobile} </P>
            <P style="float: left;">GSTIN NO : </P>
            <P style="float: right;">State Code: 27</P>
        </div>
    </div>
    <div class="table">
        <table class="table table-bordered text-center" width="100%">
            <thead>
            <tr>
                <%--      <th scope="col" width="5%" >Sr no</th>
                      <th scope="col">Description</th>
                      <th scope="col">QTY</th>
                      <th scope="col">Rate</th>
                      <th scope="col">Total</th>--%>

                <th scope="col" width="5%">Sr no</th>
                <th scope="col">Description</th>
                <th scope="col">QTY</th>
                <th scope="col">Rate</th>
                <th scope="col">Total</th>
                <th scope="col">Discount</th>
                <th scope="col" width="15%">Discounted Price</th>
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

                    <td>
                        <script>
                            var x = (parseInt(${(orders.price * (orders.quantity * orderQuantity))}).toLocaleString());
                            x = x.toString();
                            var lastThree = x.substring(x.length - 3);
                            var otherNumbers = x.substring(0, x.length - 3);
                            if (otherNumbers != '')
                                lastThree = ',' + lastThree;
                            var res = otherNumbers.replace(/\B(?=(\d{2})+(?!\d))/g, ",") + lastThree;

                            document.write(x);

                        </script>
                    </td>

                    <script>
                        finalPrice = finalPrice + ${(orders.price * (orders.quantity * orderQuantity))};

                        <c:choose>
                        <c:when test="${orders.pname.contains('LED')}">
                        totalamount = totalamount +${(orders.price * (orders.quantity * orderQuantity))};
                        </c:when>
                        <c:otherwise>
                        totalamount = totalamount +${(orders.price * (orders.quantity * orderQuantity)) - (orders.price * (orders.quantity * orderQuantity)) * (discount + extraDiscount) / 100};
                        discountedPrice = discountedPrice + ${(orders.price * (orders.quantity * orderQuantity)) - (orders.price * (orders.quantity * orderQuantity)) * (discount + extraDiscount) / 100};
                        </c:otherwise>
                        </c:choose>

                    </script>

                    <c:choose>
                        <c:when test="${orders.pname.contains('LED')}">
                            <td> -</td>
                            <td>
                                <script>
                                    var discounted = ${(orders.price * (orders.quantity * orderQuantity))};
                                    document.write(parseInt(discounted).toLocaleString());</script>
                            </td>
                        </c:when>
                        <c:otherwise>
                            <td><%-- ${ discount + extraDiscount }--%>  ${extraDiscount } %</td>
                            <td>
                                <c:if test="${orders.packageName == ''}">
                                    <fmt:formatNumber
                                            value="${((orders.price * (orders.quantity * orderQuantity)) - (orders.price * (orders.quantity * orderQuantity)) * (extraDiscount) / 100) * percentage / 100}"
                                            minFractionDigits="0" maxFractionDigits="0"/>
                                </c:if>
                                <c:if test="${orders.packageName != ''}">
                                    <script>
                                        var applyPackageDiscount = ${orders.price * (orders.quantity * orderQuantity) - orders.price * (orders.quantity * orderQuantity) * (discount) / 100};
                                        console.log("1 >> " + applyPackageDiscount);
                                        var applyExtraDiscount = applyPackageDiscount - applyPackageDiscount * ${extraDiscount} /100;

                                        applyExtraDiscount = applyExtraDiscount  * percentage / 100;

                                        console.log("2 >> " + applyExtraDiscount);
                                        document.write((Math.round(applyExtraDiscount) ^ 0).toLocaleString());
                                    </script>
                                    <%--                    <fmt:formatNumber--%>
                                    <%--                            value="${orderbom.price * (orderbom.quantity * orderQuantity) - orderbom.price * (orderbom.quantity * orderQuantity) * (packageDiscount + extraDiscount) / 100}"--%>
                                    <%--                            minFractionDigits="0" maxFractionDigits="0"/>--%>
                                </c:if>

                            </td>
                        </c:otherwise>
                    </c:choose>

                        <%-- <td>

                                 ${(orders.price * orders.quantity * orderQuantity) * percentage / 100}

                         </td>--%>
                    <script>
                        <c:if test="${orders.packageName == ''}">
                        amount = amount + ${orders.price * (orders.quantity * orderQuantity)};
                        </c:if>
                    </script>

                    <script>
                        amt = amt + ${orders.price * (orders.quantity * orderQuantity)};
                        totalamount = totalamount +${(orders.price * (orders.quantity * orderQuantity)) - (orders.price * (orders.quantity * orderQuantity)) * (discount + extraDiscount) / 100};
                    </script>
                </tr>
            </c:forEach>

            <script>
                amt = amt * percentage / 100;
                totalamount = totalamount * percentage / 100;
            </script>

            </tbody>
        </table>
    </div>
    <div class="row" style="margin: 0px;">
        <div class="col col-md-6" style="border-top: 1px solid black;">
            <P class="text-center" style="margin: 0px; font-size: 15px; text-decoration: underline;">Invoice Value In
                words: </P>
            <%--<P class="text-center"
               onload="word.innerHTML=convertNumberToWords(parseInt((totalamount) + (totalamount * 0.09) + (totalamount * 0.09)))" style="margin: 0px; font-weight: bold">abcd
               </P>--%>
            <div id="word" style="margin: 0px; font-weight: bold"></div>

        </div>
        <div class="col col-md-6" style="border-left: 1px solid black; border-top: 1px solid black; margin: 0px;">
            <div class="row" style="margin: 0px;">
                <div style="width: 60%;">
                    <P style="margin: 0px; float: right;">Base Price: </P>
                </div>
                <div class="col col-md-4" style="border-left: 1px solid black; width: 40%;">

                    <b>
                        <span>&#8377;</span>
                        <script>
                            amount = amount + ${finalAmountOfPackage};
                            amount = amount * percentage / 100;
                            document.write(parseInt(amt).toLocaleString());</script>
                    </b>

                </div>
            </div>

            <div class="row" style="margin: 0px;"
                 <c:if test="${discount + extraDiscount == 0}">hidden</c:if> >
                <div style="width: 60%;">
                    <P style="margin: 0px; float: right;">Discount <%--(${discount + extraDiscount})%--%> : </P>
                </div>
                <div class="col col-md-4" style="border-left: 1px solid black;width: 40%;">
                    - <%--<span>&#8377;</span>--%>
                    <script>

                        console.log("amount >>>>>>> "+ amount);

                        var aaaa = amount - amount * ${extraDiscount} /100;
                        console.log("aaaa >> " + aaaa);
                        var bbbb = amount - aaaa;
                        console.log("bbbb >> " + bbbb);
                        var discountss = amt - (amount) + bbbb;
                        console.log("amt >> " + amt);
                        console.log("amount >> " + amount);
                        console.log(" == discountss >> " + discountss);

                        discount = ${extraDiscount};
                        document.write(parseInt(discountss).toLocaleString());

                        <%--discount = ${extraDiscount};--%>
                        <%--document.write(parseInt(amt * discount / 100).toLocaleString());--%>

                    </script>

                </div>
            </div>

            <div class="row" style="margin: 0px;"
                 <c:if test="${discount + extraDiscount == 0}">hidden</c:if> >
                <div style="width: 60%;">
                    <P style="margin: 0px; float: right;">Total: </P>
                </div>
                <div class="col col-md-4"
                     style="border-left: 1px solid black; border-top: 1px solid black; width: 40%;">
                    <b><span>&#8377;</span>
                        <script>
                            amount = amount - amount * discount / 100;
                            document.write(parseInt(amount).toLocaleString());</script>
                    </b>

                </div>
            </div>

            <div class="row" style="margin: 0px; ">
                <div style="width: 60%;">
                    <P style="margin: 0px; float: right;">SGST (9%) : </P>
                </div>
                <div class="col col-md-4" style="border-left: 1px solid black; width: 40%;">
                    <P style="margin: 0px;">
                        <b>
                            <span>&#8377;</span>
                            <script>document.write(parseInt(amount * 0.09).toLocaleString());</script>
                        </b>
                    </P>
                </div>
            </div>

            <div class="row" style="margin: 0px; ">
                <div style="width: 60%;">
                    <P style="margin: 0px; float: right;">CGST (9%) : </P>
                </div>
                <div class="col col-md-4" style="border-left: 1px solid black; width: 40%;">
                    <P style="margin: 0px;">
                        <b>
                            <span>&#8377;</span>
                            <script>document.write(parseInt(amount * 0.09).toLocaleString());</script>
                        </b>
                        <%--                        <b><script>document.write((((totalamount / 1.18) - (totalamount / 1.18) / 1.18) / 2).toLocaleString());</script></b>--%>
                    </P>
                </div>
            </div>

            <%-- <div class="row" style="margin: 0px; ">
                 <div style="width: 60%;">
                     <P style="margin: 0px; float: right;">IGST : </P>
                 </div>
                 <div class="col col-md-4" style="border-left: 1px solid black; width: 40%;">
                     <P style="margin: 0px;">

                     </P>
                 </div>
             </div>--%>

            <div class="row" style="margin: 0px; ">
                <div style="width: 60%;">
                    <P style="margin: 0px; float: right; font-weight: bold">Grand Total : </P>
                </div>
                <div style="border-left: 1px solid black; width: 40%;">
                    <P style="margin: 0px;">
                        <b>
                            <span>&#8377;</span>
                            <script>document.write(parseInt((amount) + (amount * 0.09) + (amount * 0.09)).toLocaleString());</script>
                        </b>
                    </P>
                </div>
            </div>

            <%--<div class="row" style="margin: 0px; ">
                <div style="width: 60%;">
                    <P style="margin: 0px; float: right; font-weight: bold">Our Offer : </P>
                </div>
                <div style="border-left: 1px solid black; width: 40%;">
                    <P style="margin: 0px;">
                        <b>
                            <span>&#8377;</span>
                            64,999
                        </b>
                    </P>
                </div>
            </div>--%>

            <%--   <div class="row" style="margin: 0px; ">
                   <div style="width: 60%;">
                       <P style="margin: 0px; float: right;">Freight charge: </P>
                   </div>
                   <div class="col col-md-4" style="border-left: 1px solid black; width: 40%;">
                       <P style="margin: 0px;"></P>
                   </div>
               </div>
               <div class="row" style="margin: 0px; ">
                   <div style="width: 60%;">
                       <P style="margin: 0px; float: right;">Loading & Packingg Charges: </P>
                   </div>
                   <div style="border-left: 1px solid black; width: 40%;">
                       <P style="margin: 0px;"></P>
                   </div>
               </div>--%>
        </div>
    </div>
    <%-- <div class="row" style="margin: 0px;">
         <div class="col col-md-6" style="border-top: 1px solid black;">
             <P class="text-center" style="margin: 0px; font-weight: bold; text-decoration: underline; ">Certified that the Perticulars given above are true and correct </P>
         </div>
         <div class="col col-md-6" style="border-left: 1px solid black; border-top: 1px solid black; margin: 0px;">
             <div class="row" style="margin: 0px;">
                 <div style="width: 75%;">
                     <P style="margin: 0px; float: right;">Round-off Charges: </P>
                 </div>
                 <div class="col col-md-4" style="border-left: 1px solid black; width: 25%;">
                     <P style="margin: 0px;"></P>
                 </div>
             </div>
             <div class="row" style="margin: 0px; ">
                 <div style="width: 75%;">
                     <P style="margin: 0px; float: right;">Invoice Total: </P>
                 </div>
                 <div class="col col-md-4" style="border-left: 1px solid black; width: 25%;">
                     <P style="margin: 0px;"></P>
                 </div>
             </div>
         </div>
     </div>--%>

    <div class="row" style="margin: 0px;">
        <div class="col col-md-6" style="border-top: 1px solid black;">
            <P class="text-center" style="margin: 0px; font-weight: bold; text-decoration: underline; ">Bank Details
                : </P>
            <P style="margin: 0px;">Name and Branch : HDFC BANK,RAVET,Pune</p>
            <P style="margin: 0px;">Account Number : 50200053375703</p>
            <P style="margin: 0px;">IFSC Code : HDFC0009606</p>
        </div>
        <div class="col col-md-6 text-center"
             style="border-left: 1px solid black; border-top: 1px solid black; margin: 0px;">
            <P class="text-center" style="margin: 0px; font-weight: bold; text-decoration: underline; ">
                For ${companyName.name}</P>
            <%--            <div style="margin: 0px; font-weight: bold;">${quotationnumber}</div>--%>
        </div>
    </div>
    <%-- <div class="row" style="margin: 0px;">
         <div class="col col-md-6 text-center" style="border-top: 1px solid black;">
             &lt;%&ndash;<P class="text-center" style="margin: 0px; font-weight: bold; text-decoration: underline; ">Terms & Conditions : </P>
             <P style="margin: 0px; ">1. Subject to Pune Jurisdiction.</p>
             <P style="margin: 0px; ">2. All Terms & Conditions applied.</p>&ndash;%&gt;
         </div>
         <div class="col col-md-6" style="border-left: 1px solid black; border-top: 1px solid black; margin: 0px; height: 60px">
             <P class="text-center" style="margin: 0px; font-weight: bold; text-decoration: underline; ">For Wify Systems</P>
         </div>
     </div>--%>
</div>
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
        word.innerHTML = convertNumberToWords(parseInt((amount) + (amount * 0.09) + (amount * 0.09)));
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