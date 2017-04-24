


var Login = Vue.extend({
    template: '#auth',
    data: function () {
        return {username: '',password: ''};
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
                    router.push({
                        path: '/',
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


var router = new VueRouter({
    routes: [{path: '/', component: List}
    ]});

new Vue({
    el: '#login',
    router: router,
    template: '<router-view></router-view>'
});
