//
//  APIClient.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation
import Alamofire

protocol APIClient {
    /// GET Method
    @discardableResult
    func get<ResponseType: Decodable>(url: URL?, headers: HTTPHeaders?, parameters: Parameters?, response: ResponseType.Type, interceptor: RequestInterceptor?, completion: @escaping (ResponseType?, Error?) -> Void) -> DataRequest?
}
