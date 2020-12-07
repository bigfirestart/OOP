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

        gts.accountAddMoney(account: accountFrom, amount: 200)

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
}
