//
//  PersistanceManager.swift
//  Contacts
//
//  Created by PARAIPAN SORIN on 03.08.2022.
//

import Foundation

class PersistanceManager {
    
    static let shared = PersistanceManager()
    static let fileNameContacts = "Contacts"
    var contacts: [Contact] = []
    
    private init() {
        contacts = loadContacts()
    }
    
    func loadContacts() -> [Contact] {
        let contactsJSONURL = URL(fileURLWithPath: PersistanceManager.fileNameContacts, relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
        print("-> load " + contactsJSONURL.absoluteString)
        let decoder = JSONDecoder()
        var contacts: [Contact] = []
        do {
            let contactsData = try Data(contentsOf: contactsJSONURL)
            contacts = try decoder.decode([Contact].self, from: contactsData)
        }
        catch {}
        return contacts
    }
    
    func saveContacts(_ contacts: [Contact]) {
        let encoder = JSONEncoder()
        do {
            let contactsData = try encoder.encode(contacts)
            let contactsJSONURL = URL(fileURLWithPath: PersistanceManager.fileNameContacts, relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
            print("-> save: " + contactsJSONURL.absoluteString)
            try contactsData.write(to: contactsJSONURL, options: .atomic)
        }
        catch {}
    }
    
    func saveContact(_ contact: Contact) {
        contacts.append(contact)
        saveContacts(contacts)
        NotificationCenter.default.post(name: .addContact, object: nil, userInfo: ["item" : contact])
    }
    
    func updateContact(_ contact: Contact) {
        guard let (index, _) = contacts.enumerated().first (where: { $0.element.id == contact.id }) else { return }
        contacts.remove(at: index)
        saveContact(contact)
    }
    
    func saveToDisk(endpoint: String, contacts: [Contact]) {
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        print("-> path " + path)
        do {
            let data = try JSONEncoder().encode(contacts)
            try data.write(to: url)
        }
        catch {} 
        UserDefaults.set(cachedURL: path, for: endpoint)
    }
}
