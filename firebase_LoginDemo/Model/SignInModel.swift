//
//  signInModel.swift
//  Login_MemberShip
//
//  Created by koyasu on 2023/04/19.
//

import Foundation
import Firebase

protocol SignInModelDelegate:AnyObject{
    func completedSignInAction(error:Error?)
}

class SignInModel{
    
    weak var delegate: SignInModelDelegate?
    
    //サインイン処理
    func signIn (email:String,password:String){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            self.delegate?.completedSignInAction(error: error)
        }
    }
}
