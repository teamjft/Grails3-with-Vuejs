package com.vue

import grails.converters.JSON

class ApiFilters {


    def filters = {
        forapi(controller: 'api', action: '*') {
            before = {
//                header( "Access-Control-Allow-Origin", "*" )
                println "token......."
                if (actionName != 'login') {
                    String token = request.getHeader("Authorization") ?: null
                    println token
                    println "token......."
                    def authToken = null
                    ///int min = 30 //Token expiry time in minutes
                    if (token != null) {
                        authToken = Token?.findByToken(token)
                    }
                    if (authToken) {
                        def user=User.findById(authToken.userId)
                        if (user) {
                            request.setAttribute("user",user)
                            return true
                        } else {
                            render(contentType: "text/json", text: (['success': 'false', 'message': 'User does not exist'] as JSON))
                        }
                    } else {
                        println "else..........."
                        render(contentType: "text/json", text: (['success': 'false', 'message': 'You are not a valid user'] as JSON))
                    }
                    return false
                }
                else{
                    return true
                }

            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
