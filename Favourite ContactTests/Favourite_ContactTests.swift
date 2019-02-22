//
//  Favourite_ContactTests.swift
//  Favourite ContactTests
//
//  Created by David Ye on 23/2/19.
//  Copyright © 2019 David Ye. All rights reserved.
//

import XCTest
@testable import Favourite_Contact

class Favourite_ContactTests: XCTestCase {
    
    var json: Data?

    override func setUp() {
        super.setUp()
        guard let url = Bundle(for: type(of: self)).url(forResource: "contacts", withExtension: "json"),
            let data = try? Data(contentsOf: url) else { return }
        json = data
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testContact() {
        do {
            let contacts = try JSONDecoder().decode([Contact].self, from: json!)
            XCTAssertNotNil(contacts)
        } catch {
            print(error)
            XCTFail()
        }
    }

}
