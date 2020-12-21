import Foundation

class Comment {
    var uuid: UUID = UUID()
    var employee: Employee
    var task: Task
    var text: String
    var time: Date = Date()
    
    init(text: String, toTask: Task, createdBy: Employee) {
        self.text = text
        self.task = toTask
        self.employee  = createdBy
    }
}
