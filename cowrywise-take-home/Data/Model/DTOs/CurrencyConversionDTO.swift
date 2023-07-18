//
//  CurrencyConversionDTO.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation
import SwiftyJSON
import RealmSwift

// MARK: - CurrencyConversionDTO
class CurrencyConversionDTO: Object, Decodable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var to: List<To>
    @Persisted var createdAt: Date = Date()
    
    private enum CodingKeys: String, CodingKey {
        case to
    }
}

// MARK: - To
class To: Object, Decodable {
    @Persisted var quotecurrency: String
    @Persisted var mid: Double
}
