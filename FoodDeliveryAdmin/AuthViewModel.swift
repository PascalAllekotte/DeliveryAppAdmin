//
//  AuthViewModel.swift
//  FoodDeliveryAdmin
//
//  Created by Pascal Allekotte on 24.08.24.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore

class AuthViewModel : ObservableObject {
    
    // MARK: Variables -
    @Published private(set) var user: FireUser?
    
    
    
    private var firebaseAuthentification = Auth.auth()
    private var firebaseFirestore = Firestore.firestore()
    
    var isUserLoggedIn: Bool {
        user.self != nil
    }
    
    init(){
        if let currentUser = self.firebaseAuthentification.currentUser {
            self.fetchFirestoreUser(withId: currentUser.uid)
        }
    }
    
    
    // MARK: Functions -
    
    
    
    func fetchFirestoreUser(withId id: String){
        self.firebaseFirestore.collection("users").document(id).getDocument { document, error in
            if let error {
                print("Error fetching user: \(error)")
                return
            }
            
            guard let document else {
                print("Document does not exist")
                return
            }
            
            do {
                let user = try document.data(as: FireUser.self)
                self.user = user
            } catch {
                print("Could not decode user: \(error)")
            }
        }
    }
    
    
    
    
    func login(email: String, password: String){
        firebaseAuthentification.signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                print("Error with login: \(error)")
                return
            }
            
            guard let authResult, let userEmail = authResult.user.email else {
                print("authResult or Email are empty")
                return
            }
            
            print("Succesfully signed in with user ID \(authResult.user.uid) and email \(email)")
            
            self.fetchFirestoreUser(withId: authResult.user.uid)
            
        }
    }
    
    
    func logOut(){
        do {
            try firebaseAuthentification.signOut()
            print("Succesfully signed out")
            self.user = nil
            
        } catch {
            print("Error with log out: \(error)")
        }
    }
    
}
