package vue

import grails.plugin.springsecurity.SpringSecurityUtils

class LoginController {
    def springSecurityService

    def auth = {

        def config = SpringSecurityUtils.securityConfig
        if (springSecurityService.isLoggedIn()) {
            redirect uri: config.successHandler.defaultTargetUrl
            return
        }

        String view = 'auth'
        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
        render view: view, model: [postUrl: postUrl,
                rememberMeParameter: config.rememberMe.parameter,alertType:params?.alertType]
    }
}
