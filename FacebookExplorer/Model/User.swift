//
//  User.swift
//  FacebookExplorer
//
//  Created by Ahsan Khalil🤕 on 20/11/2020.
//

import Foundation
struct User : Codable {
    let name : String
    let birthday : String
    let gender: String
    let email: String
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? "Can't Fetch"
        birthday = try values.decodeIfPresent(String.self, forKey: .birthday) ?? "Can't Fetch"
        gender = try values.decodeIfPresent(String.self, forKey: .gender) ?? "Can't Fetch"
        email = try values.decodeIfPresent(String.self, forKey: .email) ?? "Can't Fetch"
    }
}
