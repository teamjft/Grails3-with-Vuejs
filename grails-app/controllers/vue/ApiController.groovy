package vue

import com.vue.Token
import com.vue.User
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.CREATED


@Secured('permitAll')
class ApiController {

    def passwordEncoder

    def login(){
        def tokenString=null
        def role=null
        //int min=30 //Token Expiry time in minutes
        User user=User?.findByUsername(params.username)
        if(user){
            if(passwordEncoder.isPasswordValid(user.password, params.password, null)){
                tokenString= UUID.randomUUID().toString()
                role=user.getAuthorities().first().authority
                Token token=new Token(token: tokenString,tokenExpiryTime: new Date())
                user.addToTokens(token)
                if(user.validate()){
                    user.save(failOnError: true,flush: true)
                    println "Token is saved to user Instance"
                }
                else{
                    render(contentType: "text/json", text: (['success': false, 'message': 'Session Could not be created.Try Again'] as grails.converters.JSON))
                    return
                }
                log.info("login from mobile app successful")
                render(contentType: 'text/json') {[
                        'success':true,
                        'user': user?.username,
                        'role':role ,
                        'token': tokenString,
                        'message':"Login successful"
                ]}
            }
            else{
                render(contentType: "text/json", text: (['success': false, 'message': 'User Name or Password does not match']  as grails.converters.JSON))
            }
        }
        else{
            render(contentType: "text/json", text: (['success': false, 'message': 'User Name or Password does not match']  as grails.converters.JSON))
        }

    }


    def getEmployees(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def employees =  Employee.list(params)
        if(employees.size()>0){
            render(contentType: 'text/json') {[
                    'employees':employees,
                    'success':true,
            ]}
        }else{
            render(contentType: 'text/json') {[
                    'success':true,
                    'message':"No employees found"
            ]}
        }
    }

    @Transactional
    def saveEmployee(Employee employeeInstance) {
        try{
            if (employeeInstance.hasErrors()) {
                response.status = 500
                render('Error creating employee')
                return
            }
            employeeInstance.save flush: true,failOnError: true
        }catch(Exception e){
            response.status = 500
            render('Error creating employee')
            return
        }
        response.status = 200
        render('Employee successfully created')
        return

    }


    @Transactional
    def updateEmployee() {

        Employee employeeInstance= Employee.findById(params.id)
        if(!employeeInstance){
            response.status = 500
            render('No employee found with the given ID')
            return
        }

        try{
            bindData(employeeInstance, params)
            if (employeeInstance.hasErrors()) {
                response.status = 500
                render('Error updating employee')
                return
            }
            employeeInstance.save flush: true,failOnError: true
        }catch(Exception e){
            response.status = 500
            render('Error updating employee')
            return
        }
        response.status = 200
        render('Employee successfully updated')
        return

    }

    @Transactional
    def deleteEmployee(){
        Employee employeeInstance= Employee.findById(params.id)
        if(!employeeInstance){
            response.status = 500
            render('No employee found with the given ID')
            return
        }

        employeeInstance.delete()
        response.status = 200
        render('Employee successfully deleted')
        return
    }
}
