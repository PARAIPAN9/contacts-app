//
//  DetailView.swift
//  Contacts
//
//  Created by PARAIPAN SORIN on 02.08.2022.
//

import UIKit

class DetailView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.axis = .vertical
        stackview.alignment = .leading
        stackview.distribution = .fillEqually
        stackview.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        return stackview
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .systemGray2
        return label
    }()
    
    
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "_ _ _"
        textField.delegate = self
        return textField
    }()
        
    init(frame: CGRect, text: String) {
        super.init(frame: frame)
        setup()
        layout()
        self.textLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(text: String) {
        textField.text = text
    }
    
    private func setup() {
        layer.cornerRadius = 10
        backgroundColor = .white
        addSubview(stackView)
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(textField)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 80),
            widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension UITextField {

    func setUnderLine() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width - 10, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

}

// MARK: - UITextFieldDelegate
extension DetailView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
       true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
