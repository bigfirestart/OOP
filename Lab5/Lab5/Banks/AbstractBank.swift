import Foundation

class AbstractBank {
    private(set) var accounts: [Account] = []
    private var gts = GTS()
    private(set) var masterAccount: Account
    
    
    init(masterAccount: Account){
        self.masterAccount = masterAccount
        let _ = DateObserver(bank: self)
    }
    
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
    
    func createCreditAccount(client: Client, masterAccount: Account, amount: Float, creditLimit: Float, comission: Float) -> Account {
        let creditAccount = CreditAccount(creditFromAccount: masterAccount, client: client, creditLimit: creditLimit, comission: comission)
        return creditAccount
        
    }
    
    func createDebitAccount(client: Client, procent: Float) -> Account {
        let debitAccount = DebitAccount(client: client, procent: procent)
        return debitAccount
    }
    
    func pay(fromAccount: Account, toAccount: Account, amount: Float) -> Bool {
        let transactionFrom = fromAccount.prepareAccountPayment(amount: amount)
        let transaction = Transaction(fromAccount: transactionFrom, toAccount: toAccount, amount: amount)
        do{
            let _ = try self.gts.commitTransaction(transaction: transaction)
            fromAccount.afterTransactionNotice(account: transactionFrom, amount: -1*amount)
            toAccount.afterTransactionNotice(account: toAccount, amount: amount)
            return true
        }
        catch {
            return false
        }
    }
    
    func doNewMonthAction() {
        for account in self.accounts {
            do {
                let amount  = try account.getAccountAfterActionAmountChange()
                if amount > 0 {
                    let _ = pay(fromAccount: self.masterAccount, toAccount: account, amount: amount)
                }
                else {
                    let _ = pay(fromAccount: account, toAccount: self.masterAccount, amount: amount * -1)
                }
            }
            catch{
                print(error)
            }
        }
    }
}

enum BankError: Error {
    case AccountCreationError
}

