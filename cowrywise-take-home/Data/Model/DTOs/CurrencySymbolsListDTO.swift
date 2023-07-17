//
//  CurrencySymbolsListDTO.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 17/07/2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let currencySymbolsListDTO = try? JSONDecoder().decode(CurrencySymbolsListDTO.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseCurrencySymbolsListDTO { response in
//     if let currencySymbolsListDTO = response.result.value {
//       ...
//     }
//   }

import Foundation
import SwiftyJSON

// MARK: - CurrencySymbolsListDTO
struct CurrencySymbolsListDTO: Decodable {
    let success: Bool
    let symbols: [String: String]
    
    init(json: JSON) {
        self.success = json["success"].boolValue
        self.symbols = json["symbols"].dictionaryObject as! [String: String]
    }
}
