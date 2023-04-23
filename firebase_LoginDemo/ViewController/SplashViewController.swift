//
//  SplashViewController.swift
//  Login_MemberShip
//
//  Created by koyasu on 2023/04/19.
//

import UIKit
import Firebase

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //ログイン済みの場合会員証画面へ、そうでなければサインイン画面へ
        if Auth.auth().currentUser != nil {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toMemberIDVC", sender: nil)
            }
        }else{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toSignInVC", sender: nil)
            }
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
