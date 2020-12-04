struct Account {
    private(set) var client: Client
    private(set) var ammount: Float = 0.0
    init(client: Client) {
        self.client = client
    }
}
