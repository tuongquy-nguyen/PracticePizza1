//
//  Order.swift
//  PracticePizza1
//
//  Created by KET on 26/04/2022.
//

import SwiftUI

class Order: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case type, quantity, addMoreTuna, addMoreHam, addMoreBeef, addMorePepperoni, addMoreShirmp, name, streetAddress, city, phoneNumber, cost
    }
    
    static let types = ["Basic Pizza", "Tuna Pizza", "BBQ Pizza", "Beef Pizza", "Pepperoni Pizza", "Special Pizza"]
    @Published var type = 0
    @Published var quantity = 1
    
    @Published var extraToppingEnabled = false {
        didSet {
            if extraToppingEnabled == false {
                addMoreTuna = false
                addMoreHam = false
                addMoreBeef = false
                addMorePepporoni = false
                addMoreShirmp = false
            }
        }
    }
    @Published var addMoreTuna = false
    @Published var addMoreHam = false
    @Published var addMoreBeef = false
    @Published var addMorePepporoni = false
    @Published var addMoreShirmp = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    
//    add regex for Vietnamese phone number
    let phonePattern = #"^\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}$"#
//    check if the phonenumber were right or not
    var validPhoneNumber: Bool {
        let result = phoneNumber.range(of: phonePattern, options: .regularExpression)
        if result != nil {
            return true
        }
        return false
        
    }
    @Published var phoneNumber = ""
    
//    disable the checkout if the field is not valid
    var addressIsValidated: Bool {
        if !validPhoneNumber || name.isEmpty || streetAddress.isEmpty || city.isEmpty {
            return false
        }
        return true
    }

    var cost: Int {
//        89000 per basic pizza
        var cost = 89000 * quantity
        
//        other pizza than basic is cost more
        cost += type != 0 ? 30000 * quantity : 0
        
//        cost more by the topping
        cost += addMoreTuna ? 15000 * quantity : 0
        cost += addMoreHam ? 10000 * quantity : 0
        cost += addMoreBeef ? 15000 * quantity : 0
        cost += addMoreShirmp ? 17000 * quantity : 0
        cost += addMorePepporoni ? 12000 * quantity : 0
        
        return cost
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(addMoreTuna, forKey: .addMoreTuna)
        try container.encode(addMoreHam, forKey: .addMoreHam)
        try container.encode(addMoreBeef, forKey: .addMoreBeef)
        try container.encode(addMorePepporoni, forKey: .addMorePepperoni)
        try container.encode(addMoreShirmp, forKey: .addMoreShirmp)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(city, forKey: .city)
        try container.encode(cost, forKey: .cost)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        addMoreTuna = try container.decode(Bool.self, forKey: .addMoreTuna)
        addMoreHam = try container.decode(Bool.self, forKey: .addMoreHam)
        addMoreBeef = try container.decode(Bool.self, forKey: .addMoreBeef)
        addMorePepporoni = try container.decode(Bool.self, forKey: .addMorePepperoni)
        addMoreShirmp = try container.decode(Bool.self, forKey: .addMoreShirmp)
        name = try container.decode(String.self, forKey: .name)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)

    }
    init() { }
}
