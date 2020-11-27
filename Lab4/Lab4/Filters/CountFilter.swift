import Foundation

class CountFilter: FilterProtocol {
    static func filter(backup: Backup, param: Int) -> [RestorePoint] {
        return Array(backup.restoreHistory[backup.restoreHistory.count-param...backup.restoreHistory.count-1])
    }
}

