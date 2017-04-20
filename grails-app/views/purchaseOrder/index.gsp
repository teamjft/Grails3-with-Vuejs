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

    <div id="app">
    </div>
</div>

<template id="employee-list">
    <section>


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

<template id="add-employee">
    <section>
        <header class="page-header">
            <div class="row">
                <div class="col-sm-4">
                    <h1>Add Employee</h1>
                </div>
            </div>
        </header>
        <form v-on:submit="createEmployee">
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
        <router-link to="/">Back to employee list</router-link>
    </div>
    </div>
    </section>

</template>

<template id="employee-edit">

    <section>

        <header class="page-header">
            <div class="row">
                <div class="col-sm-4">
                    <h1>Edit Employee</h1>
                </div>
            </div>
        </header>
        <flash-message v-if="errorMessage" v-bind:text="errorMessage"> </flash-message>
        <form v-on:submit="updateEmployee">
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
        <header class="page-header">
            <div class="row">
                <div class="col-sm-4">
                    <h1>Confirm Delete</h1>
                </div>
            </div>
        </header>
        <form v-on:submit="deleteEmployee">
            <p>The action cannot be undone.</p>
            <button type="submit" class="btn btn-danger">Delete</button>
            <router-link to="/" class="btn btn-default">Cancel</router-link>
        </form>
    </section>
</template>

<script src="${resource(dir: 'js', file: 'app.js')}"></script>
</body>
</html>


