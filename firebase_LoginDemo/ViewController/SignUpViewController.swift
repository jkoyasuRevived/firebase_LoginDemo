//
//  RegisterViewController.swift
//  Login_MemberShip
//
//  Created by koyasu on 2023/04/17.
//

import UIKit
import Firebase
import SVProgressHUD

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmedPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    let signUpModel = SignUpModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signUpButton.isEnabled = false
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmedPasswordTextField.delegate = self
        signUpModel.delegate = self
    }
    
    //登録するボタン押下時実行
    @IBAction func registerButtonTapped(_ sender: Any) {
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        let comfirmedPassword = self.confirmedPasswordTextField.text!
        
        //パスワードの入力ミス確認
        if password != comfirmedPassword{
            SVProgressHUD.showError(withStatus: "パスワードとパスワード（確認用）が一致しません。"
)
            SVProgressHUD.dismiss(withDelay: 2)
        }else{
            SVProgressHUD.show(withStatus: "通信中です")
            
            //アドレスの重複確認
            self.signUpModel.checkEmailExist(email: email){ result in
                switch result{
                case let .success(isExist):
                    if isExist{
                        SVProgressHUD.showError(withStatus: "作成済みのメールアドレスです。")
                        SVProgressHUD.dismiss(withDelay: 2)
                        return
                    }else{
                        //重複がない場合ユーザー作成
                        self.signUpModel.createNewUser(email: email, password: password)
                    }
                case let .failure(error):
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "通信に失敗しました。")
                    SVProgressHUD.dismiss(withDelay: 2)
                }
            }
        }
    }
}


extension SignUpViewController: UITextFieldDelegate {
    // textFieldでテキスト選択が変更された時に呼ばれるメソッド
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // textFieldが空かどうかの判別するための変数(Bool型)で定義
        let emailIsEmpty = emailTextField.text?.isEmpty ?? true
        let passwordIsEmpty = passwordTextField.text?.isEmpty ?? true
        let confirmedPasswordIsEmpty = confirmedPasswordTextField.text?.isEmpty ?? true

        // 全てのtextFieldが記入済みの場合の処理
        if emailIsEmpty || passwordIsEmpty || confirmedPasswordIsEmpty {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.systemGray2
        } else {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.blue
        }
    }

    // textField以外の部分を押したときキーボードが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SignUpViewController: SignUpModelDelegate {
    // ユーザー情報の登録が完了した時の処理
    func completedRegisterUserInfoAction(error:Error?) {
        if let error = error{
            SVProgressHUD.showError(withStatus: "ユーザー作成に失敗しました。")
            SVProgressHUD.dismiss(withDelay: 2)
        }else{
            print("DEBUG_PRINT: ユーザー作成に成功しました。")
            SVProgressHUD.showSuccess(withStatus: "ユーザー作成に成功しました。")
            SVProgressHUD.dismiss(withDelay: 2)
            self.dismiss(animated: true)
        }
    }

}
