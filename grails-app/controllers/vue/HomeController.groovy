package vue

import grails.plugin.springsecurity.annotation.Secured


class HomeController {

    def index(){

    }

    @Secured('permitAll')
    def admin() {

    }

    def user(){

    }
}
