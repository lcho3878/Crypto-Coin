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
                    ForEach(searchList, id: \.self) { item in
                        HStack {
                            AsyncImage(url: URL(string: item.thumb)) { result in
                                result.image?
                                    .resizable()
                                    .scaledToFill()
                            }
                            .frame(width: 40, height: 40)
                            VStack(alignment: .leading) {
                                Text(item.attributedString(range: searchText))
                                    .font(.title3)
                                    .bold()
                                Text(item.symbol)
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
}

#Preview {
    SearchView()
}
