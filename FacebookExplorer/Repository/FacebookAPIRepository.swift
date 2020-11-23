//
//  FacebookAPIRepository.swift
//  FacebookExplorer
//
//  Created by Ahsan Khalil🤕 on 20/11/2020.
//

import Foundation
import FBSDKCoreKit

extension Decodable {
  init(from: Any) throws {
    let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
    let decoder = JSONDecoder()
    self = try decoder.decode(Self.self, from: data)
  }
}

class FacebookAPIRepository {
    enum FbApiParameters: String {
        case birthday = "birthday"
        case name = "name"
        case picture = "picture"
        case email = "email"
        case gender = "gender"
    }
    
    typealias userHandler = (User?) -> Void
    typealias pictureHandler = (Picture?) -> Void
    static func getPictureData(completionHandler: @escaping pictureHandler) {
        let parameters = ["fields": "picture.type(large)"]
        let request = GraphRequest(
            graphPath: "/me",
            parameters: parameters)
        request.start(completionHandler: { connection, result, error in
            do {
                if let data = result as? [String:Any] {
                    print(data)
                    let picture = try PictureObject(from: result as Any)
                    completionHandler(picture.picture)
                    print("fetched from API")
                } else {
                    print(error as Any)
                    completionHandler(nil)
                }
            } catch {
                completionHandler(nil)
            }
        })
    }
//
    static func fetchFacebookAttributes(completionHandler: @escaping userHandler) {
        let parameters = ["fields": "name, birthday, gender, email"]
        let request = GraphRequest(
            graphPath: "/me",
            parameters: parameters)
        request.start(completionHandler: { connection, result, error in
            do {
                if let data = result as? [String:Any] {
                    print(data)
                    let user = try User(from: result as Any)
                    completionHandler(user)
                    print("fetched from API")
                } else {
                    print(error)
                    completionHandler(nil)
                }
            } catch {
                completionHandler(nil)
            }
        })
    }
}
