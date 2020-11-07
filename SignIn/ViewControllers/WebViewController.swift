//
//  WebViewController.swift
//  SignIn
//
//  Created by Bernardina Maldonado on 10/15/20.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    
    var url = URL(string: "")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlRequest = URLRequest(url: url!)
        webView.loadRequest(urlRequest)
        
    }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            //Dispose of any resources that can be recreated
            
        }


        // Do any additional setup after loading the view.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
