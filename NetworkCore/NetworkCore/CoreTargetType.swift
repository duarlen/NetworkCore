//
//  CoreTargetType.swift
//  NetworkCore
//
//  Created by Top on 2021/2/4.
//

import Foundation
import Moya

#warning("可以根据业务需要，添加其他功能")
public protocol CoreTargetType: TargetType {
    
    // 包含的插件
    static var plugins: [PluginType] { get }
    
    // 请求超时时间
    var timeoutInterval: TimeInterval { get }
    
    // 是否显示网络请求指示灯
    var isEnableShowNetworkActivityIndicator: Bool { get }
    
    // 是否能够显示日志
    var isEnableShowLogger: Bool { get }
}


extension CoreTargetType {
    
    static var plugins: [PluginType] {
        return [PluginTimeout(), PluginLogger(), PluginNetworkActivityIndicator()]
    }
    
    var timeoutInterval: TimeInterval {
        return 30
    }
    
    var isEnableShowNetworkActivityIndicator: Bool {
        return true
    }
    
    var isEnableShowLogger: Bool {
        return true
    }
    
    var sampleData: Data {
        return Data()
    }
}

public extension CoreTargetType {
    
    #warning("用户根据需要，添加自己需要的插件")
    static func provider() -> MoyaProvider<Self> {
        return MoyaProvider(plugins: plugins)
    }
}
