package vue

import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class EmployeeController {

    def getEmployees(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def employees =  Employee.list(params)
        render employees as JSON
    }

    def show(Employee employeeInstance) {
        respond employeeInstance
    }


}
