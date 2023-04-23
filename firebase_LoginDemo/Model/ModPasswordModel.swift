//
//  ModPasswordModel.swift
//  Login_MemberShip
//
//  Created by koyasu on 2023/04/20.
//
import Foundation
import Firebase

protocol ModPasswordModellDelegate:AnyObject{
    func completedModPasswordAction(error:Error?)
}

class ModPasswordModel{
    weak var delegate:ModPasswordModellDelegate?
    
    //パスワード変更処理
    func modPassword(email:String){
        Auth.auth().sendPasswordReset(withEmail: email){ error in
            self.delegate?.completedModPasswordAction(error: error)
        }
    }
}
