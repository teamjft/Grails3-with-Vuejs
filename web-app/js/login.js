


var List = Vue.extend({
    template: '#auth',
    data: function () {
        return {username: '',password: ''};
    },
    computed : {
        login: function () {

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
