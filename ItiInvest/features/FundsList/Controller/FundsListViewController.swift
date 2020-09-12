//
//  FundsListViewController.swift
//  ItiInvest
//
//  Created by Pericles Junor on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit
import CoreData

class FundsListViewController: UIViewController {

//    // MARK: - Outlets
//    @IBOutlet weak var backgroundGradientView: UIView!
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var totalAmountLabel: UILabel!
//    @IBOutlet weak var hideAmountButton: UIButton!
//    @IBOutlet weak var patrimonyLabel: UILabel!
//    @IBOutlet weak var newInvestmentButton: UIButton!
    
    let manager = CoreDataManager()
    
    lazy var fundsListView: FundsListView = {
        let fundsListView = FundsListView()
        fundsListView.tableView.delegate = self
        fundsListView.tableView.dataSource = self
        return fundsListView
        
    }()
    
    override func loadView() {
        super.loadView()
        print("LoadView")
        view = fundsListView
    }
    

    // MARK: - Parameters

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.performFetch()
        setupView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fundsListView.contentView.applyGradient(color1: UIColor(hex: "#f16546") ?? .orange, color2: UIColor(hex: "#ed6a2a") ?? .red, locations: [0.0, 1.0])
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
//        tableView.delegate = self
//        tableView.dataSource = self

        let gradient = CAGradientLayer()

//        gradient.frame = backgroundGradientView.bounds
//        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]

        view.layer.insertSublayer(gradient, at: 0)
        
//        self.newInvestmentButton.applyGradient(color1: ITIColor.orange, color2: ITIColor.purple, locations: [0.0, 1.0])
//        self.newInvestmentButton.applyCornerRadius()
        
    }

    private func roundCorners() {
        // TODO: -
    }
    private func amountValue() -> Double {
        let stockValue = manager.fetchedResultsController.fetchedObjects?.reduce(0.0, { (result, stock) -> Double in
            (stock.price * Double(Int(stock.quantity))) + result
        })
        //self.totalAmountLabel.text = "R$ \(stockValue ?? 0.0)"
        return stockValue ?? 0.0
    }
    
    private func setupAccessibility() {
        //hideAmountButton.accessibilityLabel = LocalizableStrings.hideShowButton.localized()
    }
  
    @IBAction func goToNewStock(_ sender: Any) {
//        let storyBoard = UIStoryboard.init(name: "Detail", bundle: nil)
//        if let viewController = storyBoard.instantiateInitialViewController() {
//            self.navigationController?.pushViewController(viewController, animated: true)
//        }
        
    }
}

extension FundsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.total
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FundTableViewCell.identifier) as? FundTableViewCell else { return UITableViewCell() }

        let stock = manager.getStockAt(indexPath)
        cell.setup(with: stock.name ?? "", amount: stock.price, userAmount: amountValue())

        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
        }

        let share = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            // edit item at indexPath
        }

        share.backgroundColor = UIColor.blue

        return [delete, share]
    }
}

extension FundsListViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //tableView.reloadData()
    }
}
