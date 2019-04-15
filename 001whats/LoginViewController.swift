//
//  LoginViewController.swift
//  001whats
//
//  Created by Isa Richter on 11/04/19.
//  Copyright © 2019 Philippe Richter. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var emailtextfieldr: UITextField!
    
    @IBOutlet weak var passwordtextfieldr: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Loginbuttonpressed(_ sender: Any) {
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: emailtextfieldr.text!, password: passwordtextfieldr.text!) { (user, error) in
            if error != nil{print(error!)}
            else{print("You are Logged in baby!")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "loginsegue", sender: self)
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

