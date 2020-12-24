import Foundation


//after all transactions storage returns copy of element with same UUID
class Storage {
    private var tasks: [UUID : Task] = [:]
    private var taskActions: [UUID: TaskAction] = [:]
    private var emloyees: [UUID : Employee] = [:]
    private var comments: [UUID : Comment] = [:]
    private var subordinates: [UUID : Subordinates] = [:]
    private var sprints: [UUID: Sprint] = [:]
    private var reports: [UUID: Report] = [:]
    private var log = Logger()
    
    //tasks
    func createTask(taskName: String, creator: Employee) -> Task {
        let newTask = Task(name: taskName, creator: creator)
        self.tasks[newTask.uuid] = newTask
        log.info(text: "Created Task with id " + newTask.uuid.uuidString)
        return newTask.copy()
    }
    
    func getTask(uuid: UUID) -> Task? {
        return self.tasks[uuid]?.copy()
    }
    
    func addTaskEmployee(taskUUID: UUID, employeeUUID: UUID) -> Bool {
        let task = self.tasks[taskUUID]
        let employee = self.emloyees[employeeUUID]
        if  task == nil && employee == nil {
            return false
        }
        task!.employees.append(employee!)
        return true
    }
    
    func changeTaskStatus(taskUUID: UUID, status: TaskStatus) {
        self.tasks[taskUUID]!.status = status
    }
    
    func createComment(text: String, taskUUID: UUID, creatorUUID: UUID) -> Comment {
        let task = self.tasks[taskUUID]!
        let creator = self.emloyees[creatorUUID]!
        let newComment = Comment(text: text, toTask: task, createdBy: creator)
        self.comments[newComment.uuid] = newComment
        return newComment.copy()
    }
    
    func getTaskComments(taskUUID: UUID) -> [Comment] {
        var thisComments: [Comment] = []
        for (_ ,comment) in self.comments {
            if comment.task.uuid == taskUUID {
                thisComments.append(comment.copy())
            }
        }
        return thisComments
    }
    
    //task action
    func createTaskAction(taskUUID: UUID, employeeUUID: UUID, action: TaskActionType) -> TaskAction {
        let task = self.tasks[taskUUID]!
        let creator = self.emloyees[employeeUUID]!
        let newTaskAction = TaskAction(creator: creator, task: task, actionType: action)
        self.taskActions[newTaskAction.uuid] = newTaskAction
        return newTaskAction.copy()
    }
    
    //employee
    func createEmployee(name: String) -> Employee {
        let newEmployee = Employee(name: name)
        self.emloyees[newEmployee.uuid] = newEmployee
        return newEmployee.copy()
    }
    
    
    func getEmployee(uuid: UUID) -> Employee? {
        return self.emloyees[uuid]?.copy()
    }
    
    
    func createSubordinates(employee: Employee, manager: Employee) -> Subordinates {
        let newSubordinates = Subordinates(employee: employee, manager: manager)
        self.subordinates[newSubordinates.uuid] = newSubordinates
        return newSubordinates.copy()
    }
    
    func deleteSubordinates (managerUUID: UUID, employeeUUID: UUID ) {
        for (key, subordinate) in self.subordinates {
            if subordinate.manager.uuid == managerUUID {
                if subordinate.employee.uuid == employeeUUID {
                    self.subordinates.removeValue(forKey: key)
                }
            }
        }
    }
    
    func getAllManagerEmployees (managerUUID: UUID) -> [Employee] {
        var emloyees: [Employee] = []
        for subordinate in self.subordinates.values {
            if subordinate.manager.uuid == managerUUID {
                emloyees.append(subordinate.employee.copy())
            }
        }
        return emloyees
    }
    
    //reports
    
    func createReport() {
        
    }
    
    func changeReportText(reportUUID: UUID, newText: String){
        
    }
    
    func createSprint() {
        
    }
}

