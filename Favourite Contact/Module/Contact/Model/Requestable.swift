//
//  Requestable.swift
//  Favourite Contact
//
//  Created by David Ye on 23/2/19.
//  Copyright © 2019 David Ye. All rights reserved.
//

import Foundation

protocol Requestable {}

extension Requestable {
    func request(_ url: URL, success: @escaping ([Contact]) -> Void, failure: @escaping (Error?) -> Void) {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = (response as? HTTPURLResponse),
                response.statusCode == 200 else {
                    failure(error)
                    return
            }
            if let data = data,
                let objects = try? JSONDecoder().decode([Contact].self, from: data)
            {
                success(objects)
            }
        }.resume()
    }
}

