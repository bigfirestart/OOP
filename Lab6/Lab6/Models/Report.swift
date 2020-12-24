import Foundation

class Report {
    var uuid = UUID()
    var date = Date()
    var text: String = ""
    var finishedTasks: [Task] = []
    
    func copy() -> Report {
        let newReport = Report()
        newReport.uuid = self.uuid
        newReport.date = self.date
        newReport.text = self.text
        newReport.finishedTasks = self.finishedTasks
        return newReport
    }
}

enum ReportStatus {
    case OnGoing
    case Finished
}
