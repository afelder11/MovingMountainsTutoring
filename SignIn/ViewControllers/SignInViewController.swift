//
//  SignInViewController.swift
//  SignIn
//
//  Created by Bernardina Maldonado on 10/23/20.
//

import UIKit

class SignInViewController: UIViewController
{

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signInButton(_ sender: Any)
    {
        print("Sign in button pressed")
        
        //read values from text fields
        let userName = userNameTF.text
        let password = passwordTF.text
        
        if (userName?.isEmpty)! || (password?.isEmpty)!
        {
        
            print("User name \(String(describing: userName)) or password \(String(describing: password)) is empty")
            
            displayMessage(userMessage: "One of the required fields is missing")
            return
        }
        
        //activity indicator - optional
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        myActivityIndicator.center = view.center
        
        myActivityIndicator.hidesWhenStopped = false
        
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        //send http request to perform sign in
        let myUrl = URL(string: "hhtp://localhost:8080/api/authentication")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"//compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = ["userName": userName!, "password": password!, ] as [String: String]
        
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
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json
                {
                    let accessToken = parseJSON["token"] as? String
                    let userId = parseJSON["id"] as? String
                    print("Access token: \(String(describing: accessToken!))")
                
                if (accessToken?.isEmpty)!
                {
                    self.displayMessage(userMessage: "Could not successfully perform this prequest. Please try again later.")
                    return
                }
                
                DispatchQueue.main.async
                {
                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    let appDelegate = UIApplication.shared.delegate
                    appDelegate?.window??.rootViewController = homePage
                }
                }
                else
                {
                    //display alert
                    self.displayMessage(userMessage: "Could not successfully perform this prequest. Please try again later.")
                }
            } catch{
            
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                
                self.displayMessage(userMessage: "Could not successfully perform this prequest. Please try again later.")
                print(error)
            }
            
            
        }
        
        task.resume()
        
        
    }
    @IBAction func signUpButton(_ sender: Any)
    {
        print("Sign up button pressed")
        
        let signUpViewController = self.storyboard?.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        
        self.present(signUpViewController, animated: true)
        
    }
    
    @IBAction func scanQRbutton(_ sender: Any)
    {
        print("Scan QR button pressed")
        
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
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
        {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }

}
