//
//  ValidateView.swift
//  CupcakeCorner
//
//  Created by Viettasc Doan on 4/1/20.
//  Copyright © 2020 Viettasc Doan. All rights reserved.
//

import SwiftUI

struct ValidateView: View {
    @State var username = ""
    @State var email = ""
    var disable: Bool {
        username.count < 5 || email.count < 5
    }
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(disable)
        }
        .foregroundColor(Color.pink.opacity(0.6))
    }
}

struct ValidateView_Previews: PreviewProvider {
    static var previews: some View {
        ValidateView()
    }
}
