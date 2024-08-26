//
//  FireUser.swift
//  FoodDeliveryAdmin
//
//  Created by Pascal Allekotte on 24.08.24.
//

import Foundation

struct FireUser : Codable, Identifiable{
    
    let id: String
    var name: String
    var nachname: String
    var mobilNumber: String
    var email: String
    var adress : AdressModel
    var favorites : [String] = []
    var admin : Bool
    
}


