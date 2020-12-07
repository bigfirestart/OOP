class TinkoffBank: AbstractBank {
    func createDepositAccount(client: Client, masterAccount: Account, amount: Float) throws -> DepositAccount {
        do{
            return try super.createDepositAccount(client: client, masterAccount: masterAccount, amount: amount, procent: 3.5, durationDays: 90)
        }
        catch{
            print(error)
            throw error
        }
    }
}
