//
//  ViewController.swift
//  MiniApp-FirebaseGoogleSignIn
//
//  Created by 近藤米功 on 2022/07/03.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapSignInButton(_ sender: Any) {
        auth()
    }

    private func login(credential: AuthCredential){
        print("ログイン完了")
    }

    private func auth(){
        // clientIDの取得
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // GIDの設定
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.signIn(with: config, presenting: self){ [unowned self] user, error in
            if let error = error {
                print("GIDSignInError: \(error.localizedDescription)")
                return
            }

            guard let authentication = user?.authentication,let idToken = authentication.idToken else {
                return
            }
            // 引数のuserの情報を使用して、GoogleAuthProviderのcredential(認証情報)を生成し、それを引数にFirebaseAuthのsignInを実行
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error{
                    let authError = error as NSError
                    print("ログインエラー")
                    return
                }
                print("Googleアカウントでサインインしました")
            }
            self.login(credential: credential)
        }
    }



}

