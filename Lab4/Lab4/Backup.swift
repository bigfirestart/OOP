import Foundation

class Backup {
    private(set) var restoreHistory: [RestorePoint] = []
    private(set) var type: SaveType
    
    public init(type: SaveType){
        self.type = type
    }
    
    func commitRestorePoint(point: RestorePoint) throws {
        do {
            let actualPoint = try point.getActualRestorePointVersion()
            self.restoreHistory.append(actualPoint)
        }
        catch {
            throw BackupError.PointCommitError
        }
    }
        
    private func removeNullPointerPoints() {
        var indexesToRemove: [Int] = []
        for (index, point) in self.restoreHistory.enumerated() {
            if point.originalPoint != nil {
                if !self.restoreHistory.contains(point) {
                    indexesToRemove.append(index)
                }
            }
        }
        removePoints(indexesToRemove: indexesToRemove)
        
    }
    
    private func removePoints(indexesToRemove: [Int]) {
        self.restoreHistory = self.restoreHistory.enumerated()
            .filter { !indexesToRemove.contains($0.offset) }
            .map { $0.element }
    }
    
    func commitRestorePointDiffrance(point: RestorePoint) throws {
        do {
            let actualPointDif = try point.getActualRestorePointDiffinition()
            
            self.restoreHistory.append(actualPointDif)
        }
        catch {
            throw BackupError.PointCommitError
        }
    }
    
    func filterByPointSize(maxSize: Float){
        self.restoreHistory = SizeFilter.filter(backup: self, param: maxSize)
        removeNullPointerPoints()
    }
    
    func filterByPointDate(minDateTime: Date){
        self.restoreHistory = DateFilter.filter(backup: self, param: minDateTime)
        removeNullPointerPoints()
    }
    
    func filterByPointsCount(maxCount: Int) throws {
        if (maxCount < 0) {
            throw BackupError.InvalidFilterParametrs
        }
        if (maxCount < restoreHistory.count) {
            self.restoreHistory = CountFilter.filter(backup: self, param: maxCount)
        }
        removeNullPointerPoints()
    }
    
    private func getFiltersResults(filters: [FilterType]) -> [[RestorePoint]] {
        var filtersResults: [[RestorePoint]] = [[]]
        for filter in filters {
            switch filter {
                case .count(let count):
                    filtersResults.append(CountFilter.filter(backup: self, param: count))
                case .size(let size):
                    filtersResults.append(SizeFilter.filter(backup: self, param: size))
                case .date(let date):
                    filtersResults.append(DateFilter.filter(backup: self, param: date))
            }
        }
        return filtersResults
    }
    
    func ANDFilter(filters: [FilterType]) {
        let filtersResults = getFiltersResults(filters: filters)
        var indexesToLeave: [Int] = []
        for (index, point) in self.restoreHistory.enumerated() {
            var leaveCondition = true
            for res in filtersResults {
                if !res.contains(point) {
                    leaveCondition = false
                    break
                }
            }
            if leaveCondition {
                indexesToLeave.append(index)
            }
        }
        var indexesToRemove: [Int] = []
        for (index, _) in self.restoreHistory.enumerated() {
            if !indexesToLeave.contains(index) {
                indexesToRemove.append(index)
            }
        }
        removePoints(indexesToRemove: indexesToRemove)
        removeNullPointerPoints()
    }
    
    func ORFilter(filters: [FilterType]) {
        let filtersResults = getFiltersResults(filters: filters)
        var indexesToRemove: [Int] = []
        for (index, point) in self.restoreHistory.enumerated() {
            var deleteCondition = false
            for res in filtersResults {
                if !res.contains(point) {
                    deleteCondition = true
                    break
                }
            }
            if deleteCondition {
                indexesToRemove.append(index)
            }
        }
        removePoints(indexesToRemove: indexesToRemove)
        removeNullPointerPoints()
    }
}

enum BackupError: Error {
    case InvalidFilterParametrs
    case PointCommitError
}

enum FilterType {
    case count(count: Int)
    case size(size: Float)
    case date(date: Date)
}

enum SaveType {
    case SeparateBackup
    case CommonBackup
}
