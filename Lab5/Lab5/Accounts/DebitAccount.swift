import Foundation

class DatedAmount {
    var amount: Float
    var date: Date = Date()
    
    init(amount: Float) {
        self.amount = amount
    }
}

class DebitAccount: Account {
    var balanceHistory: [DatedAmount] = []
    private(set) var procent: Float
    
    init(client: Client, procent: Float) {
        self.procent = procent
        super.init(client: client)
    }
    
    override func getAccountAfterActionAmountChange() throws -> Float {
        self.balanceHistory = self.balanceHistory.sorted(by: {(first, second) -> Bool in
                                    return first.date > second.date})
        var prevDate = Date()
        var finalAmount = Float(0)
        
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        
        for da in self.balanceHistory {
            let date = da.date
            let amount = da.amount
 
            
            let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: prevDate)
            
            if difference.day! > 1 {
                finalAmount = finalAmount + amount * (self.procent/100)
                prevDate = date
            }
        }
        return finalAmount
    }
    
    override func afterTransactionNotice(account: Account, amount: Float) {
        balanceHistory.append(DatedAmount(amount: self.amount))
    }
}


