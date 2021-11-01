//
//  ConversationViewController.swift
//  Messenger
//
//  Created by Wa ibra. on 21/03/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()

        }
    
    
    @IBAction func signoutButtonPressed(_ sender: UIButton) {
//        do {
//            try FirebaseAuth.Auth.auth().signOut()
//            //self.navigationController?.popViewController(animated: true)
//
//        }
//        catch {
//        }
    }
    
    
    
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            validateAuth()
//            let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
//                        if !isLoggedIn {
//                // present login view controller
//                }

}
    private func validateAuth(){
           // current user is set automatically when you log a user in
           if FirebaseAuth.Auth.auth().currentUser == nil {
               // present login view controller if user not logged in
               self.navigationController?.popViewController(animated: true)

           }
}
    
    
}
