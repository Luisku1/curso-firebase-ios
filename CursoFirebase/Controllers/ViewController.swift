//
//  ViewController.swift
//  CursoFirebase
//
//  Created by UNAM FCA 18 on 16/06/22.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "user") != nil
        {
            performSegue(withIdentifier: "login", sender: nil)
        }
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        
        if let email = txtEmail.text, let password = txtPassword.text
        {
            if !(email.isEmpty || password.isEmpty)
            {
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    
                    if let result = result, error == nil
                    {
                        let uid = result.user.uid
                        
                        UserDefaults.standard.setValue(uid, forKey: "user")
                        
                        self.performSegue(withIdentifier: "login", sender: nil)
                    
                    } else {
                        
                        print("DEBUG: - Signing in \(error!.localizedDescription)")
                    }
                }
            
            } else {
                
                print("DEBUG: - Signing In a field is empty")
            }
        }
    }
    
    @IBAction func unwindToLogin(_ sender : UIStoryboardSegue)
    {
        txtEmail.text = ""
        txtPassword.text = ""
    }
}

