//
//  ContentView.swift
//  FoodDeliveryAdmin
//
//  Created by Pascal Allekotte on 24.08.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "network")
                    Text("Home")
                        .foregroundStyle(.red)
                }
            
            
            DatabaseView()
                .tabItem {
                    Image(systemName: "book.pages")
                    Text("Database")
                }
            
            AnalyticView()
                .tabItem {
                    Image(systemName: "bonjour")
                    Text("Analytics")
                }
        }
        .tint(Color("MagicBlue"))
        .frame(maxWidth: .infinity)
        .background(.blue)
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
//book.pages
