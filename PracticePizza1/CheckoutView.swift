//
//  CheckoutView.swift
//  PracticePizza1
//
//  Created by KET on 26/04/2022.
//

import SwiftUI

struct CheckoutView: View {
    @State private var showingConfirm = false
    @State private var confirmMessage = ""
    
    @StateObject var order: Order
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://www.garciadepou.com/blog/wp-content/uploads/2016/08/pizza.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 250)
                Text("Tổng thanh toán đơn hàng của bạn là: \(order.cost, format: .currency(code: "VND"))")
                Button("Đặt hàng") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }

        }
        .alert("Hoàn tất", isPresented: $showingConfirm) {
            Button("Yay!") {}
        } message: {
            Text(confirmMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Can not encode object!")
            return
        }
//        prepare request
        let url = URL(string: "Https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-View")
        request.httpMethod = "POST"
        
//        send request to api
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
//            this is JSON Data, so we have to decode data to Swift Object in order to use in in confirm alert
            let decodedResult = try JSONDecoder().decode(Order.self, from: data)
            confirmMessage = "Đơn đặt hàng \(decodedResult.quantity) chiếc \(Order.types[decodedResult.type]) đang trên đường vận chuyển. Chúc bạn ngon miệng!"
            showingConfirm = true
            
        } catch {
            print("Không thể đặt hàng!")
        }
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
