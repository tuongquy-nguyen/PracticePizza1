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
        Form {
            Section {
                TextField("Họ và tên", text: $order.name)
                TextField("Số điện thoại", text: $order.phoneNumber)
                    .keyboardType(.numberPad)
                TextField("Địa chỉ", text: $order.streetAddress)
                TextField("Thành phố", text: $order.city)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Thanh toán")
                }
            }
            .disabled(!order.addressIsValidated)
            
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
