class BackupFile: Equatable {
    
    static func == (lhs: BackupFile, rhs: BackupFile) -> Bool {
        if (lhs.path == rhs.path) && (lhs.size == rhs.size) {
            return true
        }
        return false
    }
    
    private(set) var path: String
    private(set) var size: Float
    public init(name: String, size: Float) {
        self.path = name
        self.size = size
    }
}
