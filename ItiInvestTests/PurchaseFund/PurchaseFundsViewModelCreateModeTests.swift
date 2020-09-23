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
    var sut: PurchaseFundViewModel!

    override func setUp() {
        super.setUp()
        sut = PurchaseFundViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testBindingName() throws {
        let name = sut.stockName
        XCTAssertEqual(name, "", "Wrong name")
    }
    
    func testBindingQuantity() throws {
        let quantity = sut.stockAmount
        XCTAssertEqual(quantity, "0", "Wrong name")
    }
    
    func testBindingBuyDate() throws {
        let date = sut.stockDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale.init(identifier: "pt-br")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let testDate = dateFormatter.string(from: Date())
        XCTAssertEqual(date, testDate, "Wrong name")
    }
    
    func testBindingPrice() throws {
        let price = sut.stockPrice
        XCTAssertEqual(price, "R$ 0,00", "Wrong name")
    }
    
    func testBindingTitle() throws {
        let title = sut.getTitle
        let editTitle = LocalizableStrings.formTitle.localized()
        XCTAssertEqual(title, editTitle, "Wrong name")
    }
}
