//
//  FundsListView.swift
//  ItiInvest
//
//  Created by Islas Girão Garcia on 12/09/20.
//  Copyright © 2020 DevBoostItau. All rights reserved.
//

import UIKit

typealias TableViewVC = UITableViewDelegate & UITableViewDelegate

class FundsListView: UIView {
    
    
    // MARK: - Properties
    let contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let patrimonyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "meu patrimônio"
        label.font = UIFont(name: "Helvetica Neue Bold", size:  16.0)
        label.textColor = UIColor(hex: "f6b592")
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ 0.00"
        label.font = UIFont(name: "Helvetica Neue Medium", size:  33.0)
        label.textColor = .white
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    init(){
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

extension FundsListView: CodeView{
    func setupComponents() {
        addSubview(contentView)
    }
    
    func setupConstraints() {
        
    }
    
    func setupExtraConfigurations() {
        //TODO: Colocar .applyGradient na contentView
    }
    
    
}


/**
 

 protocol WelcomeViewDelegate: AnyObject {
     func loginButtonTapped(withPhone: String)
     func signUpButtonTapped()
     func facebookButtonTapped()
     func googleButtonTapped()
 }

 enum CodeViewState {
     case start, animating, finish
 }


 class WelcomeView: UIView, CodeView {
     // MARK: - Properties
     weak var delegate: WelcomeViewDelegate?
     var state: CodeViewState = .start
     
     let contentView: UIView = {
         let contentView = UIView(frame: .zero)
         contentView.translatesAutoresizingMaskIntoConstraints = false
         return contentView
     }()
     
     let scrollView: UIScrollView = {
         let scrollView = UIScrollView(frame: .zero)
         scrollView.translatesAutoresizingMaskIntoConstraints = false
         scrollView.keyboardDismissMode = .interactive
         return scrollView
     }()
     
     @ViewCodeComponent
     var mainImage: UIImageView = {
         let imageView = UIImageView(image: #imageLiteral(resourceName: "home"))
         imageView.contentMode = .scaleAspectFit
         imageView.clipsToBounds = true
 //        imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
     
     let titleLabel: UILabel = {
         let label = UILabel(frame: .zero)
         label.text = Localization.welcomeText
         label.textAlignment = .center
         label.font = .title
         label.textColor = .title
         label.accessibilityIdentifier = "welcome-title-label"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     let bodyLabel: UILabel = {
         let label = UILabel(frame: .zero)
         label.text = Localization.mainText
         label.textAlignment = .center
         label.font = .body
         label.textColor = .body
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     let phoneTextField: UITextField = {
         let textField = UITextField(frame: .zero)
         textField.placeholder = Localization.phoneText
         textField.borderStyle = .roundedRect
         textField.keyboardType = .phonePad
         textField.textAlignment = .center
         textField.translatesAutoresizingMaskIntoConstraints = false
         return textField
     }()
     
     let buttonsStackView: UIStackView = {
         let stackView = UIStackView(frame: .zero)
         stackView.axis = .horizontal
         stackView.distribution = .fillEqually
         stackView.alignment = .center
         stackView.spacing = Margin.horizontalSmall
         stackView.translatesAutoresizingMaskIntoConstraints = false
         return stackView
     }()
     
     let loginButton = WelcomeButton(style: .main, title: Localization.loginButtonText)
     let signUpButton = WelcomeButton(style: .secondary, title: Localization.signUpButtonText)
     
     let socialStackView: UIStackView = {
         let stackView = UIStackView()
         stackView.axis = .horizontal
         stackView.distribution = .fillEqually
         stackView.alignment = .center
         stackView.spacing = Margin.horizontalSmall
         stackView.translatesAutoresizingMaskIntoConstraints = false
         
         return stackView
     }()
     
     let facebookButton: UIButton = {
         let button = UIButton(frame: .zero)
         button.setBackgroundImage(#imageLiteral(resourceName: "facebook"), for: .normal)
         button.clipsToBounds = true
         button.layer.cornerRadius = 20
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
     
     let googleButton: UIButton = {
         let button = UIButton(frame: .zero)
         button.setBackgroundImage(#imageLiteral(resourceName: "google"), for: .normal)
         button.clipsToBounds = true
         button.layer.cornerRadius = 20
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
     
     let footerLabel: UILabel = {
         let label = UILabel()
         label.text = Localization.socialMediaText
         label.textAlignment = .center
         label.font = .body
         label.textColor = .body
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     // MARK: - Constraints
     var imageHeightConstraint: NSLayoutConstraint?
     
     // MARK: - Inits
     init(delegate: WelcomeViewDelegate) {
         self.delegate = delegate
         super.init(frame: .zero)
         setup()
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
     }
     
     
     // MARK: - Methods
     func setupComponents() {
         addSubview(scrollView)
         scrollView.addSubview(contentView)
         contentView.addSubview(mainImage)
         contentView.addSubview(titleLabel)
         contentView.addSubview(bodyLabel)
         contentView.addSubview(phoneTextField)
         contentView.addSubview(buttonsStackView)
         buttonsStackView.addArrangedSubview(loginButton)
         buttonsStackView.addArrangedSubview(signUpButton)
         contentView.addSubview(socialStackView)
         socialStackView.addArrangedSubview(facebookButton)
         socialStackView.addArrangedSubview(googleButton)
         contentView.addSubview(footerLabel)
     }
     
     func setupConstraints() {
         //NSLayoutContraint
         /*
          let scrollViewTop = NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 20)
          NSLayoutConstraint.activate([scrollViewTop])
          */
         
         //VFL (Visual Format Language)
         /*
          let views = ["scrollView": scrollView, "view": self, "safe": safeAreaLayoutGuide]
          let scrollViewHorizontalVFL = "H:|-24-[scrollView]-|"
          let scrollVerticalVFL = "V:[safe]-20-[scrollView(400)]"
          let horizontalContraints = NSLayoutConstraint.constraints(withVisualFormat: scrollViewHorizontalVFL, options: [], metrics: nil, views: views)
          addConstraints(horizontalContraints)
          */
         
         //Layout Anchors
         //ScrollView
         scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
         scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
         scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
         scrollView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
         
         //Content View
         contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
         contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
         contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
         contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
         let contentViewHeightContraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
         contentViewHeightContraint.priority = .defaultLow
         contentViewHeightContraint.isActive = true
         
         //Imagem
         mainImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margin.verticalVeryLarge).isActive = true
         mainImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.horizontal).isActive = true
         mainImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margin.horizontal).isActive = true
         imageHeightConstraint = mainImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.0)
         imageHeightConstraint?.isActive = true
         
         //TitleLabel
         titleLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: Margin.verticalVeryLarge).isActive = true
         titleLabel.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor).isActive = true
         titleLabel.trailingAnchor.constraint(equalTo: mainImage.trailingAnchor).isActive = true
         
         //BodyLabel
         bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.verticalSmall).isActive = true
         bodyLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
         bodyLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
         
         //TextField
         phoneTextField.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: Margin.verticalLarge).isActive = true
         phoneTextField.leadingAnchor.constraint(equalTo: bodyLabel.leadingAnchor).isActive = true
         phoneTextField.trailingAnchor.constraint(equalTo: bodyLabel.trailingAnchor).isActive = true
         
         //ButtonStackView
         buttonsStackView.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: Margin.verticalNormal).isActive = true
         buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
         
         //Login/Signup Buttons
         loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
         loginButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
         signUpButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor, multiplier: 1.0).isActive = true
         
         //Social Stackview
         socialStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Margin.verticalNormal).isActive = true
         socialStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
         
         //Social Buttons
         facebookButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
         facebookButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
         googleButton.heightAnchor.constraint(equalTo: facebookButton.heightAnchor, multiplier: 1.0).isActive = true
         
         //Footer Label
         footerLabel.bottomAnchor.constraint(equalTo: socialStackView.topAnchor, constant: -Margin.verticalNormal).isActive = true
         footerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
     }
     
     func setupExtraConfigurations() {
         backgroundColor = .view
         loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
         signUpButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
         facebookButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
         googleButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
     }
     
     @objc
     private func buttonTapped(sender: UIButton) {
         switch sender {
         case loginButton:
             delegate?.loginButtonTapped(withPhone: phoneTextField.text!)
         case signUpButton:
             delegate?.signUpButtonTapped()
         case facebookButton:
             delegate?.facebookButtonTapped()
         case googleButton:
             delegate?.googleButtonTapped()
         default:
             break
         }
     }
     
     func animate() {
         if state == .start {
             state = .animating
             imageHeightConstraint?.isActive = false
             imageHeightConstraint = mainImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
             imageHeightConstraint?.isActive = true
             UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                 //self.mainImage.transform = .init(rotationAngle: .pi)
                 self.layoutIfNeeded()
             }) { (success) in
                 print("Animação concluída?", success)
                 self.state = .finish
             }
         }
     }
 }
 
 
 
 
 */
