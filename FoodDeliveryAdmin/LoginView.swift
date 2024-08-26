//
//  LoginView.swift
//  FoodDeliveryAdmin
//
//  Created by Pascal Allekotte on 24.08.24.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: Variables -
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""

    
    
    
    var body: some View {
        VStack{
            HStack{
                Text("Login now!")
                    .font(.headline)
                Spacer()
            }
            .padding()
            
            // E-Mail
            TextField("E-Mail", text: $email){
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
            .padding(7)
            
            // Password
            SecureField("Password", text: $password){
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
            .padding(7)
            
    
        }
        Spacer()
        
     
        // Button for Login
        Button("Log In"){
            authViewModel.login(email: email, password: password)
        }
        .padding()
        .foregroundStyle(.black)
        .frame(maxWidth: .infinity)
        .background(.blue.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
        
        
       
        
     
        
       
        
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
