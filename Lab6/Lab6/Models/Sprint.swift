import Foundation

class Sprint {
    var uuid = UUID()
    var manager: Employee
    var startDate: Date
    var endDate: Date
    var text: String = ""
    var reports: [Report] = []
    
    init(manager: Employee, startDate: Date, endDate: Date) {
        self.manager = manager
        self.startDate = startDate
        self.endDate = endDate
    }
    
    func copy() -> Sprint {
        let newSprint = Sprint(manager: self.manager.copy(), startDate: self.startDate, endDate: self.endDate)
        newSprint.uuid = self.uuid
        newSprint.text = self.text
        for report in self.reports {
            newSprint.reports.append(report.copy())
        }
        return newSprint
    }
}
