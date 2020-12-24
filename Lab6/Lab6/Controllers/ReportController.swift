import Foundation


class ReportController {
    private let storage: Storage
    
    init(storage: Storage){
        self.storage = storage
    }
    
    func createReport(requester: Employee) -> Report {
        return self.storage.createReport(creatorUUID: requester.uuid)
    }
    
    func getReport(reportUUID: UUID) -> Report? {
        return storage.getReport(reportUUID: reportUUID)
    }
    
    func changeReportText(reportUUID: UUID, newText: String) -> Report? {
        //check is the same date
        let thisReport = getReport(reportUUID: reportUUID)!
        let diff = Calendar.current.dateComponents([.day], from: thisReport.date, to: Date())
        if diff.day == 0 {
            return self.storage.changeReportText(reportUUID: reportUUID, newText: newText )
        }
        else {
           return nil
        }
    }
    
    func addReportTask(reportUUID: UUID, taskUUID: UUID) -> Report? {
        let thisReport = getReport(reportUUID: reportUUID)!
        
        //check date today
        let diff = Calendar.current.dateComponents([.day], from: thisReport.date, to: Date())
        if diff.day != 0 {
            return nil
        }
        
        //check is Task comleted
        let thisTask = self.storage.getTask(uuid: taskUUID)
        if thisTask?.status != TaskStatus.resolved{
            return nil
        }
        
        //adding if passed
        return self.storage.addReportTask(reportUUID: reportUUID, taskUUID: taskUUID)
        
    }
    
    func getEmployeeReports(employeeUUID: UUID) -> [Report] {
        return []
    }
    
    func getManagerEmployeesReports(managerUUID: UUID) -> [Report] {
        var thisReports: [Report] = []
        for employee in storage.getAllManagerEmployees(managerUUID: managerUUID) {
            thisReports.append(contentsOf: getEmployeeReports(employeeUUID: employee.uuid))
        }
        return thisReports
    }
    
    //sprints
    
    func createSprint(requiester: Employee, startDate: Date, endDate: Date) -> Sprint {
        return self.storage.createSprint(managerUUID: requiester.uuid, startDate: startDate, endDate: endDate)
    }
    
    func getSprint(sprintUUID: UUID) -> Sprint? {
        return self.storage.getSprint(sprintUUID: sprintUUID)
    }
    
    func changeSprintText(requester: Employee, sprint: Sprint, newText: String) -> Sprint? {
        let fakeSprint = self.getSprint(sprintUUID: sprint.uuid)
        if fakeSprint?.manager.uuid != requester.uuid{
            return nil
        }
        return self.storage.changeSprintText(sprintUUID: sprint.uuid, newText: newText)
    }
    
    func addReportToSprint(requester: Employee, sprint: Sprint, report: Report) -> Sprint? {
        
        //check permission
        let fakeSprint = self.getSprint(sprintUUID: sprint.uuid)
        if fakeSprint?.manager.uuid != requester.uuid{
            return nil
        }
        let ec = EmployeeController(storage: self.storage)
        if !ec.isYourEmployee(requester: requester, employee: report.creator){
            return nil
        }
        
        //adding
        return self.storage.addSprintReport(sprintUUID: sprint.uuid, reportUUID: report.uuid)
    }
    
}
