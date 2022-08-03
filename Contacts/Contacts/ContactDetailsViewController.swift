//
//  ContactDetailsViewController.swift
//  Contacts
//
//  Created by PARAIPAN SORIN on 02.08.2022.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.spacing = 16
        return stackview
    }()
    
    lazy var contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    var image = UIImage()
    var name = ""
    var email = ""
    var gender = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        setData()
    }
    
    private func setData() {
        contactImageView.image = image
        nameLabel.text = name
        emailLabel.text = email
        genderLabel.text = gender
    }
    
    private func setup() {
        navigationItem.title = "Detalii Contact"
        view.addSubview(stackView)
        stackView.addArrangedSubview(contactImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(genderLabel)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contactImageView.widthAnchor.constraint(equalToConstant: 44),
            contactImageView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

