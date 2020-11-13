class Boots: GroundTransport {

    init() {
        super.init(speed: 6, restDistance: 60)
    }

    override func restDuration(iter: Int) -> Double {
        if (iter == 1){
            return 10
        }
        return 5
    }
}

