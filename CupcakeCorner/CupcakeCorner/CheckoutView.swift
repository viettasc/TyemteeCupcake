//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Viettasc Doan on 4/1/20.
//  Copyright © 2020 Viettasc Doan. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var title = "Thank you!"
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    var body: some View {
//        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcake")
                        .resizable()
                        .scaledToFit()
//                        .frame(width: geo.size.width)

                    Text("Your total is $\(self.order.information.cost, specifier: "%.2f")")
                        .font(.title)

                    Button("Place Order") {
                        // place the order
                        self.placeOrder()
                    }
                    .padding()
                }
            }
//        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text(title), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
        .foregroundColor(Color.pink.opacity(0.6))
    }
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle the result here.
            print("error: ", error as Any)
            if error == nil {
                guard let data = data else {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                    return
                }
                if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                    self.confirmationMessage = "Your order for \(decodedOrder.information.quantity)x \(Information.types[decodedOrder.information.type].lowercased()) cupcakes is on its way!"
                    
                } else {
//                    self.confirmationMessage = "Invalid response from server"
                    print("Invalid response from server")
                }
            } else {
                self.title = "Unexpected."
                self.confirmationMessage = "Connection"
            }
            
            self.showingConfirmation = true
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
