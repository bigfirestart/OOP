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
}
