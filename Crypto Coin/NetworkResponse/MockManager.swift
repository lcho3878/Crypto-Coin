//
//  MockManager.swift
//  Crypto Coin
//
//  Created by 이찬호 on 9/7/24.
//

import Foundation

final class MockManager {
    static let shared = MockManager()
    
    private init() {}
    
    func loadData(fileName: String) -> Data? {
        let fileName = fileName
        let extensionType = "json"
        
        guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: extensionType) else { return nil }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        }
        catch {
            return nil
        }
    }
}
