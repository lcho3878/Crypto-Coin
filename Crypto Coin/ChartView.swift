//
//  ChartView.swift
//  Crypto Coin
//
//  Created by 이찬호 on 9/8/24.
//

import SwiftUI

struct ChartView: View {
    typealias Coin = CoinSearchResponse.Coin
    
    let coin: Coin
    struct Test: Hashable {
        let title: String
        let data: String
        let color: Color
    }
    let dummy = [
        Test(title: "고가", data: "₩69,234,243", color: .red),
        Test(title: "신고점", data: "₩2,869,234,243", color: .red),
        Test(title: "저가", data: "₩69,234,245", color: .blue),
        Test(title: "신저점", data: "₩6,364", color: .blue),
    ]
    
    let rows = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
    ]
    
    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading) {
                    Text("₩69,234,245")
                        .font(.largeTitle)
                        .bold()
                    HStack {
                        Text("+3.22%")
                            .foregroundStyle(.red)
                        Text("Today")
                            .foregroundStyle(.gray)
                    }
                }
                Spacer()

            }
            .padding()
            
            LazyHGrid(rows: rows, spacing: 100) {
                ForEach(dummy, id: \.self) { item in
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .foregroundStyle(item.color)
                            .bold()
                        Text(item.data)
                            .foregroundStyle(.gray)
                            .bold()
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(coin.name)

    }
    
    struct asdf: View {
        let coin: Coin
        
        var body: some View {
            AsyncImage(url: URL(string: coin.thumb))
        }
    }
}

#Preview {
    SearchView()
}
