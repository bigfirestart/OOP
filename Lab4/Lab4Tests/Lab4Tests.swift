//
//  Lab4Tests.swift
//  Lab4Tests
//
//  Created by Кирилл Лукьянов on 23.11.2020.
//
@testable import Lab4
import XCTest

class Lab4Tests: XCTestCase {
    
    func testBackup1() throws {
        let path1 = "ITMO/OOP/Lab4/Files/1.txt"
        let path2 = "ITMO/OOP/Lab4/Files/2.txt"

        let backup = Backup()
        let rp = RestorePoint()
        
        XCTAssertNoThrow(try rp.addFile(path: path1))
        XCTAssertNoThrow(try rp.addFile(path: path2))
        
        XCTAssertNoThrow(try backup.commitRestorePoint(point: rp))
        sleep(1)
        XCTAssertNoThrow(try backup.commitRestorePoint(point: rp))
        sleep(1)
        
        XCTAssertEqual(backup.restoreHistory.count, 2)
        
        XCTAssertNoThrow(try backup.commitRestorePoint(point: rp))
        sleep(1)
        
        XCTAssertNoThrow(try backup.filterByPointsCount(maxCount: 1))
        
        XCTAssertEqual(backup.restoreHistory.count, 1)
    }
    
    func testBackup2() throws{
        let path1 = "ITMO/OOP/Lab4/Files/1.txt"
        let path2 = "ITMO/OOP/Lab4/Files/2.txt"

        let backup = Backup()
        let rp = RestorePoint()
        
        XCTAssertNoThrow(try rp.addFile(path: path1))
        XCTAssertNoThrow(try rp.addFile(path: path2))
        
        XCTAssertNoThrow(try backup.commitRestorePoint(point: rp))
        sleep(1)
        XCTAssertNoThrow(try backup.commitRestorePoint(point: rp))
        
        XCTAssertEqual(backup.restoreHistory.count, 2)
        XCTAssertEqual(backup.restoreHistory[0].size, 200.00)
        
    }
    
}
