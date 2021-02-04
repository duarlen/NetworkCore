//
//  TestService.swift
//  NetworkCore
//
//  Created by Top on 2021/2/4.
//

import Foundation
import Moya

enum TestService {
    case test111
}

extension TestService: CoreTargetType  {
    
    var baseURL: URL {
        return URL(string: "http://www.baidu.com")!
    }
    
    var path: String {
        return "/12345"
    }
    
    var method: Moya.Method {
        return Moya.Method.get
    }
    
    var task: Task {
        return Task.requestParameters(parameters: [:], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
}
