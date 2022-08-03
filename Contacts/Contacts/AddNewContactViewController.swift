//
//  AddNewContactViewController.swift
//  Contacts
//
//  Created by PARAIPAN SORIN on 02.08.2022.
//

import UIKit

enum ContactStatus: String {
    case add = "Adauga Contact"
    case modify = "Detalii Contact"
}

class AddNewContactViewController: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.alignment = .leading
        stackview.distribution = .fillEqually
        stackview.spacing = 16
        return stackview
    }()
    
    private lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 26)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.configuration = .filled()
        button.setTitleColor(UIColor.white, for: [])
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.addTarget(self, action: #selector(didTapButton), for: .primaryActionTriggered)
        return button
    }()
    
    let nameDetailView = DetailView(frame: .zero, text: "NUME")
    let surnameDetailView = DetailView(frame: .zero, text: "PRENUME")
    let phoneDetailView = DetailView(frame: .zero, text: "TELEFON")
    let emailDetailView = DetailView(frame: .zero, text: "EMAIL")
    
    var headerTitle = ContactStatus.add
    var buttonTitle = "Salveaza"
    
    var contact: Contact?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        setData()
    }
    
    private func setData() {
        nameDetailView.set(text: contact?.name ?? "")
        emailDetailView.set(text: contact?.email ?? "")
        phoneDetailView.set(text: contact?.phone ?? "")
        headerTitleLabel.text = headerTitle.rawValue
        button.setTitle(buttonTitle, for: [])
    }
    
    private func setup() {
        view.backgroundColor = .systemGray5
        view.addSubview(stackView)
        view.addSubview(button)
        stackView.addArrangedSubview(headerTitleLabel)
        stackView.addArrangedSubview(nameDetailView)
        stackView.addArrangedSubview(surnameDetailView)
        stackView.addArrangedSubview(phoneDetailView)
        stackView.addArrangedSubview(emailDetailView)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - Actions
extension AddNewContactViewController {
    @objc func didTapButton() {
        guard nameDetailView.textField.text != "",
              surnameDetailView.textField.text != "" else { return }
        
        if phoneDetailView.textField.text != "" {
            guard phoneDetailView.textField.text!.starts(with: "07"),
                  phoneDetailView.textField.text!.count == 10 else { return }
        }
        
        switch headerTitle {
        case .add:
            let contact = Contact(id: Int.random(in: 0...10000),
                                  name: nameDetailView.textField.text!,
                                  email: emailDetailView.textField.text ?? "",
                                  gender: "",
                                  status: "",
                                  phone: phoneDetailView.textField.text ?? "")
            PersistanceManager.shared.saveContact(contact)
        case .modify:
            let contact = Contact(id: contact!.id,
                                  name: nameDetailView.textField.text!,
                                  email: emailDetailView.textField.text ?? "",
                                  gender: "",
                                  status: "",
                                  phone: phoneDetailView.textField.text ?? "")
            PersistanceManager.shared.updateContact(contact)
        }
        navigationController?.popViewController(animated: true)
    }
}
