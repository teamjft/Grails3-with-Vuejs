const store = new Vuex.Store({
    state: {
        user: {
            userName:'',
            loggedInStatus: true,
            authToken: ''
        }
    },
    mutations: {
    addWebToken: function(state, webToken){
        state.user.authToken = webToken;
    },
    removeWebToken: function(state){
        state.user.authToken = '';
    }
},
actions: {
    login: function(context, userInput){
        $.ajax({
            url: "/vue/api/login",
            type: "POST",
            async:false,
            data:{
                username:userInput.username,
                password: userInput.password
            },
            success: function (data) {
                // store the token in global variable ??

                context.commit('addWebToken', webToken); // pass the webtoken as payload to the mutation

                router.push({
                    path: '/employeeList'
                });
            },
            error:function (xhr, status, error) {

                _this.errorMessage = xhr.responseText
            }
        });
    },
    logput: function(context){
        //your logout functionality
        context.commit('removeWebToken');
    }
}

})



var employees = [

];

function findEmployee (employeeId) {
    return employees[findEmployeeKey(employeeId)];
};

function findEmployeeKey (employeeId) {
    for (var key = 0; key < employees.length; key++) {
        if (employees[key].id == employeeId) {
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
            success: function (data) {
                $.each(data, function (index, employee) {
                    result.push(employee);
                });
            }
        });
        employees = result
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
                        router.push({
                            path: '/employeeList',
                            params: { message: 'Successfully updated' }
                        });
                    }else{
                        _this.errorMessage = "Invalid Credentials"
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

Vue.component('flash-message', {
    props: ['text'],
    template: '<div class="alert alert-success">{{ text }}</div>'
})

var EmployeeDelete = Vue.extend({
    template: '#employee-delete',
    data: function () {
        return {employee: findEmployee(this.$route.params.employee_id)};
    },
    methods: {
        deleteEmployee: function () {
            employees.splice(findEmployeeKey(this.$route.params.employee_id), 1);
            router.push('/employeeList');
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
            var employee = this.employee;
            employees.push({
                id: Math.random().toString().split('.')[1],
                name: employee.name,
                profile: employee.profile,
                age: employee.age
            });
            router.push('/employeeList');
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
