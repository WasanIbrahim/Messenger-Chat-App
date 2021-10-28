//
//  ViewController.swift
//  Messenger
//
//  Created by Wa ibra. on 21/03/1443 AH.
//

import UIKit

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
    }
    
    @IBAction func loginFacebookPressed(_ sender: Any) {
    }
    
    @IBAction func registerPressed(_ sender: Any)  {
        //go to register view controller
        let registerVC = storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as? RegistrationViewController
        self.navigationController?.pushViewController(registerVC!, animated: true)
        
    }
    
}

