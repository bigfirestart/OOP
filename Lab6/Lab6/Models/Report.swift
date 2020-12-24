import Foundation

class Report {
    var uuid = UUID()
    var date = Date()
    var creator: Employee
    var text: String = ""
    var finishedTasks: [Task] = []
    
    init(creator: Employee) {
        self.creator = creator
    }
    
    func copy() -> Report {
        let newReport = Report(creator: self.creator)
        newReport.uuid = self.uuid
        newReport.date = self.date
        newReport.text = self.text
        for task in self.finishedTasks {
            newReport.finishedTasks.append(task.copy())
        }
        return newReport
    }
}
