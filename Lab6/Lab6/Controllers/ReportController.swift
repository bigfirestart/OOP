import Foundation


class ReportController {
    private let storage: Storage
    
    init(storage: Storage){
        self.storage = storage
    }
    
    func createReport() {
        
    }
    
    func changeReportText() {
        //check is the same date
    }
    
    func getEmployeeReports(employeeUUID: UUID) -> [Report] {
        return []
    }
    
    func getManagerEmployeesReports(managerUUID: UUID) -> [Report]{
        var thisReports: [Report] = []
        for employee in storage.getAllManagerEmployees(managerUUID: managerUUID) {
            thisReports.append(contentsOf: getEmployeeReports(employeeUUID: employee.uuid))
        }
        return thisReports
    }
    
    func createSprint() {
        
    }
    
    func changeSprintText() {
        
    }
    
    func addReportToSprint() {
        
    }
    
}
