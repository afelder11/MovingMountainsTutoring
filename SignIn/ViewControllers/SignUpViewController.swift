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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButton(_ sender: Any)
    {
        print("Cancel button pressed")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInButton(_ sender: Any)
    {
        print("Sign In button pressed")
    }
    
    @IBAction func signUpButton(_ sender: Any)
    {
        print("Sign Up button pressed")
        
        //validate required fields are not empty
        if(emailTF.text?.isEmpty)! ||
            (fNameTF.text?.isEmpty)! ||
            (lNameTF.text?.isEmpty)! ||
            (pwTF.text?.isEmpty)!
        {
            //display alert message and return
            displayMessage(userMessage: "All fields are required")
            return
        }
        
        //validate password
        if((pwTF.text?.elementsEqual(pwTF2.text!))! != true)
        {
            //display alert message and return
            displayMessage(userMessage: "Passwords do not match")
            return
        }
        
        //activity indicator - optional
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        myActivityIndicator.center = view.center
        
        myActivityIndicator.hidesWhenStopped = false
        
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        //send hhtp request to register user
        let myUrl = URL(string: "http://localhost:8080/api/users")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"//compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = ["firstName": fNameTF.text!, "lastName": lNameTF.text!, "userName": emailTF.text!, "userPassword": pwTF.text!, ] as [String: String]
        
        do
        {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        }  catch let error
        {
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong. Try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request)
        {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
            if error != nil
            {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print("error=\(String(describing: error))")
                return
            }
            
            //convert response to NSDictionary object
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json
                {
                    let userId = parseJSON["userId"] as? String
                    print("User id: \(String(describing: userId!))")
                    
                    if (userId?.isEmpty)!
                    {
                        //display alert
                        self.displayMessage(userMessage: "Could not successfully perform this prequest. Please try again later.")
                        return
                    }
                    else
                    {
                        self.displayMessage(userMessage: "Sign up successful. Please proceed to Sign In")
                    }
                }
                else
                {
                    //display alert
                    self.displayMessage(userMessage: "Could not successfully perform this prequest. Please try again later.")
                }
            }catch{
                
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                
                self.displayMessage(userMessage: "Could not successfully perform this prequest. Please try again later.")
                print(error)
            }
        }
        task.resume()
    }
    
    
        func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
        {
            DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
        
    
    
    func displayMessage(userMessage: String) -> Void
    {
        DispatchQueue.main.async
        {
            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default)
            {
                (action:UIAlertAction!) in
                //when OK tapped
                print("OK button tapped")
                DispatchQueue.main.async
                {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
