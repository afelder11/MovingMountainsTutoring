//
//  SignUpViewController.swift
//  SignIn
//
//  Created by Bernardina Maldonado on 10/23/20.
//

import UIKit


class SignUpViewController: UIViewController
{

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var fNameTF: UITextField!
    @IBOutlet weak var lNameTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var pwTF2: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //Looks for single or multiple taps.
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
    
    @IBAction func signUpButton(_ sender: Any)
    {
       let signUpManager = FirebaseAuthManager()
        
        if let email = emailTF.text, let password = pwTF.text
        {
                signUpManager.createUser(email: email, password: password) {[weak self] (success) in
                    guard let `self` = self else { return }
                    var message: String = ""
                    
                    if (success)
                    {
                        message = "User was sucessfully created. Please proceed to Sign In"
                    }
                    else if ((password.elementsEqual(self.pwTF2.text!)) != true)
                    {
                        message = "Passwords do not match"
                    }
                    else
                    {
                        message = "There was an error"
                    }
                    
                    let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.display(alertController: alertController)
                }
        }
    }
    @IBAction func signInButton(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func display(alertController: UIAlertController)
    {
        self.present(alertController, animated: true, completion: nil)
                 
    }
}
