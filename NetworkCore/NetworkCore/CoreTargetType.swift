//
//  CoreTargetType.swift
//  NetworkCore
//
//  Created by Top on 2021/2/4.
//

import Foundation
import Moya

public protocol CoreTargetType: TargetType {
    
    // 请求超时时间
    var timeoutInterval: TimeInterval { get }
    
    // 是否显示网络请求指示灯
    var isEnableShowNetworkActivityIndicator: Bool { get }
    
    // 是否能够显示日志
    var isEnableShowLogger: Bool { get }
}

extension CoreTargetType {
    
    var timeoutInterval: TimeInterval {
        return 30
    }
    
    var isEnableShowNetworkActivityIndicator: Bool {
        return true
    }
    
    var isEnableShowLogger: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    var sampleData: Data {
        return Data()
    }
}

public extension CoreTargetType {
    
    #warning("用户根据需要，添加自己需要的插件")
    static func provider() -> MoyaProvider<Self> {
        var plugins: [PluginType] = []
        plugins.append(PluginTimeout())
        plugins.append(PluginLogger())
        plugins.append(PluginNetworkActivityIndicator())
        return MoyaProvider(plugins: plugins)
    }
}
