//
//  ConversationViewController.swift
//  Messenger
//
//  Created by Wa ibra. on 21/03/1443 AH.
//

import UIKit

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
        }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
            if !isLoggedIn {
                // present login view controller
                
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: false)
            }

}
}
