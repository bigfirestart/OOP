//Ступа
class Mortar: AirTransport {
    init() {
        super.init(speed: 8.0)
    }
    override func distanceReducer(distance: Double) -> Double {
        return 0.06
    }
}
