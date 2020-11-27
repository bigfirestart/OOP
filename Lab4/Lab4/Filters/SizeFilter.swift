import Foundation

class SizeFilter: FilterProtocol {
    static func filter(backup: Backup, param: Float) -> [RestorePoint] {
        return backup.restoreHistory.filter({$0.size < param})
    }
}

