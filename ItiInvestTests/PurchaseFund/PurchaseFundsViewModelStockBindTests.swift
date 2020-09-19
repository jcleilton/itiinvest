//
//  PurchaseFundsViewModelStockBindTests.swift
//  ItiInvestTests
//
//  Created by Cleilton Feitosa on 19/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import XCTest
@testable import ItiInvest

class PurchaseFundsViewModelStockBindTests: XCTestCase {
    var sut: PurchaseFundViewModel!
    var stock: Stock {
        let stock = Stock(context: context)
        stock.name = "Test"
        stock.buyDate = Date()
        stock.price = 20.55
        stock.quantity = 2
        return stock
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = PurchaseFundViewModel(stock: stock)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testBindingName() throws {
        let name = sut.stockName
        XCTAssertEqual(name, "Test", "Wrong name")
    }
    
    func testBindingQuantity() throws {
        let quantity = sut.stockAmount
        XCTAssertEqual(quantity, "2", "Wrong name")
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
        XCTAssertEqual(price, "R$ 20,55", "Wrong name")
    }
    
    func testBindingTitle() throws {
        let title = sut.getTitle
        let editTitle = LocalizableStrings.formTitleEdit.localized()
        XCTAssertEqual(title, editTitle, "Wrong name")
    }
}
