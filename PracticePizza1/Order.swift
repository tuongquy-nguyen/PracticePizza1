//
//  Order.swift
//  PracticePizza1
//
//  Created by KET on 26/04/2022.
//

import SwiftUI

class Order: ObservableObject {
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


    
}
