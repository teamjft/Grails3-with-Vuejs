package vue

import com.vue.Token
import com.vue.User
import grails.converters.JSON
import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.CREATED

class ApiController {

    def passwordEncoder

    def login(){
        def token=null
        def role=null
        //int min=30 //Token Expiry time in minutes
        User user=User?.findByUsername(params.userName)
        if(user){
            if(passwordEncoder.isPasswordValid(user.password, params.password, null)){
                token= UUID.randomUUID().toString()
                role=user.getAuthorities().authority
                Token tokens=new Token(token: token,tokenExpiryTime: new Date())
                user.addToTokens(tokens)
                if(user.validate()){
                    user.save(failOnError: true)
                    log.info("Token is saved to user Instance")
                }
                else{
                    render(contentType: "text/json", text: (['success': false, 'message': 'Session Could not be created.Try Again'] as grails.converters.JSON))
                }
                log.info("login from mobile app successful")
                render(contentType: 'text/json') {[
                        'success':true,
                        'user': user?.username,
                        'role':role ,
                        'token': token,
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
        render employees as JSON
    }

    @Transactional
    def saveEmployee(Employee employeeInstance) {
        if (employeeInstance == null) {
            notFound()
            return
        }

        if (employeeInstance.hasErrors()) {
            respond employeeInstance.errors, view: 'create'
            return
        }

        employeeInstance.save flush: true

    }


    @Transactional
    def updateEmployee(Employee employeeInstance) {
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
}
