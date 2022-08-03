//
//  ContactsViewController+Networking.swift
//  Contacts
//
//  Created by PARAIPAN SORIN on 30.07.2022.
//

import Foundation
import UIKit

enum Status: String, Decodable {
    case active
    case inactive
}

enum NError: String, Error {
    case invalidURL = "The URL is invalid. Please try again"
    case invalidData = "Invalid data. Please try again"
    case serverError = "Ensure you are connected to the internet. Please try again"
    case decodingError = "We could not process your request. Please try again"
}

struct Contact: Codable, Hashable, Identifiable {
    private let identifier: UUID = UUID()
    
    let id: Int
    let name: String
    let email: String
    let gender: String
    let status: String
    let phone: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case gender
        case status
        case phone
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    public static func == (left: Contact, right: Contact) -> Bool {
        left.identifier == right.identifier
    }

}

extension ContactsViewController {
    
    func fetchContacts(completion: @escaping (Result<[Contact], NError>) -> Void) {
        let endpoint = "https://gorest.co.in/public/v2/users"
        if let path = UserDefaults.cachedURL(for: endpoint),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let contacts = try? JSONDecoder().decode([Contact].self, from: data) {
            completion(.success(contacts))
            return
        }
                
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            let decoder = JSONDecoder()
            do {
                var response = try decoder.decode([Contact].self, from: data)
                response = response.filter { $0.status == Status.active.rawValue }
                PersistanceManager.shared.saveToDisk(endpoint: endpoint, contacts: response)
                completion(.success(response))
            }
            catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(completion: @escaping (Result<UIImage, NError>) -> Void) {
        let endpoint = "https://picsum.photos/200/200"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        guard let imageData = try? Data(contentsOf: url) else {
            completion(.failure(.invalidData))
            return
        }
        guard let avatarImage = UIImage(data: imageData) else {
            completion(.failure(.decodingError))
            return
        }
        completion(.success(avatarImage))
    }
}
