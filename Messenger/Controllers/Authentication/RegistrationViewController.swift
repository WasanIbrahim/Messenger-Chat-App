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
import FirebaseAuth
import JGProgressHUD

class RegistrationViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    //variables
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var registerEmailTextField: UITextField!
    @IBOutlet weak var registerPasswordTextField: UITextField!
    @IBOutlet weak var registerImageButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var selectProfilePic: UIImage!
    
    
    
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
        self.selectProfilePic = image
        registerImageButton.setBackgroundImage(image, for: .normal)
        dismiss(animated: true)
//        registerImageButton.layer.masksToBounds = true
//        registerImageButton.layer.cornerRadius = 45
//        registerImageButton.layer.cornerRadius = registerImageButton.frame.size.height/2
        
        registerImageButton.layer.cornerRadius = 6
        registerImageButton.layer.borderWidth = 2
        registerImageButton.layer.borderColor = UIColor.black.cgColor
        
        
    }
    
    
    
    
    //register new user
    func createUser(){
//check if empty throw error
        guard let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let email = registerEmailTextField.text,
            let password = registerPasswordTextField.text,
            !email.isEmpty,
            !password.isEmpty,
            !firstName.isEmpty,
            !lastName.isEmpty,
            password.count >= 6 else {
                showAlert()
                return
        }
        
        
        //spinner
        
//check if Email exist in firebase
        DatabaseManager.shared.userExists(with: email, completion: { [weak self] exists in
            guard let strongSelf = self else {
                return
            }
            
            
            //dispatch queue
            
            //if user Exist throw Error
            guard !exists else {
                // user already exists
                strongSelf.showAlert(message: "Looks like a user account for that email address already exists.")
                return
            }

             Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
                guard authResult != nil, error == nil else {
                    print("Error creating user")
                    return
                }

                UserDefaults.standard.setValue(email, forKey: "email")
                UserDefaults.standard.setValue("\(firstName) \(lastName)", forKey: "name")


                let chatUser = ChatAppUser(firstName: firstName,
                                          lastName: lastName,
                                           emailAddress: email)
                
                 
                 DatabaseManager.shared.insertUser(with: chatUser, completion: { success in
                
                    if success {
                        // upload image
                        guard let image = strongSelf.selectProfilePic, let data = image.pngData() else {
                                return
                        }
                        let filename = chatUser.profilePictureFileName
                        StorageManager.shared.uploadProfilePicture(with: data, fileName: filename, completion: { result in
                            switch result {
                            case .success(let downloadUrl):
                                UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                                print(downloadUrl)
                            case .failure(let error):
                                print("Storage maanger error: \(error)")
                            }
                        })
                    }
                })

                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            })
        })
    }
    
    
    //alert for failur register
    func showAlert(message: String = "Please enter all information to create a new account."){
        let alert = UIAlertController(title: "Woops",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Dismiss",
                                      style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
}


