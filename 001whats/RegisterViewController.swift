//
//  RegisterViewController.swift
//  001whats
//
//  Created by Isa Richter on 11/04/19.
//  Copyright © 2019 Philippe Richter. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import SVProgressHUD

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var emailtextfieldp: UITextField!
    
    @IBOutlet weak var passwordtextfieldman: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func Registerbuttonpressedman(_ sender: Any) {
        SVProgressHUD.show()
       Auth.auth().createUser(withEmail: emailtextfieldp.text!, password: passwordtextfieldman.text!) { (user, error) in
            if error != nil{
                print("error")
            }
            else {print("registration successful")
                SVProgressHUD.dismiss()
                
            self.performSegue(withIdentifier: "goToChat", sender: self)
                
        }
        }
        
        
        
        
    }
    
}
