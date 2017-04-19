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


<div class="container">
    <header class="page-header">
        <div class="row">

            <div class="col-sm-4">
                <h1>JFT Employee Portal</h1>
            </div>
        </div>
    </header>
    <div id="app"></div>
</div>

<template id="employee-list">
    <section>

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
            <tr>
                <th>Name</th>
                <th>Profile</th>
                <th>Age</th>
                <th class="col-sm-2">Actions</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="employee in filteredEmployees">
                <td>
                    <i class="icomoon icon-accessibility"></i>
                    <router-link :to="{name: 'employee', params: {employee_id: employee.id}}">{{ employee.name }}</router-link>
                </td>
                <td>{{ employee.profile }}</td>
                <td>

                    {{ employee.age }}
                </td>
                <td>
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
        <h2>Add Employee</h2>
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
        <h2>{{ employee.name }}</h2>
        <b>Profile: </b>
        <div>{{ employee.profile }}</div>
        <b>Age:</b>
        <div>{{ employee.age }}</div>
        <br/>
        <span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
        <router-link to="/">Back to employee list</router-link>
    </section>
</template>

<template id="employee-edit">
    <section>
        <h2>Edit Employee</h2>
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
        <h2>Delete employee "{{ employee.name }}"</h2>
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


