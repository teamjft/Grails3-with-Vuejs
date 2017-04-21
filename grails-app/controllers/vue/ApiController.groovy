package vue

import grails.converters.JSON
import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.CREATED

class ApiController {



    def getEmployees(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def employees =  Employee.list(params)
        render employees as JSON
    }

    def show(Employee employeeInstance) {
        respond employeeInstance
    }

    def create() {
        respond new Employee(params)
    }

    @Transactional
    def save(Employee employeeInstance) {
        if (employeeInstance == null) {
            notFound()
            return
        }

        if (employeeInstance.hasErrors()) {
            respond employeeInstance.errors, view: 'create'
            return
        }

        employeeInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'employee.label', default: 'Employee'), employeeInstance.id])
                redirect employeeInstance
            }
            '*' { respond employeeInstance, [status: CREATED] }
        }
    }

    def edit(Employee employeeInstance) {
        respond employeeInstance
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
