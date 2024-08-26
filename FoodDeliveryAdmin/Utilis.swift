//
//  Utilis.swift
//  FoodDeliveryAdmin
//
//  Created by Pascal Allekotte on 25.08.24.
//

import Foundation
import SwiftUI


extension View {
    func textFieldStyle() -> some View {
        self
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .frame(height: 45)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("MagicBlue"), lineWidth: 0.5)
            )
            .foregroundStyle(.black)
    }
}
