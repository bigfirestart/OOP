class creditAccount: Account {
    var creditLimit: Float = 0.0
    var creditFromAccount: Account
    
    init(creditFromAccount: Account, client: Client) {
        self.creditFromAccount = creditFromAccount
        super.init(client: client)
    }
    
    override func getAccount() -> Account {
        return self.creditFromAccount
    }
}
