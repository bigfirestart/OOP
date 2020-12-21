//
//  Lab5Tests.swift
//  Lab5Tests
//
//  Created by Кирилл Лукьянов on 07.12.2020.
//

import XCTest
@testable import Lab5

class Lab5Tests: XCTestCase {
    func testTransactions(){
        let client = Client(firstName: "Mark", secondName: "Karshtain")

        let accountFrom = Account(client: client)
        let accountTo = Account(client: client)
        let gts = GTS()
        let bd = GTSBackdoor()

        bd.accountAddMoney(account: accountFrom, amount: 200)

        XCTAssertEqual(accountFrom.amount, 200)
        let transaction = Transaction(fromAccount: accountFrom, toAccount: accountTo, amount: 10)
        
        XCTAssertNoThrow(try gts.commitTransaction(transaction: transaction))
        
        XCTAssertEqual(accountFrom.amount, 190)
        XCTAssertEqual(accountTo.amount, 10)

        XCTAssertTrue(gts.rollbackTransaction(transactionUUID: transaction.uuid))
        XCTAssertEqual(gts.transactionsHistory.count, 0)

        XCTAssertEqual(accountFrom.amount, 200)
        XCTAssertEqual(accountTo.amount, 0)
    }
    
    func testAccounts(){
        let bankClient = Client(firstName: "Mark", secondName: "1")
        let master = Account(client: bankClient)
        let bank = AbstractBank(masterAccount: master)
        let hack = GTSBackdoor()
        hack.accountAddMoney(account: master, amount: 1000.0)
        
        let userClient = Client(firstName: "User", secondName: "2")
        let userDebit = bank.createDebitAccount(client: userClient, procent: 3.2)
        let userCredit = bank.createCreditAccount(client: userClient, masterAccount: master, creditLimit: 500, comission: 100 )
        
        XCTAssertEqual(userCredit.amount, 0)
        XCTAssertTrue(bank.pay(fromAccount: userCredit, toAccount: userDebit, amount: 100))
        XCTAssertEqual(userDebit.amount, 100)
        XCTAssertEqual(master.amount, 900)
        XCTAssertEqual(userCredit.amount, 0)
    }
}
