//
//  SettingViewController.swift
//  MiniApp-FirebaseGoogleSignIn
//
//  Created by 近藤米功 on 2022/07/04.
//

import UIKit
import FirebaseAuth
import Firebase

class SettingViewController: UIViewController {

    var user: String = ""

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

    @IBAction func didTapDisplayButton(_ sender: Any) {
        Auth.auth().addStateDidChangeListener { auth, user in
            if let currentUser = auth.currentUser{
                print("currentUseruid",currentUser.uid)
            }
        }
    }



}
