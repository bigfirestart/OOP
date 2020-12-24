import Foundation

class MainController {
    private var storage: Storage = Storage()
    public var taskController: TaskController
    public var employeeController: EmployeeController
    public let reportController: ReportController
    
    init() {
        self.taskController = TaskController(storage: self.storage)
        self.employeeController = EmployeeController(storage: self.storage)
        self.reportController = ReportController(storage: self.storage)
    }
}

enum ControllerErrors {
    case PermissionDenied
}
