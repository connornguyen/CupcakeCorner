//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Apple on 09/08/2024.
//

import SwiftUI

struct AddressView: View {
    // This is to declare order is Order property, not an actual new var. Later on I need to assign value to it
    @Bindable var order: Order  //Bindable make the data go to multiple views
    
    var body: some View {
        NavigationStack {
            Form {
                Section{
                    TextField("Your Name", text: $order.name)
                    TextField("Your Address", text: $order.streetAddress)
                    TextField("City", text: $order.city)
                    TextField("Zipcode", text: $order.zipCode)
                }
                Section {
                    NavigationLink("Check out") {
                        CheckOutView(order: order)
                    }
                }
                .disabled(order.hasValidAddress == false)
            }
            .navigationTitle("Address Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddressView(order: Order())
}
