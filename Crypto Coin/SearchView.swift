//
//  SearchView.swift
//  Crypto Coin
//
//  Created by 이찬호 on 9/7/24.
//

import SwiftUI

struct SearchView: View {
    typealias Coin = CoinSearchResponse.Coin
    
    @State private var searchText = ""
    @State private var searchList: [Coin] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(searchList, id: \.self) { coin in
                        NavigationLink {
                            ChartView(coin: coin)
                        } label: {
                            RowView(searchText: $searchText, coin: coin)
                        }
                    }
                }
            }
                .navigationTitle("Search")
        }
        .task {
            do {
                guard let data = MockManager.shared.loadData(fileName: "CoinSearchMock") else { return }
                let result = try JSONDecoder().decode(CoinSearchResponse.self, from: data)
                searchList = result.coins
            }
            catch {
                print("Error")
            }
        }
        .searchable(text: $searchText, prompt: "코인 검색")
    }
    
    struct RowView: View {
        @Binding var searchText: String
        let coin: Coin
        
        var body: some View {
            HStack {
                AsyncImage(url: URL(string: coin.thumb)) { result in
                    result.image?
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: 40, height: 40)
                VStack(alignment: .leading) {
                    Text(coin.attributedString(range: searchText))
                        .foregroundStyle(.black)
                        .font(.title3)
                        .bold()
                    Text(coin.symbol)
                        .foregroundStyle(.gray)
                }
                Spacer()
                Image(systemName: "star")
                    .foregroundStyle(.purple)
            }
            .padding()
        }
    }
}

#Preview {
    SearchView()
}
