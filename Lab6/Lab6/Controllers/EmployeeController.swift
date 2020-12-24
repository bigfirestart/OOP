import Foundation

class EmployeeController {
    
    private var storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func createEmployee() {
        
    }
    
    func isYourEmployee(requester: Employee, employee: Employee) -> Bool {
        let employees = self.storage.getAllManagerEmployees(managerUUID: requester.uuid)
        return employees.contains(employee)
    }
    
    func addEmployeeManager(requester: Employee, employee: Employee, manager: Employee) {
        let _ = storage.createSubordinates(employee: employee, manager: manager)
    }
}
