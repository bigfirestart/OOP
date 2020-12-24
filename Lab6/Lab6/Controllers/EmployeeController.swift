import Foundation

class EmployeeController {
    
    private var storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func createEmployee(name: String) -> Employee {
        return storage.createEmployee(name: name)
    }
    
    func isYourEmployee(requester: Employee, employee: Employee) -> Bool {
        let employees = self.storage.getAllManagerEmployees(managerUUID: requester.uuid)
        return employees.contains(employee)
    }
    
    func addEmployeeManager(requester: Employee, employee: Employee, manager: Employee) {
        let _ = storage.createSubordinates(employeeUUID: employee.uuid, managerUUID: manager.uuid)
    }
}
