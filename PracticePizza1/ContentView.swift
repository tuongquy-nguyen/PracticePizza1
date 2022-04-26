//
//  ContentView.swift
//  PracticePizza1
//
//  Created by KET on 26/04/2022.
//

import SwiftUI

struct ContentView: View {
    
//    create an order instance to store order detail during the process of application
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Chọn loại Pizza bạn muốn?", selection: $order.type) {
                        ForEach(Order.types.indices) { item in
                            Text(Order.types[item])
                        }
                    }
                    Stepper("Số lượng pizza: \(order.quantity)", value: $order.quantity, in: 1...10)
                }
                
                Section {
                    Toggle("Bạn có muốn thêm topping cho pizza của mình?", isOn: $order.extraToppingEnabled.animation())
                    if order.extraToppingEnabled {
                        Toggle("Thêm cá ngừ?", isOn: $order.addMoreTuna)
                        Toggle("Thêm thịt nguội?", isOn: $order.addMoreHam)
                        Toggle("Thêm thịt bò nướng?", isOn: $order.addMoreBeef)
                        Toggle("Thêm xúc xích Ý?", isOn: $order.addMorePepporoni)
                        Toggle("Thêm tôm?", isOn: $order.addMoreShirmp)
                        
                    }
                }
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Tiếp tục")
                    }
                }
            }
            .navigationTitle("Practice01")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
