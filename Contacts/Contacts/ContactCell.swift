//
//  ContactCell.swift
//  Contacts
//
//  Created by PARAIPAN SORIN on 30.07.2022.
//

import UIKit

class ContactCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: ContactCell.self)
    static let rowHeight: CGFloat = 100
        
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = self.frame.height / 2
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(stackView)
        stackView.addArrangedSubview(contactImageView)
        stackView.addArrangedSubview(nameLabel)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            contactImageView.widthAnchor.constraint(equalToConstant: 44),
            contactImageView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

extension ContactCell {
    func configure(contact: Contact, image: UIImage) {
        nameLabel.text = contact.name
        contactImageView.image = image
    }
}
