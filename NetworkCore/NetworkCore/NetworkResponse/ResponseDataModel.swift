//
//  ResponseDataModel.swift
//  NetworkCore
//
//  Created by Top on 2021/2/4.
//

import Foundation
import HandyJSON

#warning("根据自身项目设置对应的基础数据模型字段")
public class ResponseDataModel<T>: HandyJSON {
    
    public var code: Int = 0        // 状态码
    public var version: String = "" // 版本信息
    public var message: String = "" // 错误信息
    public var data: T?
    
    public required init() { }
}
