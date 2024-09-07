//
//  ContentView.swift
//  Crypto Coin
//
//  Created by 이찬호 on 9/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var test = [APIResponse.Coin]()
    
    var body: some View {
        NavigationView {
            List(test, id: \.self) { item in
                Text(item.item.id)
            }
        }
        .task {
            guard let data = MockManager.shared.loadData() else { return }
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                test = result.coins
                print("success")
            }
            catch {
                print("error: \(error)")
            }
        }
    }
    
}

#Preview {
    ContentView()
}
