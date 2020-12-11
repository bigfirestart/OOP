import Foundation

class DepositAccount: Account {
    private(set) var procent: Float
    private(set) var startDate: Date?
    private(set) var durationDays: Int?
    
    
    init(masterAccount: Account, client: Client, procent: Float){
        self.procent = procent
        super.init(client: client)
    }
    
    func setDuration(durationDays: Int = 30){
        self.durationDays = durationDays
        self.startDate = Date()
    }
    
    func isPaymentRaady() -> Bool {
        let depositEnd = Calendar.current.date(byAdding: .day, value: self.durationDays!, to: self.startDate!)
        return depositEnd! < Date()
    }
    
    override func getAccountAfterActionAmountChange() -> Float {
        return super.amount * (1 + self.procent/100)
    }

}
