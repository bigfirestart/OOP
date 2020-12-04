struct Transaction {
    private(set) var fromAccount: Account
    private(set) var toAccount: Account
    private(set) var amount: Float
    
    init(fromAccount: Account, toAccount: Account, amount: Float){
        self.fromAccount = fromAccount
        self.toAccount = toAccount
        //check ammount on from account
        self.amount = amount
    }
}
