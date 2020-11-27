class ITransport {
    func run(track: Track) -> Double {
        preconditionFailure("This method must be overridden")
    }
}
