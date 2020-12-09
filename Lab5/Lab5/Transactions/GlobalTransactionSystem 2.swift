class Account {
    private(set) var client: Client
    fileprivate(set) var amount: Float = 0.0
    fileprivate var lock = false
    
    init(client: Client) {
        self.client = client
    }
}

class GTS {
    private(set) var connectedBanks: [AbstractBank] = []
    private(set) var transactionsHistory: [Transaction] = []
    
    fileprivate func accountWithdrawMoney(account: Account, amount: Float) {
        account.amount = account.amount - amount
    }
    
    fileprivate func accountAddMoney(account: Account, amount: Float) {
        account.amount = account.amount + amount
    }
    
    private func historyContainsUUID (uuid: String) -> Bool {
        for transaction in self.transactionsHistory {
            if transaction.uuid == uuid {
                return true
            }
        }
        return false
    }
    
    func commitTransaction(transaction: Transaction) throws -> Bool {
        if (transaction.fromAccount.amount < transaction.amount) {
            throw GTSError.LowFromAccountBalance
        }
        if (historyContainsUUID(uuid: transaction.uuid)) {
            throw GTSError.LowFromAccountBalance
        }
        if (transaction.fromAccount.lock || transaction.toAccount.lock){
            throw GTSError.LockedAccountTransaction
        }
        
        accountWithdrawMoney(account: transaction.fromAccount, amount: transaction.amount)
        accountAddMoney(account: transaction.toAccount, amount: transaction.amount)
        
        self.transactionsHistory.append(transaction)
        return true
    }
    
    func rollbackTransaction(transactionUUID: String) -> Bool {
        if (historyContainsUUID(uuid: transactionUUID)) {
            let transaction = self.transactionsHistory.filter{$0.uuid == transactionUUID}.first!
            accountWithdrawMoney(account: transaction.toAccount, amount: transaction.amount)
            accountAddMoney(account: transaction.fromAccount, amount: transaction.amount)
            transactionsHistory.removeAll{$0.uuid == transactionUUID}
            return true
        }
        else {
            return false
        }
    }
    
    func lockAccount(account: Account){
        account.lock = true
    }
    
}

enum GTSError: Error {
    case LowFromAccountBalance
    case CantCommentSimularTransactions
    case LockedAccountTransaction
}


class GTSBackdoor: GTS {
    override func accountWithdrawMoney(account: Account, amount: Float){
        super.accountWithdrawMoney(account: account, amount: amount)
    }
    override func accountAddMoney(account: Account, amount: Float) {
        super.accountAddMoney(account: account, amount: amount)
    }
}

