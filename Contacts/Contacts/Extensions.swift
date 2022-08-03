//
//  Extensions.swift
//  Contacts
//
//  Created by PARAIPAN SORIN on 03.08.2022.
//

import Foundation

extension FileManager {
  static var documentsDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}

extension UserDefaults {
    static func set(cachedURL: String, for endpoint: String) {
        var dict = UserDefaults.standard.object(forKey: "Cache") as? [String:String]
        if dict == nil {
            dict = [String:String]()
        }
        dict?[endpoint] = cachedURL
        UserDefaults.standard.set(dict, forKey: "Cache")
    }
    
    static func cachedURL(for endpoint: String) -> String? {
        let dict = UserDefaults.standard.object(forKey: "Cache") as? [String:String]
        let path = dict?[endpoint]
        return path
    }
}

extension Notification.Name {
    static let addContact = Notification.Name("AddContact")
}
