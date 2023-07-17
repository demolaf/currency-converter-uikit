//
//  RepositoryProvider.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation

// Example Usage
// To get an instance of repository provider from app delegate
// (UIApplication.shared.delegate as! AppDelegate).repositoryProvider
struct RepositoryProvider  {
    let currencyConverterRepository: CurrencyConverterRepository
    
    private let apiClient: APIClient
    private let currencyConverterAPI: CurrencyConverterAPI
    
    init() {
        //
        self.apiClient = APIClientImpl()
        
        //
        self.currencyConverterAPI = CurrencyConverterAPI(apiClient: apiClient)
        
        //
        self.currencyConverterRepository = CurrencyConverterRepositoryImpl(currencyConverterAPI: currencyConverterAPI)
    }
}
