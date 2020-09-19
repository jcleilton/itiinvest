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

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = FundsListViewModel(manager: CoreDataManagerMocked())
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testExample() throws {
        
    }
}
