//
//  Data.swift
//  FirebaseTest
//
//  Created by Jacky Gao on 10/26/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct User {
    var name: String
    var photo: String
    var recipes: [String]
}

class UserViewModel: ObservableObject {
    @Published var user: User?
    
    private var db = Firestore.firestore()
    
    func fetchUserData() {
        let userDocument = db.collection("users").document("1")
        
        userDocument.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let name = data?["name"] as? String ?? ""
                let photo = data?["photo"] as? String ?? ""
                let recipes : [String] = data?["recipes"] as? [String] ?? []
                
                print("The name is " + name)
                print("The photo is " + photo)
                print("The number of recipes are " + String(recipes.count))
                
                self.user = User(name: name, photo: photo, recipes: recipes)
            } else {
                print("Document does not exist")
            }
        }
    }
}
