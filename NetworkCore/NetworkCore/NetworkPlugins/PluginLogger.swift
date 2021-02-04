//
//  PluginLogger.swift
//  NetworkCore
//
//  Created by Top on 2021/2/4.
//

import Foundation
import Moya

public struct PluginLogger: PluginType {
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        guard let target = target as? CoreTargetType, target.isEnableShowLogger == true else { return }
        #if DEBUG
        DispatchQueue.global().async {
            var logContent: String = "===============请求开始=============="
            logContent.append("\n请求链接：" + target.baseURL.absoluteString + target.path)
            if let headers = target.headers,
               let data = try? JSONSerialization.data(withJSONObject: headers , options: .prettyPrinted),
               let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                logContent.append("\n请求头：\(json)")
            }
            
            switch result {
            case .success(let response):
                let jsonData = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
                logContent.append("\n请求结果：\(jsonData ?? "")")
            case .failure(let error):
                logContent.append("\n请求结果：" + "ErrorCode: \((error as NSError).code)" + " ErrorMessage：\(error.localizedDescription)")
            }
            
            logContent.append("\n===============请求结束==============")
            DispatchQueue.main.async {
                print(logContent)
            }
        }
        #endif
    }
}
