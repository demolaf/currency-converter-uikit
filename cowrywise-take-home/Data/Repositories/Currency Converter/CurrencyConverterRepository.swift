//
//  CurrencyConverterRepository.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation

protocol CurrencyConverterRepository {
    func getCurrencySymbols(completion: @escaping ([Symbols]) -> Void)
    
    func convertToCurrency(from: String, to: String, amount: Double, completion: @escaping (Double?) -> Void)
}
