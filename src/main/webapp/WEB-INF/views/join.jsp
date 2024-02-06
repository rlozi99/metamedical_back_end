<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Fonts -->
    <link rel="dns-prefetch" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css?family=Raleway:300,400,600" rel="stylesheet" type="text/css">

    <link rel="icon" href="Favicon.png">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">


    <!-- 네이게이션  -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>회원가입</title>

    <script>
        function validateId() {
            var id = document.getElementById("full_name").value;
            var regex = /^[a-zA-Z0-9]+$/;
            var errorMessage = document.getElementById("id-error-message");

            if (id === "") {
                errorMessage.textContent = "아이디를 입력하세요";
                return false;
            } else if (!regex.test(id)) {
                errorMessage.textContent = "아이디는 영문자와 숫자만 입력 가능합니다";
                return false;
            }

            errorMessage.textContent = "";
            return true;
        }

        function validatePassword() {
            var password = document.getElementById("email_address").value;
            var regex = /^[a-zA-Z0-9]+$/;
            var errorMessage = document.getElementById("password-error-message");

            if (password === "") {
                errorMessage.textContent = "비밀번호를 입력하세요";
                return false;
            } else if (password.length < 4 || password.length > 10) {
                errorMessage.textContent = "비밀번호는 최소 4자리부터 최대 10자리입니다.";
                return false;
            } else if (!regex.test(password)) {
                errorMessage.textContent = "비밀번호는 영문자와 숫자만 입력 가능합니다";
                return false;
            }

            errorMessage.textContent = "";
            return true;
        }

        function validateName() {
            var name = document.getElementById("user_name").value;
            var regex = /^[가-힣]+$/;
            var errorMessage = document.getElementById("name-error-message");

            if (name === "") {
                errorMessage.textContent = "이름을 입력하세요";
                return false;
            } else if (!regex.test(name)) {
                errorMessage.textContent = "이름은 한글만 입력 가능합니다";
                return false;
            }

            errorMessage.textContent = "";
            return true;
        }

        function validatePhone() {
            var phone = document.getElementById("phone_number").value;
            var regex = /^01([0|1|6|7|8|9])\d{7,8}$/;
            var errorMessage = document.getElementById("phone-error-message");

            if (phone === "") {
                errorMessage.textContent = "전화번호를 입력하세요";
                return false;
            } else if (!regex.test(phone)) {
                errorMessage.textContent = "올바른 전화번호 형식이 아닙니다";
                return false;
            }

            errorMessage.textContent = "";
            return true;
        }

        function validateAddress() {
            var address = document.getElementById("present_address").value;
            var errorMessage = document.getElementById("address-error-message");

            if (address === "") {
                errorMessage.textContent = "주소를 입력하세요";
                return false;
            }

            errorMessage.textContent = "";
            return true;
        }

        function validateAge() {
            var age = document.getElementById("age").value;
            var errorMessage = document.getElementById("age-error-message");

            if (age === "") {
                errorMessage.textContent = "나이를 입력하세요";
                return false;
            } else if (age < 20 || age > 99) {
                errorMessage.textContent = "나이는 20세부터 99세까지 입력 가능합니다";
                return false;
            }

            errorMessage.textContent = "";
            return true;
        }
    </script>
</head>
<body>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
    <div class="collapse navbar-collapse" id="collapsibleNavbar">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="index">Home</a>
            </li>
            <!--<li class="nav-item">
              <a class="nav-link" href="board">Board</a>
            </li> -->
        </ul>
    </div>
</nav>

<main class="my-form">
    <div class="cotainer">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">Register</div>
                    <div class="card-body">
                        <form action="join" id="signupForm" method="post" modelAttribute="userDto">
                            <div class="form-group row">
                                <label for="full_name" class="col-md-4 col-form-label text-md-right">Id</label>
                                <div class="col-md-6">
                                    <input type="text" id="full_name" class="form-control" name="id" onblur="validateId()">
                                    <span id="id-error-message" class="text-danger"></span>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label for="email_address" class="col-md-4 col-form-label text-md-right">Password</label>
                                <div class="col-md-6">
                                    <input type="password" id="email_address" class="form-control" name="password" onblur="validatePassword()">
                                    <span id="password-error-message" class="text-danger"></span>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label for="user_name" class="col-md-4 col-form-label text-md-right">Name</label>
                                <div class="col-md-6">
                                    <input type="text" id="user_name" class="form-control" name="name" onblur="validateName()">
                                    <span id="name-error-message" class="text-danger"></span>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label for="phone_number" class="col-md-4 col-form-label text-md-right">Phone Number</label>
                                <div class="col-md-6">
                                    <input type="text" id="phone_number" class="form-control" name="phone" onblur="validatePhone()">
                                    <span id="phone-error-message" class="text-danger"></span>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label for="present_address" class="col-md-4 col-form-label text-md-right">Present Address</label>
                                <div class="col-md-6">
                                    <input type="text" id="present_address" class="form-control" name="address" onblur="validateAddress()">
                                    <span id="address-error-message" class="text-danger"></span>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label for="age" class="col-md-4 col-form-label text-md-right">Age</label>
                                <div class="col-md-6">
                                    <input type="number" id="age" class="form-control" name="age" onblur="validateAge()">
                                    <span id="age-error-message" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="col-md-6 offset-md-4">
                                <button type="submit" class="btn btn-primary">
                                    Register
                                </button>
                            </div>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>


<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>