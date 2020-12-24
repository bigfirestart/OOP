import Foundation

class TaskController {
    private var storage: Storage;
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func createTask(
        requester: Employee, taskName: String) -> Task {
        return self.storage.createTask(taskName: taskName, creator: requester)
    }
    
    func hasTaskPermission(requester: Employee, taskUUID: UUID) -> Bool {
        let task = self.storage.getTask(uuid: taskUUID)!
        if task.employees.contains(requester) && task.creator.uuid == requester.uuid{
            return true
        }
        return false
    }
    
    func getTask(requester: Employee, uuid: UUID) -> Task? {
        let task = self.storage.getTask(uuid: uuid)
        if task!.employees.contains(requester) {
            return task
        }
        else {
            return nil
        }
    }
    
    func changeTaskStatus(requester: Employee, taskUUID: UUID, newStatus: TaskStatus) {
        if hasTaskPermission(requester: requester, taskUUID: taskUUID){
            let _ = storage.createTaskAction(taskUUID: taskUUID, employeeUUID: requester.uuid, action: TaskActionType.StatusChanged)
        }
    }
    
    func addEmployeeToTask (requester: Employee, employee: Employee, taskUUID: UUID) -> Bool {
        let ec = EmployeeController(storage: storage)
        if !ec.isYourEmployee(requester: requester, employee: employee){
            return false
        }
        let _ = storage.createTaskAction(taskUUID: taskUUID, employeeUUID: requester.uuid, action: TaskActionType.EmployeeChanged)
        return self.storage.addTaskEmployee(taskUUID: taskUUID, employeeUUID: employee.uuid)
    }
    
    func getTimeActionTasks (fromTime: Date, toTime: Date) -> [TaskAction] {
        return self.storage.getTimeLimetedActions(fromTime: fromTime, toTime: toTime)
    }
    
    func getEmployeeActionTasks (employee: Employee) -> [TaskAction]{
        return self.storage.getAllEmployeeActions(employeeUUID: employee.uuid)
    }
    
    
}


