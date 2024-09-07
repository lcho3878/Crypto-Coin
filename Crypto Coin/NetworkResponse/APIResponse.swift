//
//  APIResponse.swift
//  Crypto Coin
//
//  Created by 이찬호 on 9/6/24.
//

import Foundation

struct APIResponse: Decodable {
    let coins: [Coin]
    let nfts: [NFT]
    
    struct Coin: Decodable, Hashable {
        let item: Item
        
        struct Item: Decodable, Hashable {
            let id: String
            let name: String
            let symbol: String
            let small: String
            let score: Int
            let data: CoinData
            
            struct CoinData: Decodable, Hashable {
                let price: Double
                let priceChange: [String: Double]
                var priceChangeKrw: Double {
                    return priceChange["krw"]!
                }
                
                enum CodingKeys: String, CodingKey {
                    case price
                    case priceChange = "price_change_percentage_24h"
                }
            }
        }
    }
    
    struct NFT: Decodable, Hashable {
        let name: String
        let symbol: String
        let thumb: String
        let data: NFTData
        
        struct NFTData: Decodable, Hashable {
            let floorPrice: String
            let floorPriceChange: String
            
            enum CodingKeys: String, CodingKey {
                case floorPrice = "floor_price"
                case floorPriceChange = "floor_price_in_usd_24h_percentage_change"
            }
        }
    }
}
