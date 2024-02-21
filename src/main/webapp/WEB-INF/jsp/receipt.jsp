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

<div class="container-fluid">
    <div class="row">
        <div class="header col-md-12" style="text-align: center">
            <h3>WIFY SYSTEMS Pvt.Ltd</h3>
            <p>C/O Harshal Realty, Salunke Wasti, opp. PCMC Primary School, Kiwale, Kiwale, Pune, Maharashtra 412101</p>
            <p>State Name: Maharashtra, Code : 27</p>
            <h5>Cash Receipt</h5>
        </div>
        <div class="header col-md-12">
            <p style="float: left">No : ${quotationNo}</p>
            <p style="float: right">Date :
                <script>document.write(date);</script>
            </p>
        </div>

    </div>

    <div class="row"
         style="margin: 0px; border-top: 1px solid black; border-bottom: 1px solid black; text-align: center">
        <div class="col col-9" style="border-right: 1px solid black;">Particulars</div>
        <div class="col col-3">Amount</div>
    </div>
    <div class="row" style="margin: 0px;">
        <div class="col col-9 py-3" style="border-right: 1px solid black; height: 20vh">
            <h5>Account:</h5> <h5 style="margin-left: 20px">${clientName}</h5>
        </div>
        <div class="col col-3 py-3" style="text-align: center; height: 20vh">

            <h5>
                <script>
                    var amountFormated = ${amount};
                    document.write(parseInt(amountFormated).toLocaleString());
                </script>
            </h5>
        </div>
    </div>

    <div class="row" style="margin: 0px;">
        <div class="col col-9 py-3" style="border-right: 1px solid black;">
            <h5>Through :</h5> <h5 style="margin-left: 20px">${through}</h5>
        </div>
        <div class="col col-3 py-3" style="text-align: center;">
        </div>
    </div>

    <div class="row" style="margin: 0px;">
        <div class="col col-9 py-3" style="border-right: 1px solid black;">
            <h5>Amount (in words) :</h5> <h5 id="word" style="margin-left: 20px"></h5>
        </div>
        <div class="col col-3 py-3" style="text-align: center;">
        </div>
    </div>


    <div class="row" style="margin: 0px; border-bottom: 1px solid black;">
        <div class="col col-9 py-3" style="border-right: 1px solid black;">
        </div>
        <div class="col col-3 py-3" style="text-align: center; border-top: 1px solid black;">
            <h5>
                <script>
                    document.write(parseInt(amountFormated).toLocaleString());
                </script>
            </h5>
        </div>
    </div>

    <div class="row" style="margin: 0px;">
        <div class="col col-8">
        </div>
        <div class="col col-4 my-5" style="text-align: center;">
            <p>Authorised Signatory</p>
        </div>
    </div>
</div>


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

    var amountInWOrds = ${amount};
    window.onload = function () {
        word.innerHTML = convertNumberToWords(amountInWOrds);
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