//
//  ProductViewModel.swift
//  FoodDeliveryAdmin
//
//  Created by Pascal Allekotte on 24.08.24.
//


import Foundation
import FirebaseFirestore

class ProductViewModel: ObservableObject {
    // MARK: - Variables -
    
    @Published var productss: [ProductModel] = []
    @Published var meatProducts: [ProductMeatModel] = []
    
    let kategorien = ["Lamm", "Rind", "Alkoholfrei", "Gewürze", "Geflügel", "Grillen", "Alkoholisch"]
    
    private let firebaseFireStore = Firestore.firestore()
   // private let storage = Storage.storage()
    
    // MARK: - FUNCTIONS -
    
    func getNormalProducts(for kategorie: String) -> [ProductModel] {
        return productss.filter { $0.category == kategorie }
    }
    
    func getMeatProducts(for kategorie: String) -> [ProductMeatModel] {
        return meatProducts.filter { $0.category == kategorie }
    }
    
    func fetchAllProducts() {
        // Leere die Arrays bevor neue Produkte geladen werden
        productss.removeAll()
        meatProducts.removeAll()
        
        for kategorie in kategorien {
            fetchMeatProducts(kategorie: kategorie)
            fetchProducts(kategorie: kategorie)
        }
    }
    
    func fetchProducts(kategorie: String) {
        firebaseFireStore.collection(kategorie).getDocuments { snapshot, error in
            if let error = error {
                print("Error while loading products from category \(kategorie): \(error)")
                return
            }
            guard let documents = snapshot?.documents else {
                print("No documents found for category \(kategorie)")
                return
            }
            
            let fetchedProducts = documents.compactMap { document -> ProductModel? in
                do {
                    return try document.data(as: ProductModel.self)
                } catch {
                    print("Error decoding product: \(error.localizedDescription)")
                    return nil
                }
            }
            
            DispatchQueue.main.async {
                self.productss.append(contentsOf: fetchedProducts)
            }
        }
    }
    
    func fetchMeatProducts(kategorie: String) {
        firebaseFireStore.collection(kategorie).getDocuments { snapshot, error in
            if let error = error {
                print("Error while loading meat products from category \(kategorie): \(error)")
                return
            }
            guard let documents = snapshot?.documents else {
                print("No documents found for meat category \(kategorie)")
                return
            }
            
            let fetchedMeatProducts = documents.compactMap { document -> ProductMeatModel? in
                do {
                    return try document.data(as: ProductMeatModel.self)
                } catch {
                    print("Error decoding meat product: \(error.localizedDescription)")
                    return nil
                }
            }
            
            DispatchQueue.main.async {
                self.meatProducts.append(contentsOf: fetchedMeatProducts)
            }
        }
    }
    
    
    
    // Hinzufügen
    
    func addProduct(_ product: ProductMeatModel) {
        guard let category = product.category, !category.isEmpty else {
            print("Kategorie ist nicht angegeben oder leer")
            return
        }
        
        guard !product.productName.isEmpty else {
            print("Produktname ist nicht angegeben oder leer")
            return
        }
        
        let documentID = product.productName.replacingOccurrences(of: " ", with: "_")
        
        do {
            try firebaseFireStore.collection(category).document(documentID).setData(from: product)
            print("Produkt erfolgreich hinzugefügt")
        } catch {
            print("Fehler beim Hinzufügen des Produkts: \(error)")
        }
    }
    
    func addNormalProduct(_ product: ProductModel) {
        guard let category = product.category, !category.isEmpty else {
            print("Kategorie ist nicht angegeben oder leer")
            return
        }
        
        guard !product.productName.isEmpty else {
            print("Produktname ist nicht angegeben oder leer")
            return
        }
        
        let documentID = product.productName.replacingOccurrences(of: " ", with: "_")
        
        do {
            try firebaseFireStore.collection(category).document(documentID).setData(from: product)
            print("Produkt erfolgreich hinzugefügt")
        } catch {
            print("Fehler beim Hinzufügen des Produkts: \(error)")
        }
    }
    
    
}
