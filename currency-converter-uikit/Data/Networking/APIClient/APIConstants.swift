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
        static let xeAPIKeyQuery = "api_key"
        static let xeAccountID = "na309460343"
        static let xeAPIKey = "bbdur0otvqjiglgh03ml1gjsh3"
    }
    
    enum Endpoints {
        static let httpUrlScheme = "http://"
        static let httpsUrlScheme = "https://"
        static let fixerAPIHost = "data.fixer.io/api"
        static let xeAPIHost = "xecdapi.xe.com/v1"
        
        static let fixerBaseURL = "\(httpUrlScheme)\(fixerAPIHost)"
        static let xeBaseURL = "\(httpsUrlScheme)\(xeAPIHost)"
        
        case getCurrencySymbolsList
        case convertCurrency
        case convertCurrencyXE
        
        var stringValue: String {
            switch self {
            case .getCurrencySymbolsList:
                return "\(Endpoints.fixerBaseURL)/symbols"
            case .convertCurrency:
                return "\(Endpoints.fixerBaseURL)/convert"
            case .convertCurrencyXE:
                return "\(Endpoints.xeBaseURL)/convert_from"
            }
        }
        
        var url: URL? {
            // This handles converting string to URL and accepting spaces in query params
            return URL(string: stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        }
    }
}
