//
//  FWEmptyStateView.swift
//  FindWine
//
//  Created by Маргарита Ставнийчук on 02.09.2022.
//

import UIKit

class FWEmptyStateView: UIView {

    let messageLabel = UILabel()
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureMessageLabel()
        configureLogoImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)
    }
    
    private func configureMessageLabel() {
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        messageLabel.textColor = .secondaryLabel
        messageLabel.adjustsFontSizeToFitWidth = true
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureLogoImageView() {
        logoImageView.image = Images.placeholderImage
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            logoImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -48)
        ])
        
    }
}
