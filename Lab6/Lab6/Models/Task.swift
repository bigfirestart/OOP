import Foundation

class Task {
    var uuid = UUID()
    var status: TaskStatus = TaskStatus.open
    var employees: [Employee] = []
    var creator: Employee
    var name: String
    
    init(name: String, creator: Employee){
        self.name = name
        self.creator = creator
    }
    
    
    func addEmployee (employee: Employee) {
        self.employees.append(employee)
    }
    
    func copy() -> Task {
        let taskCopy = Task(name: self.name, creator: self.creator)
        taskCopy.uuid = self.uuid
        for employee in self.employees {
            taskCopy.employees.append(employee.copy())
        }
        taskCopy.status = self.status
        return taskCopy
    }
}


enum TaskStatus {
    case open
    case active
    case resolved
}
