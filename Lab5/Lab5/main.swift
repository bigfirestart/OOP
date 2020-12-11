import Foundation

let master = DebitAccount(client: bankClient, procent: 3.2)
let bank = AbstractBank(masterAccount: master)
let bankClient = Client(firstName: "Mark", secondName: "1")
let hack = GTSBackdoor()


hack.accountAddMoney(account: master, amount: 1000.0)
let gts = GTS()

let second = Account(client: bankClient)

let transaction = Transaction(fromAccount: master, toAccount: second, amount: 100)
let _ = try gts.commitTransaction(transaction: transaction)

print(master.amount)

sleep(10)
