//
//  ProductViewModel.swift
//  FoodDeliveryAdmin
//
//  Created by Pascal Allekotte on 24.08.24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

// TODO: NAME ÄNDERN
class ProductViewModel : ObservableObject {
    
    // MARK: - Variables -
    
    @Published var productss: [ProductModel] = []
    @Published var meatProducts: [ProductMeatModel] = []
    @Published var discountedProducts: [ProductMeatModel] = []
    @Published var favoriteProducts: [ProductMeatModel] = []
    @Published var foundProductNames: [String] = [] // Speichert die Namen der gefundenen Produkte
    @Published var foundProducts: [ProductMeatModel] = [] // Speichert die gefundenen Produkte



    private let firebaseFireStore = Firestore.firestore()
    private let storage = Storage.storage()
    
    var sortedMeatProducts: [ProductMeatModel] {
        meatProducts.sorted { $0.isFavorite && !$1.isFavorite }
    }
    
    // MARK: - FUNCTIONS -
    
    
    // Hier werden alle Produkte (mit und ohne Gewicht) kombiniert zurückgegeben
    var allProducts: [Any] {
        return meatProducts + productss
    }

    func fetchAllProducts(kategorie: String) {
        fetchMeatProducts(kategorie: kategorie)
        fetchProducts(kategorie: kategorie)
    }

    
    func fetchProducts(kategorie: String) {
        self.firebaseFireStore.collection(kategorie).getDocuments { snapshot, error in
            if let error = error {
                print("Error while loading products from category: \(error)")
                return
            }
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            self.productss = documents.compactMap { document -> ProductModel? in
                do {
                    return try document.data(as: ProductModel.self)

                } catch {
                    print("Error decoding product: \(error.localizedDescription)")
                    return nil
                }
                
            }
            
        }
    }
    
    func fetchMeatProducts(kategorie: String) {
        self.firebaseFireStore.collection(kategorie).getDocuments { snapshot, error in
            if let error = error {
                print("Error while loading products from category: \(error)")
                return
            }
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            self.meatProducts = documents.compactMap { document -> ProductMeatModel? in
                do {
                    return try document.data(as: ProductMeatModel.self)
                } catch {
                    print("Error decoding product: \(error.localizedDescription)")
                    return nil
                }
            }
        }
    }
    
    func fetchDiscountedProducts() {
        let categories = ["Rind", "zubehoer", "getraenke"]
        self.discountedProducts = []
        
        let dispatchGroup = DispatchGroup()
        
        for category in categories {
            dispatchGroup.enter()
            self.firebaseFireStore.collection(category).getDocuments { snapshot, error in
                if let error = error {
                    print("Error while loading products from category: \(error)")
                    dispatchGroup.leave()
                    return
                }
                guard let documents = snapshot?.documents else {
                    print("No documents found")
                    dispatchGroup.leave()
                    return
                }
                
                let discounted = documents.compactMap { document -> ProductMeatModel? in
                    do {
                        let product = try document.data(as: ProductMeatModel.self)
                        return product.discount ? product : nil
                    } catch {
                        print("Error decoding product: \(error.localizedDescription)")
                        return nil
                    }
                }
                
                self.discountedProducts.append(contentsOf: discounted)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Fetched all discounted products")
        }
    }
    
    func fetchFavoriteProducts(favoriteIds: [String]) {
        guard !favoriteIds.isEmpty else {
            self.favoriteProducts = []
            return
        }
        
        var fetchedProducts: [ProductMeatModel] = []
        let categories = ["Rind", "Lamm", "PascalTestet"]

        for id in favoriteIds {
            var found = false
            for category in categories {
                let docRef = firebaseFireStore.collection(category).document(id)
                docRef.getDocument { document, error in
                    if let error = error {
                        print("Error fetching product \(id) from category \(category): \(error)")
                        return
                    }
                    
                    guard let document = document, document.exists else {
                        print("No data for product \(id) in category \(category)")
                        return
                    }
                    
                    do {
                        let product = try document.data(as: ProductMeatModel.self)
                        fetchedProducts.append(product)
                        print("Fetched product: \(product.productName) from category \(category)")
                        found = true
                    } catch {
                        print("Error decoding product \(id) from category \(category): \(error)")
                    }
                    
                    // Wenn das Produkt gefunden wurde, abbrechen
                    if found {
                        self.favoriteProducts = fetchedProducts
                        return
                    }
                }
                if found {
                    break
                }
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
    
  

}
