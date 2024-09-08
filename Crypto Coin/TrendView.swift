//
//  TrendView.swift
//  Crypto Coin
//
//  Created by 이찬호 on 9/7/24.
//

import SwiftUI

struct TrendView: View {
    typealias Coin = APIResponse.Coin
    
    @State private var coins: [Coin] = []
    let rows: [GridItem] = Array(repeating: .init(.fixed(80)), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView {
                FavoriteView(coins: coins)
                VStack(alignment: .leading) {
                    Text("TOP 15 Coin")
                        .font(.title)
                        .bold()
                        .padding()
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: rows, alignment: .center) {
                            ForEach(coins, id: \.self) { item in
                                VStack(spacing: 2) {
                                    HStack {
                                        Text("\(item.item.score + 1)")
                                            .font(.title)
                                        AsyncImage(url: URL(string: item.item.small))
                                            .frame(width: 80, height: 80)
                                        VStack(alignment: .leading) {
                                            Text(item.item.name)
                                            Text(item.item.symbol)
                                        }
                                        Spacer(minLength: 80)
                                        VStack {
                                            Text("$\(item.item.data.price)")
                                            Text("\(item.item.data.priceChangeKrw)")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .task {
                guard let data = MockManager.shared.loadData(fileName: "Mock") else { return }
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    coins = result.coins
                }
                catch {
                    print("에러")
                }
            }
            .navigationTitle("Crypto Coin")
        }
    }
    
    struct FavoriteView: View {
        let coins: [Coin]
        var body: some View {
            VStack(alignment: .leading) {
                Text("My Favorite")
                    .font(.title)
                    .bold()
                    .padding()
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(coins, id: \.self) { coin in
                            FavoriteRowView(coin: coin)
                        }
                    }
                }
            }
        }
    }
    
    struct FavoriteRowView: View {
        let coin: Coin
        
        var body: some View {
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
                .opacity(0.3)
                .frame(width: 250, height: 180)
                .overlay {
                    VStack(alignment: .leading) {
                        HStack {
                            AsyncImage(url: URL(string: coin.item.small))
                            VStack(alignment: .leading) {
                                Text(coin.item.name)
                                Text(coin.item.symbol)
                                    .foregroundStyle(.gray)
                            }
                            Spacer()
                        }
                        .padding()
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("$\(coin.item.data.price)")
                            if let priceChange = coin.item.data.priceChange["krw"] {
                                Text("\(priceChange)")
                                    .foregroundStyle(priceChange >= 0 ? .red : .blue)
                            }
                        }
                        .padding()
                       
                    }
                }
        }
    }
}

#Preview {
    TrendView()
}
