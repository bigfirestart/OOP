import Foundation

class TaskAction {
    var uuid = UUID()
    var creationTime = Date()
    var creator: Employee
    var task: Task
    var taskActionType: TaskActionType
    
    init(creator: Employee, task: Task, actionType: TaskActionType) {
        self.creator = creator
        self.task = task
        self.taskActionType = actionType
    }
    
    func copy() -> TaskAction {
        let newTaskAction = TaskAction(creator: self.creator, task: self.task, actionType: self.taskActionType)
        newTaskAction.uuid = self.uuid
        newTaskAction.creationTime = self.creationTime
        return newTaskAction
    }
}

enum TaskActionType {
    case Created
    case StatusChanged
    case NameChanged
    case EmployeeChanged
}
