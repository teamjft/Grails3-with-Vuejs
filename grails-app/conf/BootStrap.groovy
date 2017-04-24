import com.vue.Role
import com.vue.User
import com.vue.UserRole
import vue.Employee

class BootStrap {

    def init = { servletContext ->

        if(Employee.count==0){
            createEmployees()
        }

        if(User.count==0){
            createUsers()
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

    def createUsers(){
        Role adminRole = new Role(authority: 'ROLE_ADMIN')
        adminRole.save(failOnError: true)
        User user = new User(username: 'admin', password: 'admin', enabled: true).save(failOnError: true)
        UserRole adminUserRole = new UserRole(user: user, role: adminRole)
        adminUserRole.save(failOnError: true);
    }
}
