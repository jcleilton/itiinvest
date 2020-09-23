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
    // MARK: - Properties
    let manager = CoreDataManager()
    weak var coordinator: FundsListCoordinator?
    
    lazy var fundsListView: FundsListView = {
        let fundsListView = FundsListView()
        fundsListView.tableView.delegate = self
        fundsListView.tableView.dataSource = self
        fundsListView.tableView.register(FundTableViewCell.self, forCellReuseIdentifier: FundTableViewCell.identifier)
        return fundsListView
        
    }()
    
    // MARK: - Super Methods
    override func loadView() {
        super.loadView()
        fundsListView.tableView.delegate = self
        fundsListView.tableView.dataSource = self
        view = fundsListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.performFetch()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        let gradient = CAGradientLayer()

        view.layer.insertSublayer(gradient, at: 0)

        fundsListView.bottomButton.addTarget(self, action: #selector(self.goToNewStock(_:)), for: UIControl.Event.touchUpInside)
    }

    private func amountValue() -> Double {
        let stockValue = manager.fetchedResultsController.fetchedObjects?.reduce(0.0, { (result, stock) -> Double in
            (stock.price * Double(Int(stock.quantity))) + result
        })
        self.fundsListView.valueLabel.text = "R$ \(stockValue ?? 0.0)"
        self.fundsListView.valueLabel.accessibilityLabel = "$ \(stockValue ?? 0.0)"
        return stockValue ?? 0.0
    }

    @objc func goToNewStock(_ sender: Any) {
        coordinator?.showPurchaseFund(viewModel: PurchaseFundViewModel())
    }

    deinit {
        coordinator?.childDidFinish(nil)
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, view, handler) in
            guard let self = self else { return }
            let stock = self.manager.getStockAt(indexPath)
            do {
                try self.manager.delete(data: stock)
                tableView.reloadData()
            } catch {
                self.showFailDeleteAlert()
            }
        }
        shareAction.backgroundColor = UIColor.red
        let configuration = UISwipeActionsConfiguration(actions: [shareAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(style: .normal, title: "Editar") { [weak self] (action, view, handler) in
            guard let self = self else { return }
            let viewModel = PurchaseFundViewModel(stock: self.manager.getStockAt(indexPath))
            self.coordinator?.showPurchaseFund(viewModel: viewModel)
        }
        shareAction.backgroundColor = UIColor.systemBlue
        let configuration = UISwipeActionsConfiguration(actions: [shareAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showDetails(stock: manager.getStockAt(indexPath))
    }
    
    private func showFailDeleteAlert() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            Alert.defaultWithOKButton(in: self, title: "Atenção", subtitle: "Não foi possível apagar...") {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}

extension FundsListViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        fundsListView.tableView.reloadData()
    }
}
