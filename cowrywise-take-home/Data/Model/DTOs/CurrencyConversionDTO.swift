//
//  CurrencyConversionDTO.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation
import SwiftyJSON

// MARK: - CurrencyConversionDTO
struct CurrencyConversionDTO: Codable {
    let success: Bool
    let result: Double
    
    init(json: JSON) {
        self.success = json["success"].boolValue
        self.result = json["result"].doubleValue
    }
}
