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
    
    func copy() -> Comment {
        let newComment = Comment(text: self.text, toTask: self.task.copy(), createdBy: self.employee.copy())
        newComment.uuid = self.uuid
        newComment.time = self.time
        return newComment
    }
}
