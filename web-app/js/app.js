const store = new Vuex.Store({
    state: {
        user: {
            userName:'',
            loggedInStatus: true,
            authToken: '',
            role: ''
        },
        employees: []
    },

    mutations: {
        addWebToken: function(state, data){
            state.user.authToken = data.token;
            state.user.role = data.role;
        },
        removeWebToken: function(state){
            state.user.authToken = '';
            state.user.role = '';
        }
    },
    methods:{
        getToken:function (){
            return  store.state.user.authToken;

        }
    }

})


function findEmployee (employeeId) {
    return store.state.employees[findEmployeeKey(employeeId)];
};

function findEmployeeKey (employeeId) {
    console.log("employee id " + employeeId)
    for (var key = 0; key < store.state.employees.length; key++) {
        if (store.state.employees[key].id == employeeId) {
            console.log("key :  " + key)
            return key;
        }
    }
};

var List = Vue.extend({
    template: '#employee-list',
    data: function () {
        var result=  [];
        console.log("called.AJAX.")
        $.ajax({
            url: "/vue/api/getEmployees",
            headers: {
                "Authorization": store.state.user.authToken
            },
            success: function (data) {
                if(data.success!="false"){
                    $.each(data.employees, function (index, employee) {
                        result.push(employee);
                    });
                }
            }
        });
        store.state.employees = result
        console.log(result);
        console.log("result..");
        return {result: result,searchKey: ''};
    },
    computed : {
        filteredEmployees: function () {
            var self = this;
            console.log("called..")
            return self.result.filter(function (employee) {
                return employee.name.indexOf(self.searchKey) !== -1
            })
        }
    }
});

var Employee = Vue.extend({
    template: '#employee',
    data: function () {
        return {employee: findEmployee(this.$route.params.employee_id)};
    }
});

var Login = Vue.extend({
    template: '#auth',
    data: function () {
        return {username: '',password: '',errorMessage:''};
    },
    methods : {
        login: function (e) {
            var _this = this;
            var employee = this.employee;
            $.ajax({
                url: "/vue/api/login",
                type: "POST",
                async:false,
                data:{
                    username:_this.username,
                    password: _this.password
                },
                success: function (data) {
                    console.log(data);
                    if(data.success){
                        store.commit('addWebToken', {token:data.token,role:data.role}); // pass the webtoken as payload to the mutation
                        console.log(store.state.user.authToken)
                        router.push({
                            path: '/employeeList',
                            params: { message: 'Successfully updated' }
                        });
                    }else{
                        _this.errorMessage = "Incorrect username or password"
                    }
                },
                error:function (xhr, status, error) {
                    console.log("message....... " + xhr.responseText);
                    _this.errorMessage = xhr.responseText
                }
            });
        }
    }
});

var EmployeeEdit = Vue.extend({
    template: '#employee-edit',
    data: function () {
        return {employee: findEmployee(this.$route.params.employee_id),errorMessage:null};
    },
    methods: {
        updateEmployee: function (e) {
            var _this = this;
            var employee = this.employee;
            $.ajax({
                url: "/vue/api/updateEmployee",
                headers: {
                    "Authorization": store.state.user.authToken
                },
                type: "POST",
                async:false,
                data:{
                    id: employee.id,
                    name: employee.name,
                    profile: employee.profile,
                    age: employee.age
                },
                success: function (data) {
                    router.push({
                        path: '/employeeList',
                        params: { message: 'Successfully updated' }
                    });
                },
                error:function (xhr, status, error) {
                    console.log("message....... " + xhr.responseText);
                    _this.errorMessage = xhr.responseText
                }
            });
        }
    }
});

Vue.component('error-message', {
    props: ['text'],
    template: '<div class="alert alert-danger">{{ text }}</div>'
})


Vue.component('nav-bar', {
template: '#nav',
    data: function(){
        return {role:store.state.user.role};
    },
    methods: {
        logout: function () {

        }
    }
})


var EmployeeDelete = Vue.extend({
    template: '#employee-delete',
    data: function () {
        return {employee: findEmployee(this.$route.params.employee_id),errorMessage:''};
    },
    methods: {
        deleteEmployee: function () {
            var _this = this;
            var employee = _this.employee;
            console.log("employee..... " + employee)
            $.ajax({
                url: "/vue/api/deleteEmployee",
                headers: {
                    "Authorization": store.state.user.authToken
                },
                type: "POST",
                async:false,
                data:{
                    id: employee.id
                },
                success: function (data) {
                    router.push({
                        path: '/employeeList'
                    });
                },
                error:function (xhr, status, error) {
                    console.log("message....... " + xhr.responseText);
                    _this.errorMessage = xhr.responseText
                }
            });
        }
    }
});

var AddEmployee = Vue.extend({
    template: '#add-employee',
    data: function () {
        return {employee: {name: '', profile: '', age: ''}
        }
    },
    methods: {
        createEmployee: function() {
            var _this = this;
            var employee = this.employee;
            $.ajax({
                url: "/vue/api/saveEmployee",
                headers: {
                    "Authorization": store.state.user.authToken
                },
                type: "POST",
                async:false,
                data:{
                    name: employee.name,
                    profile: employee.profile,
                    age: employee.age
                },
                success: function (data) {
                    router.push({
                        path: '/employeeList',
                        params: { message: 'Successfully created' }
                    });
                },
                error:function (xhr, status, error) {
                    console.log("message....... " + xhr.responseText);
                    _this.errorMessage = xhr.responseText
                }
            });
        }
    }
});

var router = new VueRouter({
    routes: [{path: '/', component: Login},
        {path: '/employeeList', component: List},
        {path: '/employee/:employee_id', component: Employee, name: 'employee'},
        {path: '/add-employee', component: AddEmployee},
        {path: '/employee/:employee_id/edit', component: EmployeeEdit, name: 'employee-edit'},
        {path:   '/employee/:employee_id/delete', component: EmployeeDelete, name: 'employee-delete'}
    ]});

new Vue({
    el: '#app',
    router: router,
    template: '<router-view></router-view>'
});
