//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Viettasc Doan on 4/1/20.
//  Copyright © 2020 Viettasc Doan. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    func validate(for string: inout String) {
        string = string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.information.name, onEditingChanged: { _ in
                    self.validate(for: &self.order.information.name)} )
                TextField("Street Address", text: $order.information.streetAddress, onEditingChanged: { _ in
                self.validate(for: &self.order.information.streetAddress)} )
                TextField("City", text: $order.information.city, onEditingChanged: { _ in
                self.validate(for: &self.order.information.city)} )
                TextField("Zip", text: $order.information.zip, onEditingChanged: { _ in
                self.validate(for: &self.order.information.zip)} )
            }

            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
                .disabled(order.information.hasValidAddress)
//                .onTapGesture {
//                    print("validate")
//                }
            }
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
        .foregroundColor(Color.pink.opacity(0.6))
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
