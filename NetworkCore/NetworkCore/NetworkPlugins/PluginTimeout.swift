//
//  PluginTimeout.swift
//  NetworkCore
//
//  Created by Top on 2021/2/4.
//

import Foundation
import Moya

public struct PluginTimeout: PluginType {
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let target = target as? CoreTargetType else { return request }
        var newRequest = request
        newRequest.timeoutInterval = target.timeoutInterval
        return newRequest
    }
}
