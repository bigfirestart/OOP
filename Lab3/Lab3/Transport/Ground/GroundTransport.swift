import Foundation

class GroundTransport: ITransport {

    public private(set) var speed: Double
    public private(set) var restDistance: Double

    init(speed: Double, restDistance: Double) {
        self.speed = speed
        self.restDistance = restDistance
    }

    func restDuration(iter: Int) -> Double {
        preconditionFailure("This method must be overridden")
    }

    override func run(track: Track) -> Double {
        var time = track.distance / self.speed;

        let count = Int(time / self.restDistance) - 1

        for i in 0...count {
            time += self.restDuration(iter: i + 1)
        }
        return time
    }
}
