//
//  ProductMeatModel.swift
//  FoodDeliveryAdmin
//
//  Created by Pascal Allekotte on 24.08.24.
//

import Foundation
import FirebaseFirestore


struct ProductMeatModel : Codable, Identifiable {
    
    @DocumentID var id: String?
    
    var description : String
    var imageURL : String
    var price : String 
    var productName: String
    var vauswahl1 : String
    var vauswahl2 : String
    var discount : Bool
    var discountDetail : String
    var isFavorite : Bool
    var category: String?
    var hTags: [String]?
    
}

