class Race<T> where T: ITransport {

    public private(set) var track: Track
    public private(set) var transportArr: [ITransport] = [ITransport]()

    init(track: Track) {
        self.track = track
    }

    func registerTransport(transport: T) {
        self.transportArr.append(transport)
    }

    func start() throws -> ITransport {
        if (self.transportArr.count == 0) {
            throw RaceError.emptyRace
        }
        var minValue = self.transportArr[0].run(track: self.track)
        print(minValue)
        var idx = 0
        for i in 1...self.transportArr.count - 1
        {
            let curValue = transportArr[i].run(track: self.track)
            print(curValue)
            if (curValue < minValue) {
                minValue = curValue;
                idx = i;
            }
        }
        return self.transportArr[idx];
    }
}

enum RaceError: Error {
    case emptyRace
}
