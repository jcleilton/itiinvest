//
//  HomeViewController.swift
//  ItiInvest
//
//  Created by Matheus Cardoso Kuhn on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

enum Product: CaseIterable {
    case investiment
    case card
    case cashback
    
    var title: String {
        switch self {
        case .investiment:
            return "investir"
        case .card:
            return "cadastrar"
        case .cashback:
            return "cashback"
        }
    }
    
    var description: String {
        switch self {
        case .investiment:
            return "investir seu dinheiro"
        case .card:
            return "cartão"
        case .cashback:
            return "dinheiro de volta"
        }
    }
    
    var backgroundImage: UIImage? {
        switch self {
        case .investiment:
            return UIImage(named: "investiment")
        case .card:
            return UIImage(named: "card")
        case .cashback:
            return UIImage(named: "cashback")
        }
    }
}

final class HomeViewController: UIViewController {
    // MARK: - IBOutlets
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "DarkGray")
        return view
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Line")
        return view
    }()
    
    private let balanceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "DarkGray")
        return view
    }()
    
    private let profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let seeProfileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    
    private let balanceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    private let iconImageView = UIImageView(image: #imageLiteral(resourceName: "perfil.png"))
    
    private let arrowProfileImageView = UIImageView(image: #imageLiteral(resourceName: "arrow"))
    
    private let balanceArrowImageView = UIImageView(image: #imageLiteral(resourceName: "arrow"))
    
    private let arrowUpImageView = UIImageView(image: #imageLiteral(resourceName: "arrow_up"))
    
    private let profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .white
        label.text = "Eric"
        return label
    }()
    
    private let myProfileLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
                label.textColor = .white
        label.text = "ver meu perfil"
        return label
    }()
    
    private let balanceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.text = "saldo iti"
        return label
    }()
    
    private let balanceValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .white
        label.text = "R$0,00"
        return label
    }()
    
    private let knowMoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.text = "tudo sobre seu iti"
        return label
    }()
    
    private let balanceVisibilityButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "invisible"), for: .normal)
        return button
    }()
    
    private lazy var productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let margin: CGFloat = 15
        let availableSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.3)
        let cellWidth = (availableSize.width / CGFloat(2.10)).rounded(.down)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: cellWidth, height: availableSize.height)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Variables
    private let products: [Product] = Product.allCases
    private let viewModel: HomeViewModeling
    
    // MARK: - Life Cycle
    init(viewModel: HomeViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    private func buildViewHierarchy() {
        view.addSubview(headerView)
        view.addSubview(lineView)
        view.addSubview(balanceStackView)
        view.addSubview(productCollectionView)
        view.addSubview(arrowUpImageView)
        view.addSubview(knowMoreLabel)
        headerView.addSubview(iconImageView)
        headerView.addSubview(profileStackView)
        profileStackView.addArrangedSubview(profileNameLabel)
        profileStackView.addArrangedSubview(seeProfileStackView)
        seeProfileStackView.addArrangedSubview(myProfileLabel)
        seeProfileStackView.addArrangedSubview(arrowProfileImageView)
        balanceStackView.addArrangedSubview(balanceTitleLabel)
        balanceStackView.addArrangedSubview(balanceView)
        balanceView.addSubview(balanceValueLabel)
        balanceView.addSubview(balanceVisibilityButton)
        balanceView.addSubview(balanceArrowImageView)
    }
    
    private func setupConstraints() {
        let topFlexibleConstraint = headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 60)
        topFlexibleConstraint.priority = .defaultHigh
        topFlexibleConstraint.isActive = true
        headerView.topAnchor.constraint(greaterThanOrEqualTo: view.layoutMarginsGuide.topAnchor, constant: 10).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        headerView.trailingAnchor.constraint(lessThanOrEqualTo: view.layoutMarginsGuide.trailingAnchor, constant: -40).isActive = true
        
        iconImageView.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: profileStackView.leadingAnchor, constant: 20).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        profileStackView.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        profileStackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        profileStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        
        lineView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20).isActive = true
        lineView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        lineView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        balanceStackView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 20).isActive = true
        balanceStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        balanceStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        
        balanceValueLabel.topAnchor.constraint(equalTo: balanceView.topAnchor).isActive = true
        balanceValueLabel.bottomAnchor.constraint(equalTo: balanceView.bottomAnchor).isActive = true
        balanceValueLabel.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor).isActive = true
        balanceValueLabel.trailingAnchor.constraint(equalTo: balanceVisibilityButton.leadingAnchor, constant: -20).isActive = true
        
        balanceVisibilityButton.centerYAnchor.constraint(equalTo: balanceValueLabel.centerYAnchor).isActive = true
        balanceVisibilityButton.trailingAnchor.constraint(lessThanOrEqualTo: balanceArrowImageView.leadingAnchor, constant: -20).isActive = true
        balanceVisibilityButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        balanceVisibilityButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        balanceArrowImageView.centerYAnchor.constraint(equalTo: balanceValueLabel.centerYAnchor).isActive = true
        balanceArrowImageView.trailingAnchor.constraint(equalTo: balanceView.trailingAnchor).isActive = true
        balanceArrowImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        balanceArrowImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        productCollectionView.topAnchor.constraint(greaterThanOrEqualTo: balanceStackView.bottomAnchor, constant: 10).isActive = true
        productCollectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        productCollectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        
        arrowUpImageView.topAnchor.constraint(equalTo: productCollectionView.bottomAnchor, constant: 40).isActive = true
        arrowUpImageView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        arrowUpImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        arrowUpImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        knowMoreLabel.topAnchor.constraint(equalTo: arrowUpImageView.bottomAnchor, constant: 4).isActive = true
        knowMoreLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 20).isActive = true
        knowMoreLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
    }
    
    private func configureViews() {
        view.backgroundColor = UIColor(named: "DarkGray")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "qrcode"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "promotions"), style: .plain, target: nil, action: nil)
        
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    // MARK: - Actions
    @IBAction func touchOnVisibility(_ sender: UIButton) {
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        let product = products[indexPath.row]
        cell.backgroundImageView.image = product.backgroundImage
        cell.titleLabel.text = product.title
        cell.descriptionLabel.text = product.description
        cell.contentView.layer.cornerRadius = 6
        cell.contentView.layer.masksToBounds = true
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let storyBoard = UIStoryboard.init(name: "FundsList", bundle: nil)
//        if let viewController = storyBoard.instantiateInitialViewController() {
//            self.navigationController?.pushViewController(viewController, animated: true)
//        }
    }
}
