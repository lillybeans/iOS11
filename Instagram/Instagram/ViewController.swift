//
//  ViewController.swift
//  Instagram
//
//  Created by Lilly Tong on 2017-10-16.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit
import Parse //needed, allows you to write to AWS

class ViewController: UIViewController {
    
    var signUpModeActive = true

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!

    @IBOutlet var switchLoginModeButton: UIButton!
    @IBOutlet var signUpOrLoginButton: UIButton!
    
    @IBOutlet var switchLoginMode: UIButton!
    
    //for alert
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title:title, message:message, preferredStyle:UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func switchLoginMode(_ sender: Any) {
        
        if signUpModeActive {
            signUpModeActive = false
            signUpOrLoginButton.setTitle("Log In", for: [])
            switchLoginModeButton.setTitle("Sign Up",for:[])
        } else {
            signUpModeActive = true
            signUpOrLoginButton.setTitle("Sign Up", for: [])
            switchLoginModeButton.setTitle("Log In", for: [])
        }

    }

    @IBAction func signUpOrLogin(_ sender: Any) {
        
        if email.text == "" || password.text == "" {
            displayAlert(title:"Error in form",message:"Please enter an email and password")
            
        } else {
            
            /** spinner beginns : part 1 **/
            let activityIndicator = UIActivityIndicatorView(frame:CGRect(x: 0, y: 0, width: 50, height: 50)) //CoreGraphics frame size
            activityIndicator.center = self.view.center //set position to center of the screen
            activityIndicator.hidesWhenStopped = true;
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating() //so it starts spinning around
            
            UIApplication.shared.beginIgnoringInteractionEvents() //stop the user from being able to do anything else
            /** spinner ends: part 1 **/
            
            if (signUpModeActive){ //if signup
                var user = PFUser()
                
                user.username = email.text
                user.password = password.text
                user.email = email.text
                
                user.signUpInBackground(block: { (success, error) in //inside closure
                    
                    /** spinner begins: part 2 **/
                    
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    /** spinner ends: part 2 **/
                    
                    if let error = error {
                        self.displayAlert(title: "Could not sign you up", message: error.localizedDescription)
                    } else {
                        print("Signed up")
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }
                })
                
            } else { //if login
                PFUser.logInWithUsername(inBackground: email.text!, password: password.text!, block: {(user,error) in
                    if user != nil {
                        print("login successful!")
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    } else {
                        var errorText = "Unknown error: Please try again"
                        if let error = error {
                            errorText = error.localizedDescription
                        }
                        self.displayAlert(title: "Could not sign you up", message: errorText)
                    }
                })
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil { //if user is logged in, automatically go to table view
            self.performSegue(withIdentifier: "showUserTable", sender: self)
        }
        self.navigationController?.navigationBar.isHidden = true //hide toolbar at the top
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

