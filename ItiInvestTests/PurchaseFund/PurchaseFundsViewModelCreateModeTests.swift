//
//  PurchaseFundsViewModelCreateModeTests.swift
//  ItiInvestTests
//
//  Created by Cleilton Feitosa on 19/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import XCTest
@testable import ItiInvest

class PurchaseFundsViewModelCreateModeTests: XCTestCase {
    var uit: PurchaseFundViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        uit = PurchaseFundViewModel()
    }

    override func tearDownWithError() throws {
        uit = nil
        try super.tearDownWithError()
    }

    func testBindingName() throws {
        let name = uit.stockName
        XCTAssertEqual(name, "", "Wrong name")
    }
    
    func testBindingQuantity() throws {
        let quantity = uit.stockAmount
        XCTAssertEqual(quantity, "0", "Wrong name")
    }
    
    func testBindingBuyDate() throws {
        let date = uit.stockDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale.init(identifier: "pt-br")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let testDate = dateFormatter.string(from: Date())
        XCTAssertEqual(date, testDate, "Wrong name")
    }
    
    func testBindingPrice() throws {
        let price = uit.stockPrice
        XCTAssertEqual(price, "R$ 0,00", "Wrong name")
    }
    
    func testBindingTitle() throws {
        let title = uit.getTitle
        let editTitle = LocalizableStrings.formTitle.localized()
        XCTAssertEqual(title, editTitle, "Wrong name")
    }
}
