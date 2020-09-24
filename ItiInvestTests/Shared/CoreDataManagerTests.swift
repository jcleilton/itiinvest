//
//  CoreDataManagerTests.swift
//  ItiInvestTests
//
//  Created by Cleilton Feitosa on 19/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import XCTest
@testable import ItiInvest
import Foundation

class CoreDataManagerTests: XCTestCase {
    var sut: CoreDataManager!

    override func setUp() {
        super.setUp()
        sut = CoreDataManager()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testFetch() throws {
        let expectation = XCTestExpectation(description: "didFetch")
        sut.performFetch()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
            do {
                try _ = XCTUnwrap(self.sut.fetchedResultsController.fetchedObjects)
                expectation.fulfill()
            } catch {
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 4.0)
    }
}
