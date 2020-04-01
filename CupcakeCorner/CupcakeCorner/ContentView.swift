//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Viettasc Doan on 4/1/20.
//  Copyright © 2020 Viettasc Doan. All rights reserved.
//

import SwiftUI

//class Example {
//    var name: String = ""
//}

struct ContentView: View {
    @ObservedObject var order = Order()
//    @State var order = Example()
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Avatar")) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                        Image("tyemtee")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .padding()
                    }
                    .frame(height: 231)
                }
                Section {
                    Picker("Select your cake type", selection: $order.information.type) {
                        ForEach(0...Information.types.count - 1, id: \.self) {
                            Text(Information.types[$0])
                        }     
                    }
                    Stepper(value: $order.information.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.information.quantity)")
                    }
                }
                Section {
                    Toggle(isOn: $order.information.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    if order.information.specialRequestEnabled {
                        Toggle(isOn: $order.information.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        Toggle(isOn: $order.information.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Tyemtee Corner")
        }
        .foregroundColor(Color.pink.opacity(0.6))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
