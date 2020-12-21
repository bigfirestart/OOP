import Foundation

class Task {
    var uiid = UUID()
    var status: TaskStatus = TaskStatus.open
}

enum TaskStatus {
    case open
    case active
    case resolved
}
