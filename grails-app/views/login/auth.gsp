<%--
  Created by IntelliJ IDEA.
  User: gaurav
  Date: 16/3/17
  Time: 5:18 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Vue App</title>
</head>

<body>


<div  class="container">

    <div id="login">
    </div>
</div>

<template id="auth">

        <div class="wrapper">
            <form v-on:submit.prevent="login" class="form-signin">
                <h2 class="form-signin-heading">Please login</h2>
                <input type="text" class="form-control" name="username" placeholder="Email Address" required="" autofocus="" />
                <input type="password" class="form-control" name="password" placeholder="Password" required=""/>
                <label class="checkbox">
                    <input type="checkbox" value="remember-me" id="rememberMe" name="rememberMe"> Remember me
                </label>
                <button class="btn btn-lg btn-primary btn-block" type="submit">Login</button>
            </form>
        </div>
</template>




<script src="${resource(dir: 'js', file: 'login.js')}"></script>
<style>
body {
    background: #eee !important;
}

.wrapper {
    margin-top: 80px;
    margin-bottom: 80px;
}

.form-signin {
    max-width: 380px;
    padding: 15px 35px 45px;
    margin: 0 auto;
    background-color: #fff;
    border: 1px solid rgba(0, 0, 0, 0.1);
.form-signin-heading,
.checkbox {
    margin-bottom: 30px;
}
.checkbox {
    font-weight: normal;
}
.form-control {
    position: relative;
    font-size: 16px;
    height: auto;
    padding: 10px;
@include box-sizing(border-box);
&:focus {
    z-index: 2;
}
}
input[type="text"] {
    margin-bottom: -1px;
    border-bottom-left-radius: 0;
    border-bottom-right-radius: 0;
}
input[type="password"] {
    margin-bottom: 20px;
    border-top-left-radius: 0;
    border-top-right-radius: 0;
}
}
        </style>

</body>
</html>


