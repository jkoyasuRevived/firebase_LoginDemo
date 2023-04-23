//
//  signUpModel.swift
//  Login_MemberShip
//
//  Created by koyasu on 2023/04/19.
//

import Foundation
import Firebase

protocol SignUpModelDelegate: AnyObject {
    func completedRegisterUserInfoAction(error:Error?)
}

class SignUpModel{
    
    weak var delegate: SignUpModelDelegate?
    
    func checkEmailExist(email: String, closure: @escaping (Result<Bool, Error>) -> Void) {
      // SignInの方法を取得するメソッドを使用
        Auth.auth().fetchSignInMethods(forEmail: email, completion: { method, error in
        if let error = error {
            closure(.failure(error))
            return
        }
        // すでにメールアドレスの認証などされている場合は
        // methodの中に"EmailLink"や"Email"などの認証方法が入る
        guard let method = method, !method.isEmpty else {
          // 何もない場合は存在しない
            closure(.success(false))
            return
        }
        // methodに認証方法が入っている場合は存在する判定
        closure(.success(true))
      })
    }
    
    func createNewUser(email:String,password:String){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.delegate?.completedRegisterUserInfoAction(error: error)
            }else{
                self.delegate?.completedRegisterUserInfoAction(error: nil)
            }
        }
    }
}
