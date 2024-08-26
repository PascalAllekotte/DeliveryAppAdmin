//
//  FoodDeliveryAdminApp.swift
//  FoodDeliveryAdmin
//
//  Created by Pascal Allekotte on 24.08.24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct FoodDeliveryAdminApp: App {
    
    // MARK: FIREBASE Init -
    @StateObject private var authViewModel = AuthViewModel()
    
  
    
    init(){
           FirebaseConfiguration.shared.setLoggerLevel(.min)
           FirebaseApp.configure()
           
           // Verwende die Farbe "MagicBlue" aus den Assets
           if let magicBlue = UIColor(named: "MagicBlue") {
               let appearance = UITabBarAppearance()
               appearance.configureWithDefaultBackground()
               
               // Setze die Hintergrundfarbe der Tab-Bar
               appearance.backgroundColor = UIColor.lightGray.withAlphaComponent(0.05)
               
               // Setze die Schattenfarbe oberhalb der Tab-Bar
               appearance.shadowColor = magicBlue
               
               // Weise das neue Erscheinungsbild der Tab-Bar zu
               UITabBar.appearance().standardAppearance = appearance
               
               // Optional: Setze auch das kompakte Erscheinungsbild, falls benötigt
               UITabBar.appearance().scrollEdgeAppearance = appearance
           } else {
               print("Fehler: MagicBlue Farbe nicht gefunden")
           }
       }
       
    var body: some Scene {
        WindowGroup {
            if !authViewModel.isUserLoggedIn {
                LoginView()
            } else {
                ContentView()
            }
        }
                .environmentObject(authViewModel)
        }
    }

