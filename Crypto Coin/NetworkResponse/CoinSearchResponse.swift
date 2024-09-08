//
//  CoinSearchResponse.swift
//  Crypto Coin
//
//  Created by 이찬호 on 9/8/24.
//

import Foundation

struct CoinSearchResponse: Decodable, Hashable {
    let coins: [Coin]
    
    struct Coin: Decodable, Hashable {
        let id: String
        let name: String
        let symbol: String
        let thumb: String
        
        func attributedString(range: String) -> AttributedString {
            var string = AttributedString(name.lowercased())
            guard let range = string.range(of: range.lowercased()) else {
                return AttributedString(name)
            }
            string = AttributedString(name)
            string[range].foregroundColor = .purple
            return string
        }
    }
}
