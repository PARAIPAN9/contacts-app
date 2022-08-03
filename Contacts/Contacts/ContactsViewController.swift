//
//  ViewController.swift
//  Contacts
//
//  Created by PARAIPAN SORIN on 29.07.2022.
//

import UIKit

class ContactsViewController: UIViewController {

    enum Section: CaseIterable {
        case main
    }
    
    var contacts: [Contact] = []
    var image: UIImage?
    let group = DispatchGroup()
    let headerView = HeaderView(frame: .zero)
    let tableView = UITableView()
    var dataSource: UITableViewDiffableDataSource<Section, Contact>!
    
    lazy var errorAlert: UIAlertController = {
        let alert =  UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }()
    
    lazy var addNewContactBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), landscapeImagePhone: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapAddNewContact))
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contacts = PersistanceManager.shared.loadContacts()
        print("contacts: \(contacts.count)")
        setupNavigationBar()
        setupHeaderView()
        setupTableView()
        configureDataSource()
        fetchContacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(didAddContact), name: .addContact, object: nil)
    }
    
    func setupTableView() {
        tableView.delegate = self
        
        tableView.rowHeight = ContactCell.rowHeight
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseIdentifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupHeaderView() {
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        tableView.tableHeaderView = headerView
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = addNewContactBarButtonItem
    }
    
}

// MARK: - Networking
extension ContactsViewController {
    
    private func fetchContacts() {
        group.enter()
        fetchContacts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let contacts):
                    self.contacts.append(contentsOf: contacts)
                    self.updateDataSource(nil)
                case .failure(let error):
                    self.displayError(error)
                }
            }
            self.group.leave()
        }
    }
    
    private func fetchImage() {
        group.enter()
        fetchImage { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.image = image
                case .failure(let error):
                    self.displayError(error)
                }
            }
            self.group.leave()
        }
    }
    
    private func displayError(_ error: NError) {
        let titleAndMessage = titleAndMessage(for: error)
        showErrorAlert(title: titleAndMessage.0, message: titleAndMessage.1)
    }
    
    private func titleAndMessage(for error: NError) -> (String, String) {
        let title: String
        switch error {
        case .serverError:
            title = "Server Error"
        case .decodingError:
            title = "Network Error"
        case .invalidURL:
            title = "Invalid URL"
        case .invalidData:
            title = "Invalid Data"
        }
        return (title, error.rawValue)
    }
    
    private func showErrorAlert(title: String, message: String) {
        errorAlert.title = title
        errorAlert.message = message
        present(errorAlert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDiffableDataSource
extension ContactsViewController {
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, contact in
            self.fetchImage()
            let contactCell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseIdentifier, for: indexPath) as! ContactCell
            contactCell.accessoryType = .disclosureIndicator
            self.group.notify(queue: .main) {
                if contact.id % 2 == 0 { self.image = UIImage(systemName: "heart.fill") }
                contactCell.configure(contact: contact, image: self.image ?? UIImage())
            }
            return contactCell
        }
    }
    
    private func updateDataSource(_ contact: Contact?) {
        var newSnapshot = NSDiffableDataSourceSnapshot<Section, Contact>()
        newSnapshot.appendSections([.main])
        newSnapshot.appendItems(contacts, toSection: .main)
        if let contact = contact {
            newSnapshot.reloadItems([contact])
        }
        dataSource.apply(newSnapshot, animatingDifferences: true)
    }
}

// MARK: - Delegates
extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let contact = dataSource.itemIdentifier(for: indexPath) else { return }
        
        let addNewContactViewController = AddNewContactViewController()
        addNewContactViewController.contact = contact
        addNewContactViewController.headerTitle = .modify
        addNewContactViewController.buttonTitle = "Modifica"
        
        navigationController?.pushViewController(addNewContactViewController, animated: true)
    }
}

// MARK: - Actions
extension ContactsViewController {
    @objc func didTapAddNewContact() {
        let addNewContactViewController = AddNewContactViewController()
        navigationController?.pushViewController(addNewContactViewController, animated: true)
    }
}

// MARK: - Notifications
extension ContactsViewController {
    @objc func didAddContact(notification: Notification) {
        let data = notification.userInfo as? [String: Contact]
        guard let contact = data?["item"] else { return }
        contacts.append(contact)
        updateDataSource(nil)
    }
}





