//
//  ContactPlaceholderView.swift
//  Contacts
//
//  Created by PARAIPAN SORIN on 01.08.2022.
//

import UIKit

class ContactPlaceholderView: UIImageView {
    
    private lazy var initialsLabel: UILabel = {
        let label = UILabel()
//        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(initials: String) {
        initialsLabel.text = initials
    }
    
    private func setup() {
        addSubview(initialsLabel)
        backgroundColor = .systemGray3
        layer.cornerRadius = self.frame.height / 2
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 45),
            heightAnchor.constraint(equalToConstant: 45),
        
            initialsLabel.topAnchor.constraint(equalTo: topAnchor),
            initialsLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            initialsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            initialsLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
