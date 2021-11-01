//
//  ViewController.swift
//  Messenger
//
//  Created by Wa ibra. on 21/03/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
//variables
    @IBOutlet weak var WelcomeBackLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginFacebookButton: UIButton!
    @IBOutlet weak var goToRegisterButton: UIButton!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var loginImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }

    
    // Actions
    @IBAction func LogInPressed(_ sender: Any) {
        loginUser()
        
        
        
    }
    
    @IBAction func loginFacebookPressed(_ sender: Any) {
    }
    
    @IBAction func registerPressed(_ sender: Any)  {
        //go to register view controller
        let registerVC = storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as? RegistrationViewController
        self.navigationController?.pushViewController(registerVC!, animated: true)
        
    }
    
    
    
    //new user logging in
    func loginUser(){
        //fail to login
        FirebaseAuth.Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { authResult, error in
        guard let result = authResult, error == nil else {
            print("Failed to log in user with email \(self.emailTextField!)")
            return
        }
            
        // success login , go to conversations VC
        let user = result.user
        print("logged in user: \(user)")
            
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ConversationViewController") 
            self.navigationController?.pushViewController(nextVC!, animated: true)
            
    })
    }
    
    
    
}

