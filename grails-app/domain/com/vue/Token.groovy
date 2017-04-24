package com.vue

class Token {

    String token
    Date tokenExpiryTime
    static constraints = {
        token blank: false,nullable: false
    }
    static belongsTo = [user:User]
}
