//
//  Response + map.swift
//  NetworkCore
//
//  Created by Top on 2021/2/4.
//

import Foundation
import Moya
import RxSwift


#warning("解析规则，根据项目自定")
private extension Response {
    
    // 解析成为基础数据模型
    func mapBaseDataModel<T>(_ type: T.Type) throws -> ResponseDataModel<T> {
        let jsonString = String(data: data, encoding: .utf8)
        guard (200 ... 299).contains(statusCode) else { throw NetworkError.invalid }
        guard let model = ResponseDataModel<T>.deserialize(from: jsonString) else { throw NetworkError.invalid }
        if model.code != 200 { throw NetworkError.api(message: model.message) }
        return model
    }
    
    // 将 `data` 字段解析成为 `空对象`
    func mapEmptyDataModel() throws {
        _ = try mapBaseDataModel(String.self)
    }
    
    // 将 `data` 字段解析成为 `对象`
    func mapObjectDataModel<T>(_ type: T.Type) throws -> T {
        guard let data = try mapBaseDataModel(type).data else { throw NetworkError.invalid }
        return data
    }
    
    // 将 `data` 字段解析成为 `列表`
    func mapListDataModel<T>(_ type: [T].Type) throws -> [T] {
        return try mapBaseDataModel(type).data ?? []
    }
}


public extension ObservableType where E == Response {
    
    // 解析为 `基础数据模型`
    func mapBaseDataModel<T>(_ type: T.Type) -> Observable<ResponseDataModel<T>> {
        return flatMap{ Observable.just(try $0.mapBaseDataModel(type)) }
    }
    
    // 解析为 `空数据模型`
    func mapEmptyDataModel() -> Observable<Void> {
        return flatMap{ Observable.just(try $0.mapEmptyDataModel()) }
    }
    
    // 解析为 `对象数据模型`
    func mapObjectDataModel<T>(_ type: T.Type) -> Observable<T> {
        return flatMap{ Observable.just(try $0.mapObjectDataModel(type)) }
    }
    
    // 解析为 `列表模型`
    func mapListDataModel<T>(_ type: [T].Type) -> Observable<[T]> {
        return flatMap{ Observable.just(try $0.mapListDataModel(type)) }
    }
}


public extension PrimitiveSequence where Trait == SingleTrait, E == Response {
    
    // 解析为 `基础数据模型`
    func mapBaseDataModel<T>(_ type: T.Type) -> Single<ResponseDataModel<T>> {
        return flatMap{ Single.just(try $0.mapBaseDataModel(type)) }
    }
    
    // 解析为 `空数据模型`
    func mapEmptyDataModel() -> Single<Void> {
        return flatMap{ Single.just(try $0.mapEmptyDataModel()) }
    }
    
    // 解析为 `对象数据模型`
    func mapObjectDataModel<T>(_ type: T.Type) -> Single<T> {
        return flatMap{ Single.just(try $0.mapObjectDataModel(type)) }
    }
    
    // 解析为 `列表模型`
    func mapListDataModel<T>(_ type: [T].Type) -> Single<[T]> {
        return flatMap{ Single.just(try $0.mapListDataModel(type)) }
    }
}
