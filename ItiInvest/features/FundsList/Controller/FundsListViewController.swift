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
    weak var coordinator: FundsListCoordinator?
    var viewModel: FundsListViewModel?
    
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
        self.viewModel?.performFetch()
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

    

    @objc func goToNewStock(_ sender: Any) {
        if let purchaseViewModel = self.viewModel?.getCreationViewModel() {
            coordinator?.showPurchaseFund(viewModel: purchaseViewModel)
        }
    }

    deinit {
        coordinator?.childDidFinish(nil)
    }
}

extension FundsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.total ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FundTableViewCell.identifier) as? FundTableViewCell else { return UITableViewCell() }
        
        if let stockViewModel = viewModel?.getListCellViewModel(from: indexPath) {
            cell.setup(viewModel: stockViewModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, view, handler) in
            guard let self = self else { return }
            do {
                try self.viewModel?.deleteStock(at: indexPath)
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
            if let viewModel = self.viewModel?.getEditionViewModel(from: indexPath) {
                self.coordinator?.showPurchaseFund(viewModel: viewModel)
            }
        }
        shareAction.backgroundColor = UIColor.systemBlue
        let configuration = UISwipeActionsConfiguration(actions: [shareAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewModel = self.viewModel?.getDetailViewModel(from: indexPath) {
            coordinator?.showDetails(viewModel: detailViewModel)
        }
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

extension FundsListViewController: FundsListViewModelDelegate {
    func didFinishFetching() {
        self.fundsListView.valueLabel.text = viewModel?.userTotal
        self.fundsListView.tableView.reloadData()
    }
}
