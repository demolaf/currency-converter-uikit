//
//  CurrencyConverterAPI.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation
import Alamofire

class CurrencyConverterAPI {
    let apiClient: APIClient
    let localStorage: LocalStorage
    
    init(apiClient: APIClient, localStorage: LocalStorage) {
        self.apiClient = apiClient
        self.localStorage = localStorage
    }
    
    func getCurrencySymbolsList(completion: @escaping (CurrencySymbolsListDTO?, Error?) -> Void) {
        var params = Parameters()
        params.updateValue(APIConstants.Auth.fixerAPIKey, forKey: APIConstants.Auth.fixerAPIKeyQuery)
        
        apiClient.get(url: APIConstants.Endpoints.getCurrencySymbolsList.url, headers: nil, parameters: params, response: CurrencySymbolsListDTO.self, interceptor: nil) { response, error in
            if let response = response {
                // Store fetched responses in local storage
                self.localStorage.create(object: response, realmUpdatePolicy: .modified)
                
                completion(response, nil)
            } else {
                // Get stored response in local storage if error fetching from remote
                self.localStorage.read(object: CurrencySymbolsListDTO.self) { object, error in
                    if let object = object {
                        completion(object, nil)
                    } else {
                        completion(nil, error)
                    }
                }
            }
        }
    }
    
    func convertToCurrency(from: String, to: String, amount: Double, completion: @escaping (Double?, Error?) -> Void) {
        let user = APIConstants.Auth.xeAccountID
        let password = APIConstants.Auth.xeAPIKey
        
        var params = Parameters()
        
        params.updateValue(from, forKey: "from")
        params.updateValue(to, forKey: "to")
        params.updateValue(amount, forKey: "amount")
        
        apiClient.get(url: APIConstants.Endpoints.convertCurrencyXE.url, headers: nil, parameters: params, response: CurrencyConversionDTO.self, interceptor: nil) { response, error in
            if let response = response {
                // Store fetched responses in local storage
                self.localStorage.create(object: response, realmUpdatePolicy: .all)
                
                completion(response.to.first?.mid, nil)
            } else {
                completion(nil, error)
            }
        }?.authenticate(username: user, password: password)
    }
    
    func getConvertedCurrencyValues(completion: @escaping ([CurrencyConversionDTO], Error?) -> Void) {
        self.localStorage.readAll(object: CurrencyConversionDTO.self) { results, error in
            var currencyConvertedHistory = [CurrencyConversionDTO]()
            
            if let results = results {
                let values = results.sorted(byKeyPath: "createdAt", ascending: false)
                values.forEach { currencyConverted in
                    currencyConvertedHistory.append(currencyConverted)
                }
                completion(currencyConvertedHistory, nil)
            } else {
                completion([], error)
            }
        }
    }
}
