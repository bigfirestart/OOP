class Broom: AirTransport {
    init() {
        super.init(speed: 20.0)
    }
    override func distanceReducer(distance: Double) -> Double {
        return distance / 100000
    }
}
