//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Wa ibra. on 21/03/1443 AH.
//

import UIKit
import FirebaseAuth
import SDWebImage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
//variables
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedProfilePic : UIImage!
    
   let data = ["log out"]
    override func viewDidLoad() {
        super.viewDidLoad()
//        let profileImgeSTR = UserDefaults.standard.value(forKey: "profile_picture_url") as! String
//        let uRL = URL.init(string: profileImgeSTR)
//        self.imageView.sd_setImage(with: uRL, completed: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"myCell"
        )
        tableView.delegate = self
        tableView.dataSource = self
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.size.height/2


        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        let profileImgeSTR = UserDefaults.standard.value(forKey: "profile_picture_url") as! String
        let uRL = URL.init(string: profileImgeSTR)
        self.imageView.sd_setImage(with: uRL, completed: nil)}
        
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textColor = .red
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return data.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // unhighlight the cells
        
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] _ in
            
            guard let strongSelf = self else {
                return
            }
            
            do{
                try Auth.auth().signOut()
                
                let vc = strongSelf.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                strongSelf.present(nav, animated: false)
                
            }
            catch{
                print("Failed to logout")
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
        
        
       
    }
  


}
