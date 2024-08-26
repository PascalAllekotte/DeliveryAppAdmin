//
//  HomeView.swift
//  FoodDeliveryAdmin
//
//  Created by Pascal Allekotte on 24.08.24.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: VARIABLES -
    
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    Text("Wilkommen, \(authViewModel.user?.name ?? "Pascal")!")
                        .font(.title)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding()
                
                VStack(alignment: .leading){
                    HStack{
                        Text("Produkte hinzufügen:")
                            .font(.subheadline)
                        Spacer()
                    }
                    
                    NavigationLink(destination: ALGProducts()) {
                        HStack {
                            Text("Allgemeines Produkt")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .padding(10)
                    .frame(width: 250, alignment: .leading)
                    .background(Color("MagicBlue"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white)
                    .shadow(radius: 1)

                    
                    NavigationLink(destination: WeightProducts()) {
                        HStack {
                            Text("Gewichts Produkt")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .padding(10)
                    .frame(width: 250, alignment: .leading)
                    .background(Color("MagicBlue"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white)
                    .shadow(radius: 1)
                    
                    
                    Spacer()
                    
                    
                }
                .padding()
                
                HStack{
                    Spacer()
                    Button("Sign-Out"){
                        authViewModel.logOut()
                    }
                    .padding(10)
                    .background(Color("MagicBlue"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .shadow(radius: 1)

                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
