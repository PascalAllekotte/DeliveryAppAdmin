//
//  ALGProducts.swift
//  FoodDeliveryAdmin
//
//  Created by Pascal Allekotte on 24.08.24.
//

import SwiftUI

struct ALGProducts: View {
    
    // MARK: Variables -
    
    @State var productViewModel = ProductViewModel()
    
    @State private var newProduct = ProductModel(
        id: UUID().uuidString,
        imageURL: "",
        ml: "",
        price: "",
        productName: "",
        discount: false,
        discountDetail: "",
        pfand: false,
        quantity: "",
        hTags: [],
        category: nil,
        description: "",
        isFavorite: false
    )
    
    let categories = ["Lamm", "Rind", "drinks", "Getraenke", "Gewürze"]
    @State private var newTag = ""
    
    
    
    
    var body: some View {
        NavigationStack{
            
            ScrollView{
                // ------------------- DESCRIPTION AND PRODUCTNAME -------------------
                VStack{
                    
                    HStack{
                        Text("Add new Product")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(6)
                            .padding(.top, -20)
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Produktname")
                            .font(.headline)
                        TextField("ProductName", text: $newProduct.productName)
                            .textFieldStyle()
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Description")
                            .font(.headline)
                        TextField("Product Description", text: $newProduct.description)
                            .textFieldStyle()
                    }
                    .padding(.horizontal)
                    
                    // ------------------- PRICE AND CATEGORY -------------------
                    
                    HStack(spacing: 10){
                        VStack(alignment: .leading, spacing: 5){
                            Text("Price")
                                .font(.headline)
                            TextField("Insert Price", text: $newProduct.price)
                                .textFieldStyle()
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text("Category")
                                .font(.headline)
                            
                            Picker("Choose Category", selection: Binding(
                                get: { newProduct.category ?? categories.first! },
                                set: { newProduct.category = $0 }
                            )) {
                                ForEach(categories, id: \.self){ category in
                                    Text(category).tag(category as String?)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .frame(height: 50)
                            .padding(.horizontal, 10)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("MagicBlue"), lineWidth: 0.5)
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    
                    // ------------------- OPTIONS -------------------
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Options")
                            .font(.headline)
                        TextField("Quantity / Description", text: $newProduct.quantity)
                            .textFieldStyle()
                        
                        Toggle("Favorite", isOn: $newProduct.isFavorite)
                            .padding(.horizontal, 10)
                            .frame(height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("MagicBlue"), lineWidth: 0.5)
                            )
                        Toggle("Discount", isOn: $newProduct.discount)
                            .padding(.horizontal, 10)
                            .frame(height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("MagicBlue"), lineWidth: 0.5)
                            )
                        if newProduct.discount {
                            TextField("Discount Details", text: $newProduct.discountDetail)
                                .textFieldStyle()
                        }
                        
                        
                        // ------------------- TAGS -------------------
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Tags")
                                .font(.headline)
                            HStack{
                                TextField("New Tag", text: $newTag)
                                    .textFieldStyle()
                                    .frame(height: 45)
                                
                                Button(action: {
                                    if !newTag.isEmpty {
                                        newProduct.hTags?.append(newTag)
                                        newTag = ""
                                    }
                                }) {
                                    Text("Add")
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
                            
                            if let hTags = newProduct.hTags, !hTags.isEmpty {
                                VStack(alignment: .leading, spacing: 5){
                                    ForEach(hTags, id: \.self) { tag in
                                        HStack {
                                            Text(tag)
                                            Spacer()
                                            Button(action: {
                                                if let index = newProduct.hTags?.firstIndex(of: tag) {
                                                    newProduct.hTags?.remove(at: index)
                                                }
                                            }) { Image(systemName: "trash")
                                                    .foregroundStyle(.black)
                                            }
                                            
                                        }
                                    }
                                }
                                .padding()
                                .background(Color("MagicBlue").opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            
                            Button(action: {
                                
                                
                                
                            }) {
                                Text("Add product")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 10)
                                    .bold()
                                    .background(Color("MagicBlue"))
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 1)
                                
                            }
                            
                            
                            
                            
                        }
                    }
                    .padding(.horizontal)
                    
                    
                    
                    
                }
                Spacer()
                
            }
        }
    }
}

#Preview {
    ALGProducts()
}
