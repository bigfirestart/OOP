var airRace = AirRace(track: Track(distance: 1000))

airRace.registerTransport(transport: MagicCarpet())
airRace.registerTransport(transport: Mortar())
airRace.registerTransport(transport: Broom())

//try print(airRace.start())

var groundRace = GroundRace(track: Track(distance: 1000))

groundRace.registerTransport(transport: TwoHeadCamel())
groundRace.registerTransport(transport: FastCammel())
groundRace.registerTransport(transport: Centaur())
groundRace.registerTransport(transport: Boots())

//try print(groundRace.start())

var commonRace = CommonRace(track: Track(distance: 1000))

commonRace.registerTransport(transport: TwoHeadCamel())
commonRace.registerTransport(transport: FastCammel())
commonRace.registerTransport(transport: Centaur())
commonRace.registerTransport(transport: Boots())
commonRace.registerTransport(transport: MagicCarpet())
commonRace.registerTransport(transport: Mortar())
commonRace.registerTransport(transport: Broom())

try print(commonRace.start())


