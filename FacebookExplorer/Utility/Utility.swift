//
//  Utility.swift
//  FacebookExplorer
//
//  Created by Ahsan Khalil🤕 on 23/11/2020.
//

import Foundation
import UIKit

struct Utility {
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    static func downloadImage(from url: URL, completionHandler: @escaping (UIImage) -> ()) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                if let image = UIImage(data: data) {
                    completionHandler(image)
                } else {
                    completionHandler(UIImage(named: "404")!)
                }
            }
        }
    }
}
