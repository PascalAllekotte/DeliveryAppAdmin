//
//  DatabaseView.swift
//  FoodDeliveryAdmin
//
//  Created by Pascal Allekotte on 24.08.24.
//

import SwiftUI

struct DatabaseView: View {
    @ObservedObject var productViewModel = ProductViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(productViewModel.kategorien, id: \.self) { kategorie in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(kategorie)
                                .font(.title2)
                                .bold()
                                .padding(.horizontal, 8)
                            
                            // Zuerst die normalen Produkte anzeigen
                            ForEach(productViewModel.getNormalProducts(for: kategorie)) { product in
                                productCardView(product: product)
                            }
                            .padding(.horizontal)
                            
                            // Dann die Fleischprodukte anzeigen
                            ForEach(productViewModel.getMeatProducts(for: kategorie)) { meatProduct in
                                meatProductCardView(meatProduct: meatProduct)
                            }
                            .padding(.horizontal)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            
            .onAppear {
                productViewModel.fetchAllProducts()
            }
        }
    }
    
    // View für normale Produkte
    private func productCardView(product: ProductModel) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(product.productName)
                .font(.headline)
            
            HStack {
                // Bild laden und anzeigen
                if let imageUrl = URL(string: product.imageURL) {
                    AsyncImage(
                        url: imageUrl,
                        content: { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        },
                        placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    )
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                VStack(alignment: .leading) {
                    Text("Preis: \(product.price)")
                    Text("Rabatt: \(product.discount)")
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)

        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("MagicPurple").opacity(0.2))

        .clipShape(RoundedRectangle(cornerRadius: 10))

        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("MagicBlue"), lineWidth: 0.5)
        )
        .foregroundStyle(.black)
    }
    
    // View für Fleischprodukte
    private func meatProductCardView(meatProduct: ProductMeatModel) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(meatProduct.productName)
                .font(.headline)
            
            HStack {
                // Bild laden und anzeigen
                if let imageUrl = URL(string: meatProduct.imageURL) {
                    AsyncImage(
                        url: imageUrl,
                        content: { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        },
                        placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    )
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                VStack(alignment: .leading) {
                    HStack{
                        Text("Preis:")
                            .fontWeight(.semibold)
                        Text(meatProduct.price)
                    }
                    HStack{
                        Text("Rabatt:")
                            .fontWeight(.semibold)
                        if meatProduct.discount{
                            Text("Ja")
                        } else {
                            Text("Nein")
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack{
                        
                        Text("Auswahl1:")
                            .fontWeight(.semibold)
                        if meatProduct.vauswahl1.isEmpty {
                            Text("Keine")
                        } else {
                            Text(meatProduct.vauswahl1)
                        }
                    }
                    HStack{
                        Text("Auswahl2:")
                            .fontWeight(.semibold)
                        if meatProduct.vauswahl2.isEmpty {
                            Text("Keine")
                        } else {
                            Text(meatProduct.vauswahl1)
                        }
                    }
                }
            }
            
            // hTags anzeigen
            if let hTags = meatProduct.hTags, !hTags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(hTags, id: \.self) { tag in
                            Text(tag)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.blue.opacity(0.2))
                                .clipShape(Capsule())
                        }
                    }
                }
                .padding(.top, 5)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("MagicBlue").opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("MagicBlue"), lineWidth: 0.5)
        )
    }
}

#Preview {
    DatabaseView()
}
