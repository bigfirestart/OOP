protocol FilterProtocol {
    associatedtype ParamType
    static func filter(backup: Backup, param: ParamType) -> [RestorePoint]
}
