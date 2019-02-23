//
//  Contact.swift
//  Favourite Contact
//
//  Created by David Ye on 23/2/19.
//  Copyright © 2019 David Ye. All rights reserved.
//

import Foundation

struct Contact: Decodable, Equatable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let gender: Gender
    var isFavourite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case gender
    }
    
    public static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.id == rhs.id
    }
    
}

enum Gender: String, Decodable {
    case male = "Male"
    case female = "Female"
    
    var imageName: String {
        switch self {
        case .male:
            return "male"
        case .female:
            return "female"
        }
    }
}

extension Collection {
    
    subscript(contact: Contact) -> Int? {
        guard let contacts = self as? [Contact] else { return nil }
        return contacts.enumerated().first { $1 == contact }?.offset
    }
    
}
