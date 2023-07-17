//
//  CurrencyConverterRepositoryImpl.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation

class CurrencyConverterRepositoryImpl: CurrencyConverterRepository {
    let currencyConverterAPI: CurrencyConverterAPI
    
    init(currencyConverterAPI: CurrencyConverterAPI) {
        self.currencyConverterAPI = currencyConverterAPI
    }
    
    func getCurrencySymbols(completion: @escaping ([Symbols]) -> Void) {
        var currencySymbols = [Symbols]()
        currencyConverterAPI.getCurrencySymbolsList { response, error in
            response?.symbols.forEach({ (key: String, value: String) in
                currencySymbols.append(Symbols(name: value, abbreviation: key))
            })
            completion(currencySymbols)
        }
    }
    
    func convertToCurrency(from: String, to: String, amount: Double, completion: @escaping (Double?) -> Void) {
        currencyConverterAPI.convertToCurrency(from: from, to: to, amount: amount) { conversionResult, error in
            completion(conversionResult)
        }
    }
}
