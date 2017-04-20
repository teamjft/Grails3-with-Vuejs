import vue.Employee

class BootStrap {

    def init = { servletContext ->

        if(Employee.count==0){
            createEmployees()
        }
    }
    def destroy = {
    }

    def createEmployees(){
        Employee employee = new Employee()
        employee.age = 27
        employee.name = "Vivek"
        employee.profile = "Grails and groovy developer"
        employee.save(flush: true)


        Employee employee2 = new Employee()
        employee2.age = 28
        employee2.name = "Prashant"
        employee2.profile = "Java developer"
        employee2.save(flush: true)

        Employee employee3 = new Employee()
        employee3.age = 26
        employee3.name = "Saurabh"
        employee3.profile = "UI designer"
        employee3.save(flush: true)
    }
}
