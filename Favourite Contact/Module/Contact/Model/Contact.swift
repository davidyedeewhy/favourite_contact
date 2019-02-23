//
//  Contact.swift
//  Favourite Contact
//
//  Created by David Ye on 23/2/19.
//  Copyright © 2019 David Ye. All rights reserved.
//

import Foundation

struct Contact: Decodable {
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
