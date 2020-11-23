//
//  ViewController.swift
//  FacebookExplorer
//
//  Created by Ahsan Khalil🤕 on 18/11/2020.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController {
    let loginButton = FBLoginButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.center = view.center
        view.addSubview(loginButton)
        loginButton.permissions = ["public_profile", "email","user_photos", "user_age_range", "user_birthday", "user_friends", "user_gender", "user_hometown", "user_likes", "user_link", "user_location", "user_photos", "user_posts", "user_videos"]
        loginButton.delegate = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let token = AccessToken.current,
                !token.isExpired {
            print(token.userID)
            fetchProfile()
        } else {
            print("\ni am here\n")
        }
    }
    func fetchProfile() {
        print("fetch profile is called")
        let vc = storyboard?.instantiateViewController(identifier: ProfileViewController.identifier) as! ProfileViewController
        present(vc, animated: true )
    }

    
}
extension ViewController: LoginButtonDelegate {
    func loginButton(
        _ loginButton: FBLoginButton,
        didCompleteWith potentialResult: LoginManagerLoginResult?,
        error potentialError: Error?
    ) {
        if let error = potentialError {
            print("error occured \(error)")
            return
        }

        guard let result = potentialResult else {
            print("error occured in sign in")
            return
        }
        
        guard !result.isCancelled else {
            print("canceled")
            return
        }

        fetchProfile()
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("you are now out")
    }
    
    
    
}

