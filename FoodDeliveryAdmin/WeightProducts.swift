//
//  WeightProducts.swift
//  FoodDeliveryAdmin
//
//  Created by Pascal Allekotte on 24.08.24.
//

import SwiftUI

struct WeightProducts: View {
    
    @StateObject private var viewModel = ProductViewModel()
    @State private var newProduct = ProductMeatModel(
        id: UUID().uuidString,
        description: "",
        imageURL: "",
        price: "",
        productName: "",
        vauswahl1: "",
        vauswahl2: "",
        discount: false,
        discountDetail: "",
        isFavorite: false,
        category: nil,
        hTags: []
    )
    
    @State private var newTag: String = ""
    
    let categories = ["Alkoholfrei", "Getraenke", "Lamm", "PascalTestet", "Rind", "drinks", "products", "users"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    // Header
                    HStack {
                        Text("Neues Produkt hinzufügen")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(6)
                            .padding(.top, -20)
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    
                    // Produktname und Beschreibung
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Produktname")
                            .font(.headline)
                        TextField("Produktname eingeben", text: $newProduct.productName)
                            .textFieldStyle()

                        Text("Beschreibung")
                            .font(.headline)
                        TextField("Beschreibung eingeben", text: $newProduct.description)
                            .textFieldStyle()
                    }
                    .padding(.horizontal)
                    
                    // Preis und Kategorienauswahl
                    HStack(spacing: 10) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Preis")
                                .font(.headline)
                            TextField("Preis eingeben", text: $newProduct.price)
                                .textFieldStyle()
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Kategorie")
                                .font(.headline)
                               

                            Picker("Kategorie auswählen", selection: Binding(
                                get: { newProduct.category ?? categories.first! },
                                set: { newProduct.category = $0 }
                            )) {
                                ForEach(categories, id: \.self) { category in
                                    Text(category).tag(category as String?)
                                        .foregroundStyle(.black)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .frame(height: 50)
                         
                            .padding(.horizontal, 10)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("MagicBlue"), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    // Auswahlfelder und Rabattoptionen
                    VStack(alignment: .leading, spacing: 7) {
                        Text("Optionen")
                            .font(.headline)
                            
                        TextField("Auswahl 1", text: $newProduct.vauswahl1)
                            .textFieldStyle()

                        TextField("Auswahl 2", text: $newProduct.vauswahl2)
                            .textFieldStyle()
                        
                        Toggle("Rabatt", isOn: $newProduct.discount)
                            .padding(.horizontal, 10)
                            .frame(height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("MagicBlue"), lineWidth: 0.5)
                            )
                        
                        if newProduct.discount {
                            TextField("Rabatt-Details", text: $newProduct.discountDetail)
                                .textFieldStyle()
                        }
                        
                        Toggle("Favorit", isOn: $newProduct.isFavorite)
                            .padding(.horizontal, 10)
                            .frame(height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("MagicBlue"), lineWidth: 0.5)
                            )
                    }
                    .padding(.horizontal)
                    
                    // Tags hinzufügen
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Tags")
                            .font(.headline)
                            
                        
                        HStack {
                            TextField("Neuer Tag", text: $newTag)
                                .textFieldStyle()
                                .frame(height: 45)

                            Button(action: {
                                if !newTag.isEmpty {
                                    newProduct.hTags?.append(newTag)
                                    newTag = ""
                                }
                            }) {
                                Text("Hinzufügen")
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 10)
                                    .bold()
                                    .background(Color("MagicBlue"))
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 1)

                            }
                            .disabled(newTag.isEmpty)
                        }
                        
                        // Anzeige der hinzugefügten Tags
                        if let hTags = newProduct.hTags, !hTags.isEmpty {
                            VStack(alignment: .leading, spacing: 5) {
                                ForEach(hTags, id: \.self) { tag in
                                    HStack {
                                        Text(tag)
                                        Spacer()
                                        Button(action: {
                                            if let index = newProduct.hTags?.firstIndex(of: tag) {
                                                newProduct.hTags?.remove(at: index)
                                            }
                                        }) {
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundStyle(.red)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color("MagicBlue").opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding(.horizontal)
                    
                    // Produkt hinzufügen Button
                    Button(action: {
                        if let category = newProduct.category, !category.isEmpty {
                            viewModel.addProduct(newProduct)
                        } else {
                            print("Kategorie ist nicht ausgewählt oder leer")
                        }
                    }) {
                        Text("Produkt hinzufügen")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15) 
                            .background(Color("MagicBlue"))
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding(.horizontal)
                            .shadow(radius: 1)

                    }
                    
                    Spacer()
                }
                .padding(.vertical)
            }
        }
    }
}


#Preview {
    WeightProducts()
        .environmentObject(AuthViewModel())
}
