import Foundation


class Subordinates {
    var uuid = UUID()
    var employee: Employee
    var manager: Employee
    
    init(employee: Employee, manager: Employee) {
        self.employee = employee
        self.manager = manager
    }
    
    func copy() -> Subordinates {
        let newSubordinates = Subordinates(employee: self.employee, manager: self.manager)
        newSubordinates.uuid = self.uuid
        return newSubordinates
    }
}
