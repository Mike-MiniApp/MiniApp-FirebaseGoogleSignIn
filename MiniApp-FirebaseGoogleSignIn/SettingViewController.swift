//
//  SettingViewController.swift
//  MiniApp-FirebaseGoogleSignIn
//
//  Created by 近藤米功 on 2022/07/04.
//

import UIKit
import FirebaseAuth
import Firebase
import SDWebImage

class SettingViewController: UIViewController {

    var user: String = ""
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var emailLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
    }

    @IBAction private func didTapLogoutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            logoutAlert()
        }catch let error as NSError{
            print("エラー",error)
        }
        print("ログアウトしました")
    }

    private func logoutAlert(){
        let alert = UIAlertController(title: "ログアウトしました", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",style: .default))
        present(alert, animated: true, completion: nil)
    }

    @IBAction private func didTapDisplayButton(_ sender: Any) {
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                let uid = user.uid
                let email = user.email
                let photoURL = user.photoURL
                let displayName = user.displayName
                if let email = email, let photoURL = photoURL, let displayName = displayName{
                    self.emailLabel.text = email
                    self.nameLabel.text = displayName
                    self.photoImageView.sd_setImage(with: photoURL, completed: nil)
                }
                print("uid",uid)
            }
        }
    }



}
