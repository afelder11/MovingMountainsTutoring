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
    
    func createUser(email: String,password: String, completionblock: @escaping (_ success: Bool) -> Void)
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

   // override func viewDidLoad() {
       // super.viewDidLoad()

        // Do any additional setup after loading the view.
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
