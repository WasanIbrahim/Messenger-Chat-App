//
//  RegistrationViewController.swift
//  Messenger
//
//  Created by Wa ibra. on 21/03/1443 AH.
//

protocol signDelegate: AnyObject {
    
    func emailField (email: String)
    func passwordField(password: String)
    
    
}

import UIKit
import Firebase


class RegistrationViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    //variables
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var registerEmailTextField: UITextField!
    @IBOutlet weak var registerPasswordTextField: UITextField!
    @IBOutlet weak var registerImageButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    weak var delegate: signDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Actions
    @IBAction func registerButtonPressed(_ sender: Any) {
        createUser()
    }
    
    //pick register image
    @IBAction func registerImagePressed(_ sender: Any) {
       let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
    
    
    //set register image 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        registerImageButton.setBackgroundImage(image, for: .normal)
        dismiss(animated: true)
        registerImageButton.layer.masksToBounds = true
        registerImageButton.layer.cornerRadius = 45
        registerImageButton.layer.cornerRadius = registerImageButton.frame.size.height/2
    }
    
    
    //register new user
    func createUser(){
        Auth.auth().createUser(withEmail: registerEmailTextField.text!, password: registerPasswordTextField.text!, completion: { authResult , error  in
            //throw error and show alert
            guard let result = authResult, error == nil else {
                self.showAlert(error: error!.localizedDescription)
                print("Error creating user")
                return
            }
            
            
            //create new user and go to sign in page
            let user = result.user
            print("Created User: \(user)")
            //store new user data in database
            DatabaseManger.shared.creatingNewUserInDB(firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, email: self.registerEmailTextField.text!)
            
            //success registration go to login VC
            if let myVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController{
                self.navigationController?.pushViewController(myVC, animated: true)
                
            }
            else{
                self.showAlert(error: "Error")
            }
            
        })
    }
    
    
    //alert for failur register
    func showAlert(error: String){
       let alertVC = UIAlertController(title: error, message: "Unable to create account", preferredStyle: UIAlertController.Style.alert)
       let action  = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
       alertVC.addAction(action)
       self.present(alertVC, animated: true, completion: nil)
    }
    
    
}

