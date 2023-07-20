//
//  UIView+NoData.swift
//
//  Created by Ademola Fadumo on 18/07/2023.
//

import Foundation
import UIKit

extension UIView {
    func setEmptyView(title: String, message: String) {
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        messageLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        messageLabel.textColor = .lightGray
        messageLabel.font = .systemFont(ofSize: 17)
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        
        let stackView = UIStackView()
        
        stackView.axis  = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 12.0
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
}
