import Foundation

class RestorePoint: Equatable {
    
    static func == (lhs: RestorePoint, rhs: RestorePoint) -> Bool {
        if !(lhs.creationDateTime == rhs.creationDateTime){
            return false
        }
        for file in lhs.files {
            if !rhs.files.contains(file) {
                return false
            }
        }
        return true
    }
    
    private(set) var files: [BackupFile] = []
    private(set) var creationDateTime: Date = Date()
    
    var size: Float {
        get {
            var filesSum: Float = 0.0
            for file in self.files {
                filesSum += file.size
            }
            return filesSum
        }
    }
    
    private func getFileSize(path: String) throws -> Float {
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let url = dir.appendingPathComponent(path)
            return try FileManager.default.attributesOfItem(atPath: url.path)[.size]! as! Float
        }
        else {
            throw RestorePointError.ErrorWithDefaultPath
        }
    }
    
    
    func fileExists(path: String) throws -> Bool {
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let url = dir.appendingPathComponent(path)
            return FileManager.default.fileExists(atPath: url.path)
        }
        else {
            throw RestorePointError.ErrorWithDefaultPath
        }
    }
    
    func addFile(path: String) throws {
        if try fileExists(path: path) {
            let size = try getFileSize(path: path)
            if let removeIndex = findFileDuplicateInPoint(path: path){
                removeFile(index: removeIndex)
            }
            self.files.append(BackupFile(name: path, size: size))
        }
        else {
            throw RestorePointError.NoSuchFile
        }
    }
    
    func addFolderFiles(path: String) throws {
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let url = dir.appendingPathComponent(path)
            do {
                let filesInFolder = try FileManager.default.contentsOfDirectory(atPath: url.path)
                for file in filesInFolder {
                    let fileUrl = path + file
                    try addFile(path: fileUrl)
                }
            }
            catch {
                throw RestorePointError.FolderContentError
            }
        }
        else {
            throw RestorePointError.ErrorWithDefaultPath
        }
    }
    
    func findFileDuplicateInPoint(path: String) -> Int? {
        for (index, file) in self.files.enumerated(){
            if file.path == path {
                return index
            }
        }
        return nil
    }
    
    func removeFile(index: Int){
       self.files.remove(at: index)
    }
    
    func getActualRestorePointVersion() throws -> RestorePoint {
        let copiedPoint = RestorePoint()
        for file in self.files{
            if try fileExists(path: file.path) {
                let size = try getFileSize(path: file.path)
                copiedPoint.files.append(BackupFile(name: file.path, size: size))
            }
        }
        return copiedPoint
    }
    
    func getActualRestorePointDiffinition() throws -> RestorePoint {
        let copiedPoint = RestorePoint()
        for file in self.files{
            if try fileExists(path: file.path) {
                let sizeDif = try getFileSize(path: file.path) - file.size
                copiedPoint.files.append(BackupFile(name: file.path, size: sizeDif))
            }
        }
        return copiedPoint
    }
}


enum RestorePointError: Error{
    case ErrorWithDefaultPath
    case NoSuchFile
    case CantGetFileSize
    case FolderContentError
}
