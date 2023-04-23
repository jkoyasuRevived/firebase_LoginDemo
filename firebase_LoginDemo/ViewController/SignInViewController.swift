//
//  ViewController.swift
//  Login_MemberShip
//
//  Created by koyasu on 2023/04/15.
//

import UIKit
import Firebase
import SVProgressHUD

class SignInViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    let signInModel = SignInModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        signInModel.delegate = self
        
        setupUI()
    }

    //サインイン実行
    @IBAction func signInButtonTapped(_ sender: Any) {
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        
        SVProgressHUD.show()
        signInModel.signIn(email: email, password: password)
    }
    
    //画面部品の設定
    func setupUI(){
        self.signInButton.isEnabled = false

        self.signUpButton.layer.borderColor = UIColor.systemPurple.cgColor
        self.signUpButton.layer.borderWidth = 2
        self.signUpButton.layer.cornerRadius = 3
    }
}

extension SignInViewController: UITextFieldDelegate {
    // textFieldでテキスト選択が変更された時に呼ばれるメソッド
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // textFieldが空かどうかの判別するための変数(Bool型)で定義
        let emailIsEmpty = emailTextField.text?.isEmpty ?? true
        let passwordIsEmpty = passwordTextField.text?.isEmpty ?? true

        // 全てのtextFieldが記入済みの場合の処理
        if emailIsEmpty || passwordIsEmpty {
            signInButton.isEnabled = false
            signInButton.backgroundColor = UIColor.systemGray2
        } else {
            signInButton.isEnabled = true
            signInButton.backgroundColor = UIColor.purple
        }
    }

    //リターンキーでキーボードが閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
    
    // textField以外の部分を押したときキーボードが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SignInViewController: SignInModelDelegate {
    // ユーザー情報の登録が完了した時の処理
    func completedSignInAction(error:Error?) {
        if let error = error{
            print(error)
            SVProgressHUD.showError(withStatus: "ログインに失敗しました。")
            SVProgressHUD.dismiss(withDelay: 2)
        }else{
            print("DEBUG_PRINT: ログインに成功しました。")
            SVProgressHUD.showSuccess(withStatus: "ログインに成功しました。")
            SVProgressHUD.dismiss(withDelay: 2)
            // 会員証画面遷移
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toMemberIDVC", sender: nil)
            }
        }
    }
}
