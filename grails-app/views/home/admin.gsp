<%--
  Created by IntelliJ IDEA.
  User: gaurav
  Date: 16/3/17
  Time: 5:18 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    %{--<meta name="layout" content="main"/>--}%
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- jQuery library -->
    <script src="${resource(dir: 'js', file: 'jquery.min.js')}"></script>

    <!-- Latest compiled JavaScript -->
    <script src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
    <script src="${resource(dir: 'js', file: 'vue.js')}"></script>
    <script src="${resource(dir: 'js', file: 'vue-router.js')}"></script>
    <script src="${resource(dir: 'js', file: 'vuex.js')}"></script>
    %{--<script src="${resource(dir: 'js', file: 'vuex-persistedstate.js')}"></script>--}%
    <title>Vue App</title>
</head>

<body>


<div class="container">
    <div id="app">
    </div>
</div>
<template id="nav">


    <nav v-show="role === 'ROLE_ADMIN'" class="navbar navbar-inverse">

        <div class="container-fluid">

            <div class="navbar-header">
                <a class="navbar-brand" href="#">JFT Employee Portal </a>
            </div>
            <ul class="nav navbar-nav">
                <li class="active"><router-link :to="{path: '/employeeList'}">Home</router-link></li>
                <li class="active"><router-link :to="{path: '/logout'}">Logout</router-link></li>
            </ul>
        </div>
    </nav>
</template>

<template id="employee-list">
    <section>
        <nav-bar></nav-bar>
        {{message}}
        <header class="page-header">
            <div class="row">
                <div class="col-sm-4">
                    <h1>Employee List</h1>
                </div>
            </div>
        </header>
        <div class="filters row">
            <div class="form-group col-sm-3">
                <label for="search-element">Employee name</label>
                <input v-model="searchKey" class="form-control" id="search-element" />
            </div>
        </div>
        <div class="actions">
            <router-link class="btn btn-default" :to="{path: '/add-employee'}">
                <span class="glyphicon glyphicon-plus"></span>
                Add employee
            </router-link>
        </div>
        <table class="table">
            <thead>
            <tr class="row">
                <th class="col-sm-3">Name</th>
                <th class="col-sm-4">Profile</th>
                <th class="col-sm-2">Age</th>
                <th class="col-sm-3">Actions</th>
            </tr>
            </thead>
            <tbody>
            <tr class="row" v-for="employee in filteredEmployees">
                <td class="col-sm-3">
                    <i class="icomoon icon-accessibility"></i>
                    <router-link :to="{name: 'employee', params: {employee_id: employee.id}}">{{ employee.name }}</router-link>
                </td>
                <td class="col-sm-4">{{ employee.profile }}</td>
                <td class="col-sm-2">

                    {{ employee.age }}
                </td>
                <td class="col-sm-3">
                    <router-link class="btn btn-warning btn-xs" :to="{name: 'employee-edit', params: {employee_id: employee.id}}">Edit</router-link>
                    <router-link class="btn btn-danger btn-xs" :to="{name: 'employee-delete', params: {employee_id: employee.id}}">Delete</router-link>
                </td>
            </tr>
            </tbody>
        </table>
    </section>
</template>

<template id="auth">

    <div class="wrapper">
        <error-message v-if="errorMessage" v-bind:text="errorMessage"> </error-message>
        <form v-on:submit.prevent="login" class="form-signin">
            <h2 class="form-signin-heading">Please login</h2>
            <input type="text" class="form-control" v-model="username" name="username" placeholder="Email Address" required="" autofocus="" />
            <input type="password" class="form-control" v-model="password"  name="password" placeholder="Password" required=""/>
            <button class="btn btn-lg btn-primary btn-block" type="submit">Login</button>
        </form>
    </div>
</template>


<template id="add-employee">
    <section>
        <nav-bar></nav-bar>

        <header class="page-header">
            <div class="row">
                <div class="col-sm-4">
                    <h1>Add Employee</h1>
                </div>
            </div>
        </header>
        <form v-on:submit.prevent="createEmployee">
            <div class="form-group">
                <label for="add-name">Name</label>
                <input class="form-control" id="add-name" v-model="employee.name" required/>
            </div>
            <div class="form-group">
                <label for="add-description">Profile</label>
                <textarea class="form-control" id="add-description" rows="10" v-model="employee.profile"></textarea>
            </div>
            <div class="form-group">
                <label for="add-price">Age </label>
                <input type="number" class="form-control" id="add-price" v-model="employee.age"/>
            </div>
            <button type="submit" class="btn btn-primary">Create</button>
            <router-link class="btn btn-default" :to="{path: '/'}">Cancel</router-link>
        </form>
    </section>
</template>

<template id="employee">
    <section>
        <nav-bar></nav-bar>

        <header class="page-header">
            <div class="row">
                <div class="col-sm-4">
                    <h1>Employee Details</h1>
                </div>
            </div>
        </header>
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 col-sm-offset-0 col-md-offset-3 col-lg-offset-3 toppad" >
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title">{{ employee.name }}</h3>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-3 col-lg-3 " align="center"> <img alt="User Pic" src="https://us.123rf.com/450wm/nalinn/nalinn1504/nalinn150400243/38529377-green-alien-face-wearing-earphone--music-lover-alien-clipart-isolated-in-white.jpg?ver=6" class="img-circle img-responsive"> </div>
                        <div class=" col-md-9 col-lg-9 ">
                            <table class="table table-user-information">
                                <tbody>
                                <tr>
                                    <td>Empoyee Id:</td>
                                    <td>{{ employee.id }}</td>
                                </tr>
                                <tr>
                                    <td>Profile:</td>
                                    <td>{{ employee.profile }}</td>
                                </tr>
                                <tr>
                                    <td>Age</td>
                                    <td>{{ employee.age }}</td>
                                </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
                <span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
                <router-link to="/employeeList">Back to employee list</router-link>
            </div>
        </div>
    </section>

</template>

<template id="employee-edit">

    <section>
        <nav-bar></nav-bar>

        <header class="page-header">
            <div class="row">
                <div class="col-sm-4">
                    <h1>Edit Employee</h1>
                </div>
            </div>
        </header>
        <error-message v-if="errorMessage" v-bind:text="errorMessage"> </error-message>
        <form v-on:submit.prevent="updateEmployee">
            <div class="form-group">
                <label for="edit-name">Name</label>
                <input class="form-control" id="edit-name" v-model="employee.name" required/>
            </div>
            <div class="form-group">
                <label for="edit-description">Profile</label>
                <textarea class="form-control" id="edit-description" rows="3" v-model="employee.profile"></textarea>
            </div>
            <div class="form-group">
                <label for="edit-price">Age</label>
                <input type="number" class="form-control" id="edit-price" v-model="employee.age"/>
            </div>
            <button type="submit" class="btn btn-primary">Save</button>
            <router-link to="/" class="btn btn-default">Cancel</router-link>
        </form>
    </section>
</template>

<template id="employee-delete">

    <section>
        <nav-bar></nav-bar>
        <header class="page-header">
            <div class="row">
                <div class="col-sm-4">
                    <h1>Confirm Delete</h1>
                </div>
            </div>
        </header>
        <error-message v-if="errorMessage" v-bind:text="errorMessage"> </error-message>
        <form v-on:submit.prevent="deleteEmployee">
            <p>The action cannot be undone.</p>
            <button type="submit" class="btn btn-danger">Delete</button>
            <router-link to="/employeeList" class="btn btn-default">Cancel</router-link>
        </form>
    </section>
</template>

<script src="${resource(dir: 'js', file: 'app.js')}"></script>

<style
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


