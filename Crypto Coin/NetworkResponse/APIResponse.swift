//
//  APIResponse.swift
//  Crypto Coin
//
//  Created by 이찬호 on 9/6/24.
//

import Foundation

struct APIResponse: Decodable {
    let coins: Coin
    let nfts: [NFT]
    
    struct Coin: Decodable {
        let item: [Item]
        
        struct Item: Decodable {
            let id: String
            let name: String
            let symbol: String
            let small: String
            let data: CoinData
            
            struct CoinData: Decodable {
                let price: Double
                let price_change_percentage_24h: Double
            }
        }
    }
    
    struct NFT: Decodable {
        let id: String
        let name: String
        let symbol: String
        let thumb: String
        let data: NFTData
        
        struct NFTData: Decodable {
            let floor_price: Double
            let floor_price_in_usd_24h_percentage_change: Double
        }
    }
}
