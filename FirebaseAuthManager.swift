//
//  FirebaseAuthManager.swift
//  SignIn
//
//  Created by Bernardina Maldonado on 11/6/20.
//

import UIKit
import FirebaseAuth

class FirebaseAuthManager: UIViewController
{
    //create a new user
    func createUser(email: String, firstName: String, lastNAme: String, password: String, completionblock: @escaping (_ success: Bool) -> Void)
    {
        Auth.auth().createUser(withEmail: email, password: password)
        { (authResult, error) in
            if let user = authResult?.user
            {
                print(user)
                completionblock(true)
            }
            else
            {
                completionblock(false)
            }
        }
    }
    //user signin
    func signIn(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void)
    {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code)
            {
                completionBlock(false)
            }
            else
            {
                completionBlock(true)
            }
            }
    }

   // override func viewDidLoad() {
       // super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    
}
