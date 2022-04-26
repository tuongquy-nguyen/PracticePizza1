//
//  AddressView.swift
//  PracticePizza1
//
//  Created by KET on 26/04/2022.
//

import SwiftUI

struct AddressView: View {
    @StateObject var order: Order
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
