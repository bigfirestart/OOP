class AbstractBank {
    private(set) var accounts: [Account] = []
    private var gts = GTS()
    
    func createDepositAccount(client: Client, masterAccount: Account, amount: Float, procent: Float, durationDays: Int) throws -> DepositAccount {
        let depositAccount = DepositAccount(masterAccount: masterAccount, client: client, procent: procent)
        let transaction = Transaction(fromAccount: masterAccount , toAccount: depositAccount, amount: amount)
        do {
            let _ = try gts.commitTransaction(transaction: transaction)
            depositAccount.setDuration(durationDays: durationDays)
            self.accounts.append(depositAccount)
            gts.lockAccount(account: depositAccount)
            return depositAccount
        }
        catch{
            print(error)
            throw BankError.AccountCreationError
        }
    }
    
    func pay(fromAccount: Account, toAccount: Account, amount: Float){
        //if debit -> take from debit
        //if credit -> take from master
    }
}

enum BankError: Error {
    case AccountCreationError
}
