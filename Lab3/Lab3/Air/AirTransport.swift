class AirTransport: ITransport {

    public private(set) var speed: Double;

    init(speed: Double) {
        self.speed = speed
    }

    func distanceReducer(distance: Double) -> Double {
        preconditionFailure("This method must be overridden")
    }

    override func run(track: Track) -> Double {
        let reduceCoof = 1 - distanceReducer(distance: track.distance)
        return track.distance * reduceCoof / self.speed
    }
}

