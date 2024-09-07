//
//  ContentView.swift
//  Crypto Coin
//
//  Created by 이찬호 on 9/6/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            TrendView()
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            FavoriteView()
                .tabItem {
                    Image(systemName: "bag")
                }
        }
    }
    
}

#Preview {
    ContentView()
}
