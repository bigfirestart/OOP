import Foundation

class Backup {
    private(set) var restoreHistory: [RestorePoint] = []
    
    func commitRestorePoint(point: RestorePoint) throws {
        do {
            let actualPoint = try point.getActualRestorePointVersion()
            self.restoreHistory.append(actualPoint)
        }
        catch {
            throw BackupError.PointCommitError
        }
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
    }
    
    func filterByPointDate(minDateTime: Date){
        self.restoreHistory = DateFilter.filter(backup: self, param: minDateTime)
    }
    
    func filterByPointsCount(maxCount: Int) throws {
        if (maxCount < 0) {
            throw BackupError.InvalidFilterParametrs
        }
        if (maxCount < restoreHistory.count) {
            self.restoreHistory = CountFilter.filter(backup: self, param: maxCount)
        }
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
        for (index, point) in self.restoreHistory.enumerated() {
            var deleteCondition = true
            for res in filtersResults {
                if res.contains(point) {
                    deleteCondition = false
                    break
                }
            }
            if deleteCondition {
                self.restoreHistory.remove(at: index)
            }
        }
    }
    
    func ORFilter(filters: [FilterType]) {
        let filtersResults = getFiltersResults(filters: filters)
        for (index, point) in self.restoreHistory.enumerated() {
            var deleteCondition = false
            for res in filtersResults {
                if res.contains(point) {
                    deleteCondition = true
                    break
                }
            }
            if deleteCondition {
                self.restoreHistory.remove(at: index)
            }
        }
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
