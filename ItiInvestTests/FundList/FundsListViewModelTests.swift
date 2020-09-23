//
//  FundsListViewModelTests.swift
//  ItiInvestTests
//
//  Created by Cleilton Feitosa on 19/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import XCTest
@testable import ItiInvest

class FundsListViewModelTests: XCTestCase {
    var sut: FundsListViewModel!

    override func setUp() {
        super.setUp()
        sut = FundsListViewModel(manager: CoreDataManagerMocked())
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExample() throws {
        
    }
}
