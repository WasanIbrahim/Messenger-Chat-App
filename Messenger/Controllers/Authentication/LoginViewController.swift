//
//  ViewController.swift
//  Messenger
//
//  Created by Wa ibra. on 21/03/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
import JGProgressHUD

class LoginViewController: UIViewController {
    
    //private var spinner = JGProgressHUD(style: .dark)
    
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
        
        //check not empty
        //spinner.show(in: view)
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            
            guard let result = authResult, error == nil else {
                //fail to login
                print("Failed to log in user ")
                return
            }
            
            // success login , go to conversations VC
            
            let user = result.user
            print(user.email)
            
            guard let email = user.email else{
                return
            }
            
            UserDefaults.standard.set(email, forKey: "email")
            //UserDefaults.standard.set("\(firstname)", forKey: "name")
            
            print("logged in user: \(user)")
            
            
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)

        })
    }
    
    
    
    
}


