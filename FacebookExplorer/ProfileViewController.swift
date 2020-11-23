//
//  ProfileViewController.swift
//  FacebookExplorer
//
//  Created by Ahsan Khalil🤕 on 20/11/2020.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ProfileViewController: UIViewController {
    static let identifier = "ProfileViewController"
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelGender: UILabel!
    @IBOutlet weak var labelDateOfBirth: UILabel!
    @IBOutlet weak var imgProfilePic: ExtendedUIImageView!
    @IBOutlet var btnLogout: UIButton!
    @IBOutlet weak var indicatorImage: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFBData()
    }
    private func loadFBData() {
        updateData()
        updateProfile()
    }
    private func updateData() {
        let handler: FacebookAPIRepository.userHandler = { user in
            self.labelEmail.text = user?.email
            self.labelName.text = user?.name
            self.labelGender.text = user?.gender
            self.labelDateOfBirth.text = user?.birthday
        }
        FacebookAPIRepository.fetchFacebookAttributes(completionHandler: handler)
    }
    private func updateProfile() {
        let pictureHandler: FacebookAPIRepository.pictureHandler = { picture in
            if let picture = picture {
                let handler: (UIImage) -> Void = { image in
                    self.imgProfilePic.image = image
                    self.indicatorImage.stopAnimating()
                }
                Utility.downloadImage(from: URL(string: picture.data.url)!, completionHandler: handler)
            } else {
                self.imgProfilePic.image = UIImage(named: "404")
                self.indicatorImage.stopAnimating()
            }
        }
        FacebookAPIRepository.getPictureData(completionHandler: pictureHandler)
    }
    @IBAction func onClickLogout(_ sender: UIButton) {
        let logoutButton = LoginManager()
        logoutButton.logOut()
        dismiss(animated: true, completion: nil)
    }
}
