//
//  Order.swift
//  CupcakeCorner
//
//  Created by Viettasc Doan on 4/1/20.
//  Copyright © 2020 Viettasc Doan. All rights reserved.
//

import SwiftUI

struct Information {
    static let types = ["Vanilla", "Straberry", "Chocolate", "Rainbow"]
         var type = 0
         var quantity = 0
         var specialRequestEnabled = false {
            didSet {
                if specialRequestEnabled == false {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
         var extraFrosting = false
         var addSprinkles = false
        
         var name = ""
         var streetAddress = ""
         var city = ""
         var zip = ""
        
    //    func validate() {
    //        name = name.trimmingCharacters(in: .whitespacesAndNewlines)
    //    }
        
        var hasValidAddress: Bool {
            return
                name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
        
        var cost: Double {
            // $2 per cake
            var cost = Double(quantity) * 2

            // complicated cakes cost more
            cost += (Double(type) / 2)

            // $1/cake for extra frosting
            if extraFrosting {
                cost += Double(quantity)
            }

            // $0.50/cake for sprinkles
            if addSprinkles {
                cost += Double(quantity) / 2
            }

            return cost
        }
}

class Order: ObservableObject, Codable {
    
    @Published var information = Information()
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(information.type, forKey: .type)
        try container.encode(information.quantity, forKey: .quantity)

        try container.encode(information.extraFrosting, forKey: .extraFrosting)
        try container.encode(information.addSprinkles, forKey: .addSprinkles)

        try container.encode(information.name, forKey: .name)
        try container.encode(information.streetAddress, forKey: .streetAddress)
        try container.encode(information.city, forKey: .city)
        try container.encode(information.zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        information.type = try container.decode(Int.self, forKey: .type)
        information.quantity = try container.decode(Int.self, forKey: .quantity)

        information.extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        information.addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)

        information.name = try container.decode(String.self, forKey: .name)
        information.streetAddress = try container.decode(String.self, forKey: .streetAddress)
        information.city = try container.decode(String.self, forKey: .city)
        information.zip = try container.decode(String.self, forKey: .zip)
    }
    
    init() { }
    
    
    
}
