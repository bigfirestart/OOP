class TwoHeadCamel: GroundTransport {

    init() {
        super.init(speed: 10, restDistance: 30)
    }

    override func restDuration(iter: Int) -> Double {
        if (iter == 1){
            return 5
        }
        return 8
    }
}
