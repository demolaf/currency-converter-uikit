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
    private let apiClient: APIClient
    private let localStorage: LocalStorage
    private let currencyConverterAPI: CurrencyConverterAPI
    
    let currencyConverterRepository: CurrencyConverterRepository
    
    init() {
        //
        self.apiClient = APIClientImpl()
        self.localStorage = LocalStorageImpl()
        
        //
        self.currencyConverterAPI = CurrencyConverterAPI(apiClient: apiClient, localStorage: localStorage)
        
        //
        self.currencyConverterRepository = CurrencyConverterRepositoryImpl(currencyConverterAPI: currencyConverterAPI)
    }
}
