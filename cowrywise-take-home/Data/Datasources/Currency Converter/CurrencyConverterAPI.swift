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
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getCurrencySymbolsList(completion: @escaping (CurrencySymbolsListDTO?, Error?) -> Void) {
        var params = Parameters()
        params.updateValue(APIConstants.Auth.fixerAPIKey, forKey: APIConstants.Auth.fixerAPIKeyQuery)
        
        apiClient.get(url: APIConstants.Endpoints.getCurrencySymbolsList.url, headers: nil, parameters: params, response: CurrencySymbolsListDTO.self, interceptor: nil) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
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
                completion(response.to.first?.mid, nil)
            } else {
                completion(nil, error)
            }
        }?.authenticate(username: user, password: password)
    }
}
