class CreditAccount: Account {
    var creditLimit: Float
    private(set) var commission: Float
    var creditFromAccount: Account
    
    init(creditFromAccount: Account, client: Client, creditLimit: Float, comission: Float) {
        self.creditFromAccount = creditFromAccount
        self.creditLimit = creditLimit
        self.commission = comission
        super.init(client: client)
    }
    
    override func prepareAccountPayment(amount: Float) -> Account {
        if self.amount < amount && self.creditLimit > 0 {
            return self.creditFromAccount
        }
        return self
    }
    
    override func afterTransactionNotice(account:Account, amount: Float) {
        if amount < 0 && account !== self {
            self.creditLimit = self.creditLimit-amount
        }
    }
}
