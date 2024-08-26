//
//  ProductModel.swift
//  FoodDeliveryAdmin
//
//  Created by Pascal Allekotte on 24.08.24.
//

import Foundation
import FirebaseFirestore

struct ProductModel: Identifiable, Codable {
    @DocumentID var id: String?
    
    var imageURL: String
    var ml: String
    var price: String
    var productName: String
    var discount: Bool
    var discountDetail: String
    var pfand: Bool
    var quantity: String
    var hTags: [String]?
    var category: String?
    var description: String
    var isFavorite: Bool

}
