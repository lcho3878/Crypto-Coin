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
    
    var body: some View {
        NavigationView {
            ScrollView {
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
            .task {
                guard let data = MockManager.shared.loadData() else { return }
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
