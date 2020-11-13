class Centaur: GroundTransport {

    init() {
        super.init(speed: 15, restDistance: 8)
    }

    override func restDuration(iter: Int) -> Double {
        return 2
    }
}
