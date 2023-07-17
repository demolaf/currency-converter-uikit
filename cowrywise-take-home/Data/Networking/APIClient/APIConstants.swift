//
//  APIConstants.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation



class APIConstants {
    struct Auth {
        static let fixerAPIKeyQuery = "access_key"
        static let fixerAPIKey = "5f7125e773d2377386966de18a4a359b"
    }
    
    enum Endpoints {
        static let urlScheme = "http://"
        static let fixerAPIHost = "data.fixer.io/api"
        static let fixerBaseURL = "\(urlScheme)\(fixerAPIHost)"
        //static let fixerAPIKeyValue = ["access_key": Auth.fixerAPIKey]
        
        case getCurrencySymbolsList
        case convertCurrency(String, String, Double)
        
        var stringValue: String {
            switch self {
            case .getCurrencySymbolsList:
                return "\(Endpoints.fixerBaseURL)/symbols"
            case let .convertCurrency(from, to, amount):
                return "\(Endpoints.fixerBaseURL)/convert?from=\(from)&to=\(to)&amount=\(amount)"
            }
        }
        
        var url: URL? {
            // This handles converting string to URL and accepting spaces in query params
            return URL(string: stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        }
    }
}
