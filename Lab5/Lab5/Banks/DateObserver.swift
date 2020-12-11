import Foundation

class DateObserver {
    var lastDateUpdate = Date()
    var timeNow = Date()
    var hackTimeFlag: Bool = false
    
    private var bank: AbstractBank
    init(bank: AbstractBank){
        self.bank = bank
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        DispatchQueue.global().async {
            while true {
                if !self.hackTimeFlag {
                    self.timeNow = Date()
                }
                let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: self.lastDateUpdate, to: self.timeNow)
                if difference.month ?? 0 > 0 {
                    bank.doNewMonthAction()
                    self.lastDateUpdate = Date()
                }
            }
        }
    }
}
