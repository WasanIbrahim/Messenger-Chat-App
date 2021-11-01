//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Wa ibra. on 26/03/1443 AH.
//

import Foundation
import FirebaseDatabase
import Firebase

// singleton creation below
// final - cannot be subclassed
final class DatabaseManger {
    
    static let shared = DatabaseManger()
    
    // reference the database below
    
    private let database = Database.database().reference()
    
    
    
    //func to create new user from registerVC
    public func creatingNewUserInDB(firstName: String, lastName: String, email: String) {
        
        database.child("User").setValue(["firstName":firstName,"lastName":lastName, "email": email])
    }
    
    
}

// MARK: - account management
extension DatabaseManger {
    
    // have a completion handler because the function to get data out of the database is asynchrounous so we need a completion block
    
    
    public func userExists(with email:String, completion: @escaping ((Bool) -> Void)) {
        // will return true if the user email does not exist
        // firebase allows you to observe value changes on any entry in your NoSQL database by specifying the child you want to observe for, and what type of observation you want
        // let's observe a single event (query the database once)
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value) { snapshot in
            // snapshot has a value property that can be optional if it doesn't exist
            
            guard snapshot.value as? String != nil else {
                // otherwise... let's create the account
                completion(false)
                return
            }
            
            // if we are able to do this, that means the email exists already!
            
            completion(true) // the caller knows the email exists already
        }
    }
    
    // Insert new user to database
    public func insertUser(with user: ChatAppUser){
        let userDic = ["first_name":user.firstName,"last_name":user.lastName, "email":user.email]
        database.child(user.safeEmail).setValue(userDic){ error, _ in
            self.userExists(with: user.email,completion: { isInserted in
                if isInserted == true {
                    print("is Working")
                }
                else{
                    print("userExist not wotking")
                }
            })
        }
    }
}



struct ChatAppUser {
    let firstName: String
    let lastName: String
    let email: String
    //let profilePictureUrl: String
    
    // create a computed property safe email
    
    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
