//
//  memberIDViewController.swift
//  Login_MemberShip
//
//  Created by koyasu on 2023/04/17.
//

import UIKit
import Firebase
import CoreImage
import SVProgressHUD

class memberIDViewController: UIViewController {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var barcodeImageView: UIImageView!
    var uid:String?
    var email:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uid = Auth.auth().currentUser?.uid
        self.email = Auth.auth().currentUser?.email
        
        self.idLabel.text = self.uid
        self.emailLabel.text = self.email
        
        //バーコードの生成
        self.barcodeImageView.image = self.generateCode128Barcode(string: uid!)
        // Do any additional setup after loading the view.
    }
    
    //バーコードの生成
    func generateCode128Barcode(string: String) -> UIImage? {
        guard let data = string.data(using: .utf8) else {
            return nil
        }
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(data, forKey: "inputMessage")
        guard let output = filter.outputImage else {
            return nil
        }
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(output, from: output.extent) else {
            return nil
        }
        let image = UIImage(cgImage: cgImage, scale: 2.0, orientation: UIImage.Orientation.up)
        return image
    }

    //ログアウトボタン押下時実行
    @IBAction func signOutButtonTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toSignInVC", sender: nil)
            }
        catch let error as NSError {
            SVProgressHUD.showError(withStatus: "ログアウトに失敗しました。")
        }
    }
}
