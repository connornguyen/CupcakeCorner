//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Apple on 08/08/2024.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}


struct ContentView: View {
    //THis is to make a NEW varible that have Order() attribute
    @State private var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cupcake", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])  //This "indices use when we refer the array index with number to select
                        }
                        // Stepper("string", value: $.., in: <range> )
                    }
                    Stepper("Number of cake \(order.quantity)", value: $order.quantity, in: 0...20)
                }
                Section{
                    //This make a toggle
                    Toggle("Any spectial add-on?", isOn: $order.speacialRequestEnabled.animation())
                    
                    //This check condition to show other two options
                    if order.speacialRequestEnabled {
                        Toggle("Add more frosting?", isOn: $order.extraFrosting.animation())
                        Toggle("Add more sprinkles?", isOn: $order.addSprinkles.animation())
                    }
                }
                
                Section {
                    NavigationLink("Delivey Details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
    
}

struct AnotherView: View {
    
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 300, height: 300)
    }
}

#Preview {
    ContentView()
}
