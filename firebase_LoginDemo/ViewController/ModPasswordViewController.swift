//
//  modPassword.swift
//  Login_MemberShip
//
//  Created by koyasu on 2023/04/15.
//

import UIKit
import SVProgressHUD

class ModPasswordViewController: UIViewController {
    

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var sendEmailButton: UIButton!
    let modPasswordModel = ModPasswordModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        modPasswordModel.delegate = self

        // Do any additional setup after loading the view.
    }
    
    //メール送信ボタン押下時実行
    @IBAction func forwardButtonTapped(_ sender: Any) {
        self.modPasswordModel.modPassword(email: emailTextField.text!)
    }
}

extension ModPasswordViewController:ModPasswordModellDelegate{
    func completedModPasswordAction(error: Error?) {
        if let error = error{
            SVProgressHUD.showError(withStatus: "メール送信に失敗しました。")
        }else{
            SVProgressHUD.showSuccess(withStatus: "メールを送信しました。")
            self.dismiss(animated: true)
        }
    }
    
    
}

extension ModPasswordViewController: UITextFieldDelegate {
    // textFieldでテキスト選択が変更された時に呼ばれるメソッド
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // textFieldが空かどうかの判別するための変数(Bool型)で定義
        let emailIsEmpty = emailTextField.text?.isEmpty ?? true

        // 全てのtextFieldが記入済みの場合の処理
        if emailIsEmpty {
            sendEmailButton.isEnabled = false
            sendEmailButton.backgroundColor = UIColor.systemGray2
        } else {
            sendEmailButton.isEnabled = true
            sendEmailButton.backgroundColor = UIColor.blue
        }
    }

    // textField以外の部分を押したときキーボードが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
