//
//  ResponseHelper.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum RequestType: String {
    case url = "url"
    case json = "json"
}

struct ResponseHelper {
    static func POST(with type: RequestType, url: String, headers: HTTPHeaders? = nil, parameters: [String: Any], success: @escaping(JSON) -> Void, failure: @escaping(Error) -> Void) {
        let encoding: ParameterEncoding
        switch type {
        case .url:
            encoding = URLEncoding.default
        case .json:
            encoding = JSONEncoding.default
        }
        var newParameters = parameters
        if parameters.first(where: { (key, value) -> Bool in
            return key == "query"
        }) == nil {
            newParameters["query"] = "ios"
        }
        AF.request(url,
                   method: .post,
                   parameters: newParameters,
                   encoding: encoding,
                   headers: headers)
        .responseJSON { (response) in
            validate(response: response, success: success, failure: failure)
        }
    }
    
    static func GET(with type: RequestType, url: String, headers: HTTPHeaders? = nil, parameters: [String: Any]?, success: @escaping(JSON) -> Void, failure: @escaping(Error) -> Void) {
        let encoding: ParameterEncoding
        switch type {
        case .url:
            encoding = URLEncoding.default
        case .json:
            encoding = JSONEncoding.default
        }
        var newParameters = parameters ?? [:]
        if parameters?.first(where: { (key, value) -> Bool in
            return key == "query"
        }) == nil {
            newParameters["query"] = "ios"
        }
        AF.request(url,
                   method: .get,
                   parameters: newParameters,
                   encoding: encoding,
                   headers: headers)
        .responseJSON { (response) in
            validate(response: response, success: success, failure: failure)
        }
    }
    
    private static func validate(response: AFDataResponse<Any>, success: @escaping(JSON) -> Void, failure: @escaping(Error) -> Void) {
        switch response.result {
        case .failure(let error):
            #if DEBUG
            print("AFError: \(error.localizedDescription)")
            #endif
            failure(error)
        case .success(let value):
            let jsonObject = JSON(value)
            #if DEBUG
            print("Response: \(response.response?.statusCode ?? 0) - \(jsonObject)")
            #endif
            success(jsonObject)
        }
    }
}
