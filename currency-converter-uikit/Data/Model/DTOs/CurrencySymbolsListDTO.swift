//
//  CurrencySymbolsListDTO.swift
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
import RealmSwift

// MARK: - CurrencySymbolsListDTO
class CurrencySymbolsListDTO: Object, Decodable {
    @Persisted(primaryKey: true) var _id: ObjectId?
    @Persisted var success: Bool
    @Persisted var symbols: Map<String, String>
    
    private enum CodingKeys: String, CodingKey {
        case success, symbols
    }
}
