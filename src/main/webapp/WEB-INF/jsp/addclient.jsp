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
    <%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js"></script>--%>
    <script src="/js/validate.js"></script>

    <link rel="stylesheet" type="text/css" href="/css/responsive.css"/>

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

<br>
<h3 id="display_name">
    <span onclick="window.location='/clientList'">Client List</span>
    <span> > ${type} client</span>
</h3>

<c:if test="${type.equals('add')}">

<form action="/addClientForm" method="get" id="form" name="myForm">
    </c:if>

    <c:if test="${type.equals('edit')}">

    <form action="/updateClientForm/${client.id}" method="get" id="form">

        </c:if>


        <div class="center">

            <div class="form-group col-md-8" hidden>
                <label for="id">Client ID</label>
                <input type="text" name="id"
                       <c:if test="${type.equals('add') && leadObj != ('null')}">value="${leadObj.id}"</c:if>
                       value="${client.id}" class="form-control" id="id">
            </div>

            <div class="form-group col-md-8">
                <label for="name">Client name <span class="spanerror">*</span></label>
                <input type="text" autocomplete="off" name="name"
                       <c:if test="${type.equals('add') && leadObj != ('null')}">value="${leadObj.name}"</c:if>
                       value="${client.name}" style="text-transform:capitalize" class="form-control required" id="name"
                       autocapitalize="sentences">
            </div>

            <div class="form-group col-md-8">
                <label for="address">Billed To Address<span class="spanerror">*</span></label>
                <input type="text" name="address" style="text-transform:capitalize" autocomplete="off"
                       <c:if test="${type.equals('add') && leadObj != ('null')}">value="${leadObj.address}"</c:if>
                       onkeydown="return /[a-z,0-9' ']/i.test(event.key)"
                       value="${client.address}" class="form-control" placeholder="Enter your Address" id="address"
                       required>
            </div>

            <div class="form-group col-md-8">
                <label for="address1">Shipped To Address</label>
                <input type="text" name="address1" style="text-transform:capitalize" autocomplete="off"
                       <c:if test="${type.equals('add') && leadObj != ('null')}">value="${leadObj.address}"</c:if>
                       onkeydown="return /[a-z,0-9' ']/i.test(event.key)"
                       value="${client.address1}" class="form-control" placeholder="Enter your Address" id="address1">
            </div>

            <div class="form-group col-md-8">
                <label for="floor">Floor<span class="spanerror">*</span></label>
                <input type="text" maxlength="3" autocomplete="off"
                       onkeypress="return event.charCode > 47 && event.charCode < 58;" pattern="[0-9]{5}"
                       name="floor" value="${client.floor}" class="form-control" id="floor" required>
            </div>

            <div class="form-group col-md-8"><label for="landmark">Landmark<span class="spanerror">*</span></label>
                <input type="text" autocapitalize="sentences" name="landmark" autocomplete="off"
                       value="${client.landmark}" class="form-control" id="landmark" required>
            </div>

            <div class="form-group col-md-8"><label for="city">City<span class="spanerror">*</span></label>
                <select class="form-select required" name="city" aria-label="Default select example" id="city">
                    <option value="none" selected disabled hidden>Select your city</option>
                    <option value="Nagpur" <c:if test="${client.city =='Nagpur'}"> selected </c:if>>Nagpur</option>
                    <option value="Pune" <c:if test="${client.city =='Pune'}"> selected </c:if>>Pune</option>
                    <option value="Mumbai" <c:if test="${client.city =='Mumbai'}"> selected </c:if>>Mumbai</option>
                </select>
            </div>

            <div class="form-group col-md-8">
                <label for="pincode">Pincode<span class="spanerror">*</span></label>
                <input type="text" maxlength="6" minlength="6"
                       onkeypress="return event.charCode > 47 && event.charCode < 58;" pattern="[0-9]{5}"
                       name="pincode" value="${client.pincode}" class="form-control" id="pincode" required>
            </div>

            <div class="form-group col-md-8"><label for="state">State<span class="spanerror">*</span></label>
                <select class="form-select required" name="state" aria-label="Default select example" id="state">
                    <option value="none" selected disabled hidden>Select your state</option>
                    <option value="Maharashtra" <c:if test="${client.state =='Maharashtra'}"> selected </c:if>>
                        Maharashtra
                    </option>
                    <option value="Punjab" <c:if test="${client.state =='Punjab'}"> selected </c:if>>Punjab</option>
                    <option value="Tamilnadu" <c:if test="${client.state =='Tamilnadu'}"> selected </c:if>>Tamilnadu
                    </option>
                    <%--                    <option value="Andra Pradesh" >Andra Pradesh</option>--%>
                    <%--                    <option value="Arunachal Pradesh">Arunachal Pradesh</option>--%>
                    <%--                    <option value="Assam">Assam</option>--%>
                    <%--                    <option value="Bihar">Bihar</option>--%>
                    <%--                    <option value="Chhattisgarh">Chhattisgarh</option>--%>
                    <%--                    <option value="Goa">Goa</option>--%>
                    <%--                    <option value="Gujarat">Gujarat</option>--%>
                    <%--                    <option value="Haryana">Haryana</option>--%>
                    <%--                    <option value="Himachal Pradesh">Himachal Pradesh</option>--%>
                    <%--                    <option value="Jammu and Kashmir">Jammu and Kashmir</option>--%>
                    <%--                    <option value="Jharkhand">Jharkhand</option>--%>
                    <%--                    <option value="Karnataka">Karnataka</option>--%>
                    <%--                    <option value="Kerala">Kerala</option>--%>
                    <%--                    <option value="Madya Pradesh">Madya Pradesh</option>--%>
                    <%--                    <option value="Maharashtra">Maharashtra</option>--%>
                    <%--                    <option value="Manipur">Manipur</option>--%>
                    <%--                    <option value="Meghalaya">Meghalaya</option>--%>
                    <%--                    <option value="Mizoram">Mizoram</option>--%>
                    <%--                    <option value="Nagaland">Nagaland</option>--%>
                    <%--                    <option value="Orissa">Orissa</option>--%>
                    <%--                    <option value="Punjab">Punjab</option>--%>
                    <%--                    <option value="Rajasthan">Rajasthan</option>--%>
                    <%--                    <option value="Sikkim">Sikkim</option>--%>
                    <%--                    <option value="Tamil Nadu">Tamil Nadu</option>--%>
                    <%--                    <option value="Telangana">Telangana</option>--%>
                    <%--                    <option value="Tripura">Tripura</option>--%>
                    <%--                    <option value="Uttaranchal">Uttaranchal</option>--%>
                    <%--                    <option value="Uttar Pradesh">Uttar Pradesh</option>--%>
                    <%--                    <option value="West Bengal">West Bengal</option>--%>
                    <%--                    <option disabled style="background-color:#aaa; color:#fff">UNION Territories</option>--%>
                    <%--                    <option value="Andaman and Nicobar Islands">Andaman and Nicobar Islands</option>--%>
                    <%--                    <option value="Chandigarh">Chandigarh</option>--%>
                    <%--                    <option value="Dadar and Nagar Haveli">Dadar and Nagar Haveli</option>--%>
                    <%--                    <option value="Daman and Diu">Daman and Diu</option>--%>
                    <%--                    <option value="Delhi">Delhi</option>--%>
                    <%--                    <option value="Lakshadeep">Lakshadeep</option>--%>
                    <%--                    <option value="Pondicherry">Pondicherry</option>--%>
                </select>
            </div>

            <div class="form-group col-md-8">
                <label for="gps">Gps location<span class="spanerror">*</span></label>
                <input type="text" autocomplete="off" onclick="getLocation()" name="gps"
                       value="${client.gps}" class="form-control" placeholder="1Gps location" id="gps" required>
            </div>

            <div class="form-group col-md-8">
                <label for="mail">Email<span class="spanerror">*</span></label>
                <input type="mail" name="mail" placeholder="Enter you Email" value="${client.mail}"
                       class="form-control" id="mail" required>
            </div>

            <div class="form-group col-md-8">
                <label for="mobile">Mobile no<span class="spanerror">*</span></label>
                <input type="number"
                       <c:if test="${type.equals('add') && leadObj != ('null')}">value="${leadObj.mobile}"</c:if>
                       onkeydown="javascript: return event.keyCode === 8 || event.keyCode === 46 ? true : !isNaN(Number(event.key))"
                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                       name="mobile" value="${client.mobile}" class="form-control" id="mobile"
                       placeholder="Mobile no"
                       maxlength="10" minlength="10" required>
            </div>

            <div class="form-group col-md-8"><label for="residence">Type of residence <span
                    class="spanerror">*</span></label>
                <select class="form-select required" name="residence" aria-label="Default select example"
                        id="residence">
                    <option value="none" selected disabled hidden>Select type of residence</option>
                    <option value="1 BHK"
                            <c:if test="${client.residence =='1 BHK'}"> selected </c:if>>1 BHK
                    </option>
                    <option value="2 BHK"
                            <c:if test="${client.residence =='2 BHK'}"> selected </c:if>>2 BHK
                    </option>
                    <option value="3 BHK"
                            <c:if test="${client.residence =='3 BHK'}"> selected </c:if>>3 BHK
                    </option>
                    <option value="5 BHK"
                            <c:if test="${client.residence =='5 BHK'}"> selected </c:if>>5 BHK
                    </option>
                    <option value="Bunglow"
                            <c:if test="${client.residence =='Bunglow'}"> selected </c:if>>Bunglow
                    </option>
                </select>

            </div>

            <div class="form-group col-md-8" hidden>
                <label for="installation">Registration Date<span class="spanerror">*</span></label>
                <input type="date" name="installation" readonly="readonly" value="${client.installation}"
                       class="form-control" id="installation" required>
            </div>

            <div class="form-group col-md-8"><label for="clientType">Client Type <span class="spanerror">*</span>
            </label>
                <select class="form-select required" name="clientType" aria-label="Default select example"
                        id="clientType" onchange="changeBusinessType(this)">
                    <option value="none" selected disabled hidden>Select client type</option>
                    <option value="Individual"
                            <c:if test="${type.equals('add') && leadObj != ('null')}">selected</c:if>
                            <c:if test="${client.clientType == 'Individual'}"> selected </c:if> >Individual
                    </option>
                    <option value="Business"
                            <c:if test="${client.clientType =='Business'}"> selected </c:if> >Business
                    </option>
                </select>
            </div>

            <div class="form-group col-md-8">
                <label for="businessType">Business Type<span class="spanerror">*</span> </label>
                <select class="form-select required" name="businessType" aria-label="Default select example"
                        id="businessType">
                    <option value="none" selected disabled hidden>Select Business type</option>
                    <option value="Architect" <c:if test="${client.businessType == 'Architect'}"> selected </c:if> >
                        Architect
                    </option>
                    <option value="Builder" <c:if test="${client.businessType == 'Builder'}"> selected </c:if> >
                        Builder
                    </option>
                    <option value="Furniture Store" <c:if
                            test="${client.businessType == 'Furniture Store'}"> selected </c:if> >Furniture Store
                    </option>
                    <option value="Interior Designer" <c:if
                            test="${client.businessType == 'Interior Designer'}"> selected </c:if> >Interior Designer
                    </option>
                    <option value="Electrician" <c:if
                            test="${client.businessType == 'Electrician'}"> selected </c:if> >Electrician
                    </option>
                    <option value="Hardware shop" <c:if
                            test="${client.businessType == 'Hardware shop'}"> selected </c:if> >Hardware shop
                    </option>
                    <option value="Employee" <c:if test="${client.businessType == 'Employee'}"> selected </c:if> >
                        Employee
                    </option>
                    <option value="Other"
                            <c:if test="${client.businessType == 'Other'}"> selected </c:if>>Other
                    </option>
                </select>
            </div>

            <div class="form-group col-md-8" <c:if test="${isSalesEmployeeLoggedIn.equals('true')}"> hidden </c:if> >
                <label for="empName">Sales Employee Name<span class="spanerror">*</span> </label>
                <select class="form-select required" name="empName" onchange="getInstallerID(this)"
                        aria-label="Default select example"
                        id="empName">
                    <option value="none" disabled selected hidden>Select Employee name</option>
                    <c:forEach var="item" items="${installeropt}">
                        <option  <c:if test="${item ==client.empName}"> selected </c:if>
                                <c:if test="${type.equals('add') && isSalesEmployeeLoggedIn.equals('true') && item == salesEmployeeName}">selected</c:if>
                                value="${item}">${item} </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group col-md-8" id="employeeName" hidden>
                <label for="empId">Sales Employee ID</label>
                <input type="text" readonly="readonly" name="empId"
                       <c:if test="${type.equals('add') && isSalesEmployeeLoggedIn.equals('true')}">value="${salesEmployeeId}"</c:if>
                <%--                       <c:if test="${businessClient == 'businessClientofClients'}">value="${installerID}"  </c:if>--%>
                       value="${client.empId}" <%--onclick="getInstallerName(this)"--%> class="form-control"
                       id="empId">
            </div>

            <div class="form-group col-md-8" hidden>
                <label for="companyID">Company ID</label>
                <input type="text" readonly="readonly" name="companyID"
                       <c:if test="${type.equals('add')}">value="${companyID}"</c:if>
                       value="${client.companyID}" class="form-control"
                       id="companyID">
            </div>

            <div class="form-group col-md-8"><label for="comment">Comment </label>
                <input type="text" name="comment" value="${client.comment}"
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
        document.getElementById('installation').value = new Date().toISOString().substring(0, 10);
    </script>
    </c:if>

    <script>

        $(document).ready(function () {

            $("#form").validate();

            <%--if (${businessClient == 'businessClientofClients'}) {--%>

            <%--    $("#other").removeAttr("hidden");--%>
            <%--}--%>

            <%--if (${client.reach_us =='Referred by'}) {--%>

            <%--    $("#other").removeAttr("hidden");--%>
            <%--}--%>

            <%--<c:if test="${businessClient == 'businessClientofClients'}">--%>

            <%--var x = document.getElementById("installerid").value;--%>

            <%--$.get("/getInstallerName?name=" + x, function (data) {--%>

            <%--    document.getElementById("installer_name").value = data;--%>
            <%--});--%>

            <%--</c:if>--%>
        });

        /*window.onbeforeunload = function () {

            $.get("/notAddingClient", function () {
            });

        }*/

        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (pos) {
                    //You have your locaton here
                    alert("Latitude: " + pos.coords.latitude +
                        "Longitude: " + pos.coords.longitude);
                    $('#gps').val(pos.coords.latitude + "," + pos.coords.longitude)

                });
            } else {
                alert("Geolocation is not supported by this browser.");
            }
        }

        function getInstallerID(installerName) {

            var iName = installerName.value;

            $.get("/getInstallerid?name=" + iName, function (data) {

                $('#empId').val(data);

                // $("#employeeName").removeAttr("hidden");
            });
        }

        function changeBusinessType(clienttype) {

            var iName = clienttype.value;

            if (iName == 'Individual') {

                $('#businessType').val('Other');
            }

        }

        /*function getInstallerName(installerid) {

            var id1 = installerid.value;

            $.get("/getInstallerName?name=" + id1, function (data) {

                // $('#installerid').val(data);
            });
        }*/

        /* var AndraPradesh = ["Anantapur","Chittoor","East Godavari","Guntur","Kadapa","Krishna","Kurnool","Prakasam","Nellore","Srikakulam","Visakhapatnam","Vizianagaram","West Godavari"];
         var ArunachalPradesh = ["Anjaw","Changlang","Dibang Valley","East Kameng","East Siang","Kra Daadi","Kurung Kumey","Lohit","Longding","Lower Dibang Valley","Lower Subansiri","Namsai","Papum Pare","Siang","Tawang","Tirap","Upper Siang","Upper Subansiri","West Kameng","West Siang","Itanagar"];
         var Assam = ["Baksa","Barpeta","Biswanath","Bongaigaon","Cachar","Charaideo","Chirang","Darrang","Dhemaji","Dhubri","Dibrugarh","Goalpara","Golaghat","Hailakandi","Hojai","Jorhat","Kamrup Metropolitan","Kamrup (Rural)","Karbi Anglong","Karimganj","Kokrajhar","Lakhimpur","Majuli","Morigaon","Nagaon","Nalbari","Dima Hasao","Sivasagar","Sonitpur","South Salmara Mankachar","Tinsukia","Udalguri","West Karbi Anglong"];
         var Bihar = ["Araria","Arwal","Aurangabad","Banka","Begusarai","Bhagalpur","Bhojpur","Buxar","Darbhanga","East Champaran","Gaya","Gopalganj","Jamui","Jehanabad","Kaimur","Katihar","Khagaria","Kishanganj","Lakhisarai","Madhepura","Madhubani","Munger","Muzaffarpur","Nalanda","Nawada","Patna","Purnia","Rohtas","Saharsa","Samastipur","Saran","Sheikhpura","Sheohar","Sitamarhi","Siwan","Supaul","Vaishali","West Champaran"];
         var Chhattisgarh = ["Balod","Baloda Bazar","Balrampur","Bastar","Bemetara","Bijapur","Bilaspur","Dantewada","Dhamtari","Durg","Gariaband","Janjgir Champa","Jashpur","Kabirdham","Kanker","Kondagaon","Korba","Koriya","Mahasamund","Mungeli","Narayanpur","Raigarh","Raipur","Rajnandgaon","Sukma","Surajpur","Surguja"];
         var Goa = ["North Goa","South Goa"];
         var Gujarat = ["Ahmedabad","Amreli","Anand","Aravalli","Banaskantha","Bharuch","Bhavnagar","Botad","Chhota Udaipur","Dahod","Dang","Devbhoomi Dwarka","Gandhinagar","Gir Somnath","Jamnagar","Junagadh","Kheda","Kutch","Mahisagar","Mehsana","Morbi","Narmada","Navsari","Panchmahal","Patan","Porbandar","Rajkot","Sabarkantha","Surat","Surendranagar","Tapi","Vadodara","Valsad"];
         var Haryana = ["Ambala","Bhiwani","Charkhi Dadri","Faridabad","Fatehabad","Gurugram","Hisar","Jhajjar","Jind","Kaithal","Karnal","Kurukshetra","Mahendragarh","Mewat","Palwal","Panchkula","Panipat","Rewari","Rohtak","Sirsa","Sonipat","Yamunanagar"];
         var HimachalPradesh = ["Bilaspur","Chamba","Hamirpur","Kangra","Kinnaur","Kullu","Lahaul Spiti","Mandi","Shimla","Sirmaur","Solan","Una"];
         var JammuKashmir = ["Anantnag","Bandipora","Baramulla","Budgam","Doda","Ganderbal","Jammu","Kargil","Kathua","Kishtwar","Kulgam","Kupwara","Leh","Poonch","Pulwama","Rajouri","Ramban","Reasi","Samba","Shopian","Srinagar","Udhampur"];
         var Jharkhand = ["Bokaro","Chatra","Deoghar","Dhanbad","Dumka","East Singhbhum","Garhwa","Giridih","Godda","Gumla","Hazaribagh","Jamtara","Khunti","Koderma","Latehar","Lohardaga","Pakur","Palamu","Ramgarh","Ranchi","Sahebganj","Seraikela Kharsawan","Simdega","West Singhbhum"];
         var Karnataka = ["Bagalkot","Bangalore Rural","Bangalore Urban","Belgaum","Bellary","Bidar","Vijayapura","Chamarajanagar","Chikkaballapur","Chikkamagaluru","Chitradurga","Dakshina Kannada","Davanagere","Dharwad","Gadag","Gulbarga","Hassan","Haveri","Kodagu","Kolar","Koppal","Mandya","Mysore","Raichur","Ramanagara","Shimoga","Tumkur","Udupi","Uttara Kannada","Yadgir"];
         var Kerala = ["Alappuzha","Ernakulam","Idukki","Kannur","Kasaragod","Kollam","Kottayam","Kozhikode","Malappuram","Palakkad","Pathanamthitta","Thiruvananthapuram","Thrissur","Wayanad"];
         var MadhyaPradesh = ["Agar Malwa","Alirajpur","Anuppur","Ashoknagar","Balaghat","Barwani","Betul","Bhind","Bhopal","Burhanpur","Chhatarpur","Chhindwara","Damoh","Datia","Dewas","Dhar","Dindori","Guna","Gwalior","Harda","Hoshangabad","Indore","Jabalpur","Jhabua","Katni","Khandwa","Khargone","Mandla","Mandsaur","Morena","Narsinghpur","Neemuch","Panna","Raisen","Rajgarh","Ratlam","Rewa","Sagar","Satna",
             "Sehore","Seoni","Shahdol","Shajapur","Sheopur","Shivpuri","Sidhi","Singrauli","Tikamgarh","Ujjain","Umaria","Vidisha"];
         var Maharashtra = ["Ahmednagar","Akola","Amravati","Aurangabad","Beed","Bhandara","Buldhana","Chandrapur","Dhule","Gadchiroli","Gondia","Hingoli","Jalgaon","Jalna","Kolhapur","Latur","Mumbai City","Mumbai Suburban","Nagpur","Nanded","Nandurbar","Nashik","Osmanabad","Palghar","Parbhani","Pune","Raigad","Ratnagiri","Sangli","Satara","Sindhudurg","Solapur","Thane","Wardha","Washim","Yavatmal"];
         var Manipur = ["Bishnupur","Chandel","Churachandpur","Imphal East","Imphal West","Jiribam","Kakching","Kamjong","Kangpokpi","Noney","Pherzawl","Senapati","Tamenglong","Tengnoupal","Thoubal","Ukhrul"];
         var Meghalaya = ["East Garo Hills","East Jaintia Hills","East Khasi Hills","North Garo Hills","Ri Bhoi","South Garo Hills","South West Garo Hills","South West Khasi Hills","West Garo Hills","West Jaintia Hills","West Khasi Hills"];
         var Mizoram = ["Aizawl","Champhai","Kolasib","Lawngtlai","Lunglei","Mamit","Saiha","Serchhip","Aizawl","Champhai","Kolasib","Lawngtlai","Lunglei","Mamit","Saiha","Serchhip"];
         var Nagaland = ["Dimapur","Kiphire","Kohima","Longleng","Mokokchung","Mon","Peren","Phek","Tuensang","Wokha","Zunheboto"];
         var Odisha = ["Angul","Balangir","Balasore","Bargarh","Bhadrak","Boudh","Cuttack","Debagarh","Dhenkanal","Gajapati","Ganjam","Jagatsinghpur","Jajpur","Jharsuguda","Kalahandi","Kandhamal","Kendrapara","Kendujhar","Khordha","Koraput","Malkangiri","Mayurbhanj","Nabarangpur","Nayagarh","Nuapada","Puri","Rayagada","Sambalpur","Subarnapur","Sundergarh"];
         var Punjab = ["Amritsar","Barnala","Bathinda","Faridkot","Fatehgarh Sahib","Fazilka","Firozpur","Gurdaspur","Hoshiarpur","Jalandhar","Kapurthala","Ludhiana","Mansa","Moga","Mohali","Muktsar","Pathankot","Patiala","Rupnagar","Sangrur","Shaheed Bhagat Singh Nagar","Tarn Taran"];
         var Rajasthan = ["Ajmer","Alwar","Banswara","Baran","Barmer","Bharatpur","Bhilwara","Bikaner","Bundi","Chittorgarh","Churu","Dausa","Dholpur","Dungarpur","Ganganagar","Hanumangarh","Jaipur","Jaisalmer","Jalore","Jhalawar","Jhunjhunu","Jodhpur","Karauli","Kota","Nagaur","Pali","Pratapgarh","Rajsamand","Sawai Madhopur","Sikar","Sirohi","Tonk","Udaipur"];
         var Sikkim = ["East Sikkim","North Sikkim","South Sikkim","West Sikkim"];
         var TamilNadu = ["Ariyalur","Chennai","Coimbatore","Cuddalore","Dharmapuri","Dindigul","Erode","Kanchipuram","Kanyakumari","Karur","Krishnagiri","Madurai","Nagapattinam","Namakkal","Nilgiris","Perambalur","Pudukkottai","Ramanathapuram","Salem","Sivaganga","Thanjavur","Theni","Thoothukudi","Tiruchirappalli","Tirunelveli","Tiruppur","Tiruvallur","Tiruvannamalai","Tiruvarur","Vellore","Viluppuram","Virudhunagar"];
         var Telangana = ["Adilabad","Bhadradri Kothagudem","Hyderabad","Jagtial","Jangaon","Jayashankar","Jogulamba","Kamareddy","Karimnagar","Khammam","Komaram Bheem","Mahabubabad","Mahbubnagar","Mancherial","Medak","Medchal","Nagarkurnool","Nalgonda","Nirmal","Nizamabad","Peddapalli","Rajanna Sircilla","Ranga Reddy","Sangareddy","Siddipet","Suryapet","Vikarabad","Wanaparthy","Warangal Rural","Warangal Urban","Yadadri Bhuvanagiri"];
         var Tripura = ["Dhalai","Gomati","Khowai","North Tripura","Sepahijala","South Tripura","Unakoti","West Tripura"];
         var UttarPradesh = ["Agra","Aligarh","Allahabad","Ambedkar Nagar","Amethi","Amroha","Auraiya","Azamgarh","Baghpat","Bahraich","Ballia","Balrampur","Banda","Barabanki","Bareilly","Basti","Bhadohi","Bijnor","Budaun","Bulandshahr","Chandauli","Chitrakoot","Deoria","Etah","Etawah","Faizabad","Farrukhabad","Fatehpur","Firozabad","Gautam Buddha Nagar","Ghaziabad","Ghazipur","Gonda","Gorakhpur","Hamirpur","Hapur","Hardoi","Hathras","Jalaun","Jaunpur","Jhansi","Kannauj","Kanpur Dehat","Kanpur Nagar","Kasganj","Kaushambi","Kheri","Kushinagar","Lalitpur","Lucknow","Maharajganj","Mahoba","Mainpuri","Mathura","Mau","Meerut","Mirzapur","Moradabad","Muzaffarnagar","Pilibhit","Pratapgarh","Raebareli","Rampur","Saharanpur","Sambhal","Sant Kabir Nagar","Shahjahanpur","Shamli","Shravasti","Siddharthnagar","Sitapur","Sonbhadra","Sultanpur","Unnao","Varanasi"];
         var Uttarakhand  = ["Almora","Bageshwar","Chamoli","Champawat","Dehradun","Haridwar","Nainital","Pauri","Pithoragarh","Rudraprayag","Tehri","Udham Singh Nagar","Uttarkashi"];
         var WestBengal = ["Alipurduar","Bankura","Birbhum","Cooch Behar","Dakshin Dinajpur","Darjeeling","Hooghly","Howrah","Jalpaiguri","Jhargram","Kalimpong","Kolkata","Malda","Murshidabad","Nadia","North 24 Parganas","Paschim Bardhaman","Paschim Medinipur","Purba Bardhaman","Purba Medinipur","Purulia","South 24 Parganas","Uttar Dinajpur"];
         var AndamanNicobar = ["Nicobar","North Middle Andaman","South Andaman"];
         var Chandigarh = ["Chandigarh"];
         var DadraHaveli = ["Dadra Nagar Haveli"];
         var DamanDiu = ["Daman","Diu"];
         var Delhi = ["Central Delhi","East Delhi","New Delhi","North Delhi","North East Delhi","North West Delhi","Shahdara","South Delhi","South East Delhi","South West Delhi","West Delhi"];
         var Lakshadweep = ["Lakshadweep"];
         var Puducherry = ["Karaikal","Mahe","Puducherry","Yanam"];


         $("#state").change(function(){
             var StateSelected = $(this).val();
             var optionsList;
             var htmlString = "";

             switch (StateSelected) {
                 case "Andra Pradesh":
                     optionsList = AndraPradesh;
                     break;
                 case "Arunachal Pradesh":
                     optionsList = ArunachalPradesh;
                     break;
                 case "Assam":
                     optionsList = Assam;
                     break;
                 case "Bihar":
                     optionsList = Bihar;
                     break;
                 case "Chhattisgarh":
                     optionsList = Chhattisgarh;
                     break;
                 case "Goa":
                     optionsList = Goa;
                     break;
                 case  "Gujarat":
                     optionsList = Gujarat;
                     break;
                 case "Haryana":
                     optionsList = Haryana;
                     break;
                 case "Himachal Pradesh":
                     optionsList = HimachalPradesh;
                     break;
                 case "Jammu and Kashmir":
                     optionsList = JammuKashmir;
                     break;
                 case "Jharkhand":
                     optionsList = Jharkhand;
                     break;
                 case  "Karnataka":
                     optionsList = Karnataka;
                     break;
                 case "Kerala":
                     optionsList = Kerala;
                     break;
                 case  "Madya Pradesh":
                     optionsList = MadhyaPradesh;
                     break;
                 case "Maharashtra":
                     optionsList = Maharashtra;
                     break;
                 case  "Manipur":
                     optionsList = Manipur;
                     break;
                 case "Meghalaya":
                     optionsList = Meghalaya ;
                     break;
                 case  "Mizoram":
                     optionsList = Mizoram;
                     break;
                 case "Nagaland":
                     optionsList = Nagaland;
                     break;
                 case  "Orissa":
                     optionsList = Orissa;
                     break;
                 case "Punjab":
                     optionsList = Punjab;
                     break;
                 case  "Rajasthan":
                     optionsList = Rajasthan;
                     break;
                 case "Sikkim":
                     optionsList = Sikkim;
                     break;
                 case  "Tamil Nadu":
                     optionsList = TamilNadu;
                     break;
                 case  "Telangana":
                     optionsList = Telangana;
                     break;
                 case "Tripura":
                     optionsList = Tripura ;
                     break;
                 case  "Uttaranchal":
                     optionsList = Uttaranchal;
                     break;
                 case  "Uttar Pradesh":
                     optionsList = UttarPradesh;
                     break;
                 case "West Bengal":
                     optionsList = WestBengal;
                     break;
                 case  "Andaman and Nicobar Islands":
                     optionsList = AndamanNicobar;
                     break;
                 case "Chandigarh":
                     optionsList = Chandigarh;
                     break;
                 case  "Dadar and Nagar Haveli":
                     optionsList = DadraHaveli;
                     break;
                 case "Daman and Diu":
                     optionsList = DamanDiu;
                     break;
                 case  "Delhi":
                     optionsList = Delhi;
                     break;
                 case "Lakshadeep":
                     optionsList = Lakshadeep ;
                     break;
                 case  "Pondicherry":
                     optionsList = Pondicherry;
                     break;
             }


             for(var i = 0; i < optionsList.length; i++){
                 htmlString = htmlString+"<option value='"+ optionsList[i] +"'>"+ optionsList[i] +"</option>";
             }
             $("#city").html(htmlString);

         });*/

    </script>

</body>
</html>