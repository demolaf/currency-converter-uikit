//
//  APIClientImpl.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIClientImpl: APIClient {
    
    func get<ResponseType: Decodable>(url: URL?, headers: HTTPHeaders?, parameters: Parameters?, response: ResponseType.Type, interceptor: RequestInterceptor?, completion: @escaping (ResponseType?, Error?) -> Void) -> DataRequest? {
        guard let url = url else {
            return nil
        }
        
        let request = AF.request(url, parameters: parameters, headers: headers, interceptor: interceptor).responseDecodable(of: ResponseType.self) { response in
            switch response.result {
            case .success(let responseObject):
                debugPrint(responseObject)
                completion(responseObject, nil)
            case .failure(let error):
                debugPrint(error)
                completion(nil, error)
            }
        }
        
        request.resume()
        return request
    }
}
