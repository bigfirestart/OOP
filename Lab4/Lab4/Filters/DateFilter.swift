import Foundation

class DateFilter: FilterProtocol {
    static func filter(backup: Backup, param: Date) -> [RestorePoint] {
        return backup.restoreHistory.filter({$0.creationDateTime > param })
    }
}
