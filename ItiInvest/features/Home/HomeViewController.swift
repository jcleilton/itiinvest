//
//  HomeViewController.swift
//  ItiInvest
//
//  Created by Matheus Cardoso Kuhn on 05/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

private enum Layout {
    enum Size {
        static let icon = CGSize(width: 80, height: 80)
        static let lineHeight: CGFloat = 1
        static let arrow = CGSize(width: 20, height: 25)
        static let visibilityButton = CGSize(width: 35, height: 35)
        static let arrowUp = CGSize(width: 40, height: 40)
        static let collectionMultiplier: CGFloat = 0.3
    }
}

final class HomeViewController: UIViewController {
    // MARK: - IBOutlets
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ITIColor.darkBackground
        return view
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ITIColor.extraDarkBackground
        return view
    }()
    
    private let balanceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ITIColor.darkBackground
        return view
    }()
    
    private let profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let seeProfileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    
    private let balanceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "perfil.png"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let arrowProfileImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let balanceArrowImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let arrowUpImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "arrow_up"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .white
        label.text = "Eric"
        return label
    }()
    
    private let myProfileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
                label.textColor = .white
        label.text = "ver meu perfil"
        return label
    }()
    
    private let balanceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.text = "saldo iti"
        return label
    }()
    
    private let balanceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .white
        label.text = "R$0,00"
        return label
    }()
    
    private let knowMoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.text = "tudo sobre seu iti"
        return label
    }()
    
    private let balanceVisibilityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = ITIColor.darkBackground
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
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
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - CodeView
extension HomeViewController: CodeView {
    func setupComponents() {
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
    
    func setupConstraints() {
        let topFlexibleConstraint = headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: Constant.Margin.verticalLarge)
        topFlexibleConstraint.priority = .defaultHigh
        topFlexibleConstraint.isActive = true
        headerView.topAnchor.constraint(greaterThanOrEqualTo: view.compatibleLayoutGuide.topAnchor, constant: Constant.Margin.verticalSmall).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Margin.horizontalNormal).isActive = true
        headerView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -Constant.Margin.horizontalLarge).isActive = true
        
        iconImageView.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: profileStackView.leadingAnchor, constant: -Constant.Margin.horizontalNormal).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: Layout.Size.icon.width).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Layout.Size.icon.height).isActive = true
        
        profileStackView.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        profileStackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        profileStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        
        arrowProfileImageView.heightAnchor.constraint(equalToConstant: Layout.Size.arrow.height).isActive = true
        arrowProfileImageView.widthAnchor.constraint(equalToConstant: Layout.Size.arrow.width).isActive = true
        
        lineView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constant.Margin.verticalNormal).isActive = true
        lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Margin.horizontalNormal).isActive = true
        lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Margin.horizontalNormal).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: Layout.Size.lineHeight).isActive = true
        
        balanceStackView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: Constant.Margin.verticalNormal).isActive = true
        balanceStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Margin.horizontalNormal).isActive = true
        balanceStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.Margin.horizontalNormal).isActive = true
        
        balanceValueLabel.topAnchor.constraint(equalTo: balanceView.topAnchor).isActive = true
        balanceValueLabel.bottomAnchor.constraint(equalTo: balanceView.bottomAnchor).isActive = true
        balanceValueLabel.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor).isActive = true
        balanceValueLabel.trailingAnchor.constraint(equalTo: balanceVisibilityButton.leadingAnchor, constant: -Constant.Margin.horizontalNormal).isActive = true
        
        balanceVisibilityButton.centerYAnchor.constraint(equalTo: balanceValueLabel.centerYAnchor).isActive = true
        balanceVisibilityButton.trailingAnchor.constraint(lessThanOrEqualTo: balanceArrowImageView.leadingAnchor, constant: -Constant.Margin.horizontalNormal).isActive = true
        balanceVisibilityButton.heightAnchor.constraint(equalToConstant: Layout.Size.visibilityButton.height).isActive = true
        balanceVisibilityButton.widthAnchor.constraint(equalToConstant: Layout.Size.visibilityButton.width).isActive = true
        
        balanceArrowImageView.centerYAnchor.constraint(equalTo: balanceValueLabel.centerYAnchor).isActive = true
        balanceArrowImageView.trailingAnchor.constraint(equalTo: balanceView.trailingAnchor).isActive = true
        balanceArrowImageView.heightAnchor.constraint(equalToConstant: Layout.Size.arrow.height).isActive = true
        balanceArrowImageView.widthAnchor.constraint(equalToConstant: Layout.Size.arrow.width).isActive = true
        
        productCollectionView.topAnchor.constraint(greaterThanOrEqualTo: balanceStackView.bottomAnchor, constant: Constant.Margin.verticalSmall).isActive = true
        productCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        productCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        productCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Layout.Size.collectionMultiplier).isActive = true
        
        arrowUpImageView.topAnchor.constraint(equalTo: productCollectionView.bottomAnchor, constant: Constant.Margin.verticalLarge).isActive = true
        arrowUpImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        arrowUpImageView.heightAnchor.constraint(equalToConstant: Layout.Size.arrowUp.height).isActive = true
        arrowUpImageView.widthAnchor.constraint(equalToConstant: Layout.Size.arrowUp.width).isActive = true
        
        knowMoreLabel.topAnchor.constraint(equalTo: arrowUpImageView.bottomAnchor, constant: 4).isActive = true
        knowMoreLabel.bottomAnchor.constraint(equalTo: view.compatibleLayoutGuide.bottomAnchor, constant: -Constant.Margin.verticalSmall).isActive = true
        knowMoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupExtraConfigurations() {
        view.backgroundColor = ITIColor.darkBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "qrcode"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "promotions"), style: .plain, target: nil, action: nil)
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Product.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundImageView.image = viewModel.productBackgroundImage(at: indexPath)
        cell.titleLabel.text = viewModel.productDescription(at: indexPath)
        cell.descriptionLabel.text = viewModel.productDescription(at: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
