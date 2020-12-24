import Foundation

class Employee : Equatable {
    
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        if lhs.uuid == rhs.uuid {
            return true
        }
        return false
    }
    
    var uuid = UUID()
    var name: String
    
    
    init(name: String) {
        self.name = name 
    }
    
    func copy() -> Employee {
        let newEmployee = Employee(name: self.name)
        newEmployee.uuid = self.uuid
        return newEmployee
    }
}
