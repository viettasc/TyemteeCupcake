//
//  URLSessionView.swift
//  CupcakeCorner
//
//  Created by Viettasc Doan on 4/1/20.
//  Copyright © 2020 Viettasc Doan. All rights reserved.
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

struct URLSessionView: View {
    
    @State var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading, spacing: 0) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
        .foregroundColor(Color.pink.opacity(0.6))
    }
    
    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=maroon-5&entity=song") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
//            print("response: ", response)
            if let data = data {
                if let response = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = response.results
                    }
                    return
                }
            }
//            print("response: ", response)
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct URLSessionView_Previews: PreviewProvider {
    static var previews: some View {
        URLSessionView()
    }
}
