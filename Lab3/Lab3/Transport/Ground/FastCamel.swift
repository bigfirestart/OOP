class FastCammel: GroundTransport {

    init() {
        super.init(speed: 40, restDistance: 10)
    }

    override func restDuration(iter: Int) -> Double {
        switch iter {
        case 1:
            return 5
        case 2:
            return 6.5
        default:
            return 8
        }
    }
}
