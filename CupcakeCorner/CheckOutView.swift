//
//  CheckOutView.swift
//  CupcakeCorner
//
//  Created by Apple on 09/08/2024.
//

import SwiftUI

struct CheckOutView: View {
    var order: Order
    
    @State private var comfirmPlaceOrderMessage = ""
    @State private var showingConfirmation = false
    

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 250)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!",isPresented: $showingConfirmation) {
        } message: {
            Text(comfirmPlaceOrderMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Error, could not encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            comfirmPlaceOrderMessage = "Your order of \(decodedOrder.quantity) cupcakes is coming!"
            showingConfirmation = true
            
        } catch {
            print("Error, could not send data, \(error.localizedDescription)")
        }
    }
}

#Preview {
    CheckOutView(order:Order())
}
