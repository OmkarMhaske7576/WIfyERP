<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang='en'>
<head>

    <script src="https://smtpjs.com/v3/smtp.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css"
          integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

    <link rel="stylesheet" href="/js/plugins/colorpicker/bootstrap-colorpicker-plus.min.css">
    <link rel="stylesheet" href="/js/plugins/scrollbar/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="/js/plugins/intro-tour/introjs.min.css">
    <link rel="stylesheet" href="/js/plugins/intro-tour/themes/introjs-modern.css">
    <link rel="stylesheet" href="/js/plugins/datepicker/datepicker.css">

    <link rel="stylesheet" type="text/css" href="/css/dripicon.css"/>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <link rel="stylesheet" type="text/css" href="/css/responsive.css"/>

    <script src="https://www.gstatic.com/firebasejs/7.19.1/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.19.1/firebase-auth.js"></script>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
          integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

    <style>

        .divider:after,
        .divider:before {
            content: "";
            flex: 1;
            height: 1px;
            background: #eee;
        }

        .h-custom {
            height: calc(100% - 73px);
        }

        @media (max-width: 450px) {
            .h-custom {
                height: 100%;
            }
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
<section class="vh-100">
    <div class="container-fluid h-custom">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-md-9 col-lg-6 col-xl-5">
                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
                     class="img-fluid" alt="Sample image">
            </div>
            <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
                <form <%--action="/loginForm"--%> method="get" id="form">

                    <div class="center">
                        <%--<div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                            <p class="lead fw-normal mb-0 me-3">Sign in with</p>
                            <button type="button" class="btn btn-primary btn-floating mx-1">
                                <i class="fab fa-facebook-f"></i>
                            </button>

                            <button type="button" class="btn btn-primary btn-floating mx-1">
                                <i class="fab fa-twitter"></i>
                            </button>

                            <button type="button" class="btn btn-primary btn-floating mx-1">
                                <i class="fab fa-linkedin-in"></i>
                            </button>
                        </div>

                        <div class="divider d-flex align-items-center my-4">
                            <p class="text-center fw-bold mx-3 mb-0">Or</p>
                        </div>--%>

                        <!-- Email input -->

                        <div id="div">

                            <p style="color:red" id="loginerror" hidden> Login Failed. Please try again. </p>

                            <div class="form-group mb-4" id="email">
                                <input type="email" name="inputEmail" id="inputEmail" class="form-control"
                                       value="Croissance@gmail.com" placeholder="Email address"/>
                            </div>

                            <!-- Password input -->
                            <div class="form-group mb-3" id="password">
                                <input type="password" name="inputPassword" id="inputPassword" class="form-control"
                                       value="111111" placeholder="Password"/>
                            </div>
                            <%--                            <input type="checkbox" onclick="myFunction('inputPassword')"> Show Password--%>


                            <div class="d-flex justify-content-between align-items-center" id="remember">
                                <!-- Checkbox -->
                                <div class="form-check mb-0" id="checkbox">
                                    <input class="form-check-input me-2" type="checkbox" value="" id="form2Example3"
                                           onclick="myFunction('inputPassword')"/>
                                    <label class="form-check-label" for="form2Example3">Show Password</label>
                                </div>
                                <a href="#" class="text-body" id="forgot" onclick="resetPassword()">Forgot password?</a>
                            </div>

                            <div class="text-center text-lg-start mt-4 pt-2" id="logincheck">
                                <button type="submit" class="btn btn-primary btn-lg" id="loginbtn"
                                <%--  style="padding-left: 2.5rem; padding-right: 2.5rem;"--%> >Login
                                </button>
                                <p class="small fw-bold mt-2 pt-1 mb-0">Don't have an account? <a href="#"
                                                                                                  onclick="registerUser()"
                                                                                                  class="link-danger">Register</a>
                                </p>
                            </div>
                        </div>

                        <%-- ------------------------------- Forgot Password ------------------------------%>

                        <div id="div2" hidden>

                            <div class="form-group mb-4" id="resEmail">
                                <input type="email" name="resEmailbtn" id="resEmailbtn" class="form-control"
                                       value="" placeholder="Enter your Email"/>
                            </div>

                            <button type="button" class="btn btn-primary btn-sm ml-2" id="resPassword">
                                Reset Password
                            </button>
                        </div>

                        <%-- ------------------------------ Registeer User ------------------------------%>

                        <div id="div1" hidden>
                            <div class="form-group mb-4" id="regName">
                                <input type="text" name="text" id="namebtn" class="form-control"
                                       value="" placeholder="Enter your Name"/>
                            </div>

                            <div class="form-group mb-4" id="regEmail">
                                <input type="email" name="inputEmail" id="emailbtn" class="form-control"
                                       value="" placeholder="Enter your Email"/>
                            </div>

                            <!-- Password input -->
                            <div class="form-group mb-3" id="regPassword">
                                <input type="password" name="inputPassword" id="passwordbtn" class="form-control"
                                       value="" placeholder="Enter your Password"/>
                            </div>
                            <input type="checkbox" onclick="myFunction('passwordbtn')"> Show Password
                            <br><br>

                            <button type="submit" class="btn btn-primary btn-lg" id="regLogin"
                            <%--  style="padding-left: 2.5rem; padding-right: 2.5rem;"--%> >Register
                            </button>
                        </div>

                        <%--                        ---------------------- End ----------------------------%>

                    </div>

                </form>
            </div>
        </div>
    </div>
    <div
            class="d-flex flex-column flex-md-row text-center text-md-start justify-content-between py-4 px-4 px-xl-5 bg-primary">
        <!-- Copyright -->
        <div class="text-white mb-3 mb-md-0">
            Copyright © 2020. All rights reserved.
        </div>
        <!-- Copyright -->

        <!-- Right -->
        <div>
            <a href="#!" class="text-white me-4">
                <i class="fab fa-facebook-f"></i>
            </a>
            <a href="#!" class="text-white me-4">
                <i class="fab fa-twitter"></i>
            </a>
            <a href="#!" class="text-white me-4">
                <i class="fab fa-google"></i>
            </a>
            <a href="#!" class="text-white">
                <i class="fab fa-linkedin-in"></i>
            </a>
        </div>
        <!-- Right -->
    </div>
</section>


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
<!-- The core Firebase JS SDK is always required and must be listed first -->
<script src="https://www.gstatic.com/firebasejs/7.19.0/firebase-app.js"></script>

<!-- TODO: Add SDKs for Firebase products that you want to use
     https://firebase.google.com/docs/web/setup#available-libraries -->
<script src="https://www.gstatic.com/firebasejs/7.19.0/firebase-analytics.js"></script>
<script defer src="https://www.gstatic.com/firebasejs/7.19.0/firebase-auth.js"></script>


<script>
    $(document).ready(function () {

        // history.pushState(null, document.title, location.href);
        // window.addEventListener('popstate', function (event) { history.pushState(null, document.title, location.href); });

        if (window.location.href != window.location.origin + "/") {

            console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>. ")

            console.log("window.location.href >> " + window.location.href)

            console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>. ")

            console.log("window.location.href >> " + window.location.href)

            //window.location.href = window.location.origin + "/"
        }


        if (window.performance && window.performance.navigation.type == window.performance.navigation.TYPE_BACK_FORWARD) {

            // alert("Back arrow pressed event>>> ");

            // location.reload();
        }
    });

    function myFunction(subject) {

        // alert(">> "+ subject);
        var x = document.getElementById(subject);
        if (x.type === "password") {
            x.type = "text";
        } else {
            x.type = "password";
        }
    }

</script>

<script>

    function registerUser() {

        $("#div").attr("hidden", "hidden");

        // $("#email").attr("hidden", "hidden");
        //
        // $("#password").attr("hidden", "hidden");
        //
        // $("#checkbox").attr("hidden", "hidden");
        //
        // $("#forgot").attr("hidden", "hidden");
        //
        // $("#logincheck").attr("hidden", "hidden");


        $("#div1").removeAttr("hidden");
        // $("#regEmail").removeAttr("hidden");
        //
        // $("#regPassword").removeAttr("hidden");
        //
        // $("#regName").removeAttr("hidden");
        //
        // $("#regLogin").removeAttr("hidden");

    }

    const firebaseConfig = {
        apiKey: "AIzaSyAiOyM418Yh4O8oYpj5Jp4lFyTyIPIsVx0",
        authDomain: "wifyerp-1febf.firebaseapp.com",
        databaseURL: "https://wifyerp-1febf-default-rtdb.firebaseio.com",
        projectId: "wifyerp-1febf",
        storageBucket: "wifyerp-1febf.appspot.com",
        messagingSenderId: "310166809740",
        appId: "1:310166809740:web:d3234f12c9b4fc77969fa9",
        measurementId: "G-YV3DGE51L2"
    };
    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
    firebase.analytics();

    var loginemail = document.getElementById("inputEmail");
    var loginpassword = document.getElementById("inputPassword");
    var loginbtn = document.getElementById("loginbtn");

    loginbtn.onclick = function () {

        loginbtn.disabled = true;
        loginbtn.textContent = "Logging In Please Wait.."
        firebase.auth().signInWithEmailAndPassword(loginemail.value, loginpassword.value).then(function (response) {
            console.log(response);
            loginbtn.disabled = false;
            loginbtn.textContent = "Sign In"
            var userobj = response.user;
            var token = userobj.xa;
            if (token != null && token != undefined && token != "") {

                $.get("/managerLoggedInCheck?name=" + userobj.email.toString(), function (data) {

                    console.log("data >> "+ data);

                    console.log("Inside Admin Panel >> ")

                    console.log("Email >> "+ data.split("#")[1]);

                    if (data.split("#")[0] == 'Admin'){

                        setCookie("token",userobj.uid.toString(),60);

                        setCookie("email",btoa(userobj.email.toString()),60);

                        window.location = '/home';
                    }
                    else if (data.split("#")[0] == 'Manager'){

                        setCookie("token",userobj.uid.toString(),60);

                        setCookie("email",btoa(data.split("#")[1]),60);

                        setCookie("manager",btoa(userobj.email.toString()),60);

                        window.location = '/home';
                    }

                    else if (data.split("#")[0] == 'SalesEmployee'){

                        setCookie("token",userobj.uid.toString(),60);

                        setCookie("email",btoa(data.split("#")[1]),60);

                        setCookie("SalesEmployee",btoa(userobj.email.toString()),60);

                        window.location = '/home';
                    }

                    else if (data.split("#")[0] == 'Employee'){

                        setCookie("token",userobj.uid.toString(),60);

                        setCookie("email",btoa(data.split("#")[1]),60);

                        setCookie("Employee",btoa(userobj.email.toString()),60);

                        window.location = '/home';
                    }

                });

            }
        }).catch(function (error) {
            console.log(error);
            loginbtn.disabled = false;
            loginbtn.textContent = "Sign In";

            // alert("Invalid email or password");

            $("#loginerror").removeAttr("hidden");
            setTimeout(function () {
                $("#loginerror").attr("hidden", "hidden");
            }, 5000);

        })
    }

    function setCookie(name, value) {
      /*  var expires = "";

        var date = new Date();
        date.setTime(date.getTime() + (7 * 24 * 60 * 60));
        expires = "; expires=" + date.toUTCString();

        document.cookie = name + "=" + (value || "") + expires + "; path=/";
*/
        const cookieName = name;
        const cookieValue = value;
        const daysToExpire = new Date(2147483647 * 1000).toUTCString();
        document.cookie = cookieName + '=' + cookieValue + '; expires=' + daysToExpire;
    }

    var registerbtn = document.getElementById("regLogin");
    var lEmail = document.getElementById("emailbtn");
    var lPassword = document.getElementById("passwordbtn");

    registerbtn.onclick = function () {

        registerbtn.disabled = true;
        registerbtn.textContent = "Registering User.."

        firebase.auth().createUserWithEmailAndPassword(lEmail.value, lPassword.value).then(function (response) {
            console.log(response);

            window.location = '/';
        })
            .catch(function (error) {
                console.log(error);
                registerbtn.disabled = false;
                registerbtn.textContent = "Register"
            })
    }

    var resEmailbtn = document.getElementById("resEmailbtn");

    var resPassword = document.getElementById("resPassword");

    resPassword.onclick = function () {

        resPassword.disabled = true;
        resPassword.textContent = "Resetting Password"

        firebase.auth().sendPasswordResetEmail(resEmailbtn.value).then(() => {

            alert("Please go to " + resEmailbtn.value + " for password Reset. ");

            window.location = '/';

        }).catch(function (error) {

            console.log("Error >> " + error);
        });
    }

    function resetPassword() {

        $("#div").attr("hidden", "hidden");

        $("#div2").removeAttr("hidden");
    }

</script>

<script type="text/javascript">
    function preventBack() {
        window.history.forward();
    }

    setTimeout("preventBack()", 0);

    window.onunload = function () {
        null
    };

</script>

</body>
</html>