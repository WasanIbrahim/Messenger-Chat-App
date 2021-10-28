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
    }
    
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
    }
    
    
}
