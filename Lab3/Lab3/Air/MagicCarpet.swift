class MagicCarpet: AirTransport {

    init() {
        super.init(speed: 10.0)
    }
    override func distanceReducer(distance: Double) -> Double {
        if (distance < 1000) {
            return 0
        }
        if (distance < 5000) {
            return 0.03
        }
        if (distance < 10000) {
            return 0.1
        };
        return 0.05
    }
}
