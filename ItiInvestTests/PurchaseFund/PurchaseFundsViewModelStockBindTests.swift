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
    var uit: PurchaseFundViewModel!
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
        uit = PurchaseFundViewModel(stock: stock)
    }

    override func tearDownWithError() throws {
        uit = nil
        try super.tearDownWithError()
    }

    func testBindingName() throws {
        let name = uit.stockName
        XCTAssertEqual(name, "Test", "Wrong name")
    }
    
    func testBindingQuantity() throws {
        let name = uit.stockAmount
        XCTAssertEqual(name, "2", "Wrong name")
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
        XCTAssertEqual(price, "R$ 20,55", "Wrong name")
    }
    
    func testBindingTitle() throws {
        let title = uit.getTitle
        let editTitle = LocalizableStrings.formTitleEdit.localized()
        XCTAssertEqual(title, editTitle, "Wrong name")
    }
}