//
//  SignInViewController.swift
//  SignIn
//
//  Created by Bernardina Maldonado on 10/23/20.
//

import UIKit
import SwiftUI

class SignInViewController: UIViewController
{

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

       //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
       //tap.cancelsTouchesInView = false

       view.addGestureRecognizer(tap)
   }

   //Calls this function when the tap is recognized.
    @IBAction func dismissKeyboard()
    {
       //Causes the view (or one of its embedded text fields) to resign the first responder status.
       view.endEditing(true)
    }
    

    @IBAction func signInButton(_ sender: Any)
    {
        //signin button selected
        let loginManager = FirebaseAuthManager()
        guard let email = userNameTF.text, let password = passwordTF.text else { return }
            
        loginManager.signIn(email: email, password: password) {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success)
                {
                    message = "User was sucessfully logged in."
                }
                else
                {
                    message = "There was an error."
                }
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.display(alertController: alertController)
            }

    }

    @IBAction func signUpButton(_ sender: Any)
    {
        let signUpViewController = self.storyboard?.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        
        self.present(signUpViewController, animated: true)
    }
    
    @IBAction func scanQRbutton(_ sender: Any)
    {
        let QRViewController = self.storyboard?.instantiateViewController(identifier: "QRViewController") as! QRViewController
        
        self.present(QRViewController, animated: true)
    }
    
    func display(alertController: UIAlertController)
    {
        self.present(alertController, animated: true, completion: nil)
    }
    
}
