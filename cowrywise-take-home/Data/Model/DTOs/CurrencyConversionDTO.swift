//
//  CurrencyConversionDTO.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation
import SwiftyJSON

// MARK: - CurrencyConversionDTO
struct CurrencyConversionDTO: Decodable {
    let to: [To]
    
    init(json: JSON) {
        self.to = json["to"].arrayObject as! [To]
    }
}

// MARK: - To
struct To: Decodable {
    let quotecurrency: String
    let mid: Double
}
