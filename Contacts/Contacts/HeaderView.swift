//
//  TableViewHeader.swift
//  Contacts
//
//  Created by PARAIPAN SORIN on 01.08.2022.
//

import UIKit

class HeaderView: UIView {
        
    private lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Contacte"
        label.font = .boldSystemFont(ofSize: 26)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemGray6
        stackView.alignment = .bottom
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 0)
        return stackView
    }()
    
    private lazy var headerSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "CONTACTELE MELE"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(stackView)
        addSubview(headerTitleLabel)
        stackView.addArrangedSubview(headerSubtitleLabel)
    }
    
    func setup() {
        NSLayoutConstraint.activate([
            headerTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            headerTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            headerTitleLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -16),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
