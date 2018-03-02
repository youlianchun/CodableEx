//
//  CodableEx.swift
//  CodableEx
//
//  Created by YLCHUN on 2018/3/1.
//  Copyright © 2018年 YLCHUN. All rights reserved.
//

import Foundation

//MARK: -
//MARK: - CodableExProtocol
public protocol CodableExProtocol : Codable
{
    func encode() -> [String:Any]?
    func encode() -> String?
    func encode() -> Data?
}

extension CodableExProtocol
{
    func encode() -> [String:Any]?
    {
        return CodableEx().encode(self);
    }
    
    func encode() -> String?
    {
        return CodableEx().encode(self);
    }
    
    func encode() -> Data?
    {
        return CodableEx().encode(self);
    }
}

//MARK: -
//MARK: - Dictionary & Array extension
extension Dictionary
{
    func decode<T:Decodable>() -> T?
    {
        guard let dict = self as? [String : Any] else { return nil }
        return CodableEx().decode(dict)
    }
}

extension Array 
{
    func decode<T:Decodable>() -> Array<T>?
    {
        guard let arr = self as? Array<[String : Any]> else { return nil }
        return CodableEx().decode(arr)
    }
    
    func encode<T:Encodable>(_ type : T.Type) -> Array<[String:Any]>?
    {
        guard let arr = self as? Array<T> else { return nil }
        return CodableEx().encode(arr)
    }
}

    //MARK: -
    //MARK: - CodableEx
public class CodableEx
{
    //MARK: - decode
    //MARK: private
    private func decode<T>(json : String) -> T?
    {
        guard let data = json.data(using: .utf8) else { return nil }
        let any = try? JSONSerialization.jsonObject(with: data, options: [.mutableContainers])
        return any as? T
    }
    
    private func decode(any : Any) -> Data?
    {
        let data = try? JSONSerialization.data(withJSONObject: any, options: .prettyPrinted)
        return data
    }
    
    private func _decode<T, RT:Decodable>(_ any : T) -> RT?
    {
        guard let data:Data = decode(any:any) else { return nil }
        let any = try? JSONDecoder().decode(RT.self, from: data)
        return any
    }
    

    //MARK: public
    public func decode<T:Decodable>(_ dict : [String : Any]) -> T?
    {
        return _decode(dict)
    }
    
    public func decode<T:Decodable>(_ arr : Array<[String : Any]>) -> Array<T>?
    {
        return _decode(arr)
    }
    
    public func decode<T:Decodable>(_ json : String) -> T?
    {
        guard let dict : [String:Any] = decode(json:json) else { return nil }
        return decode(dict)
    }
    
    public func decode<T:Decodable>(_ json : String) -> Array<T>?
    {
        guard let arr : [String:Any] = decode(json:json) else { return nil }
        return decode(arr)
    }
    
    //MARK: - encode
    //MARK: private
    private func _encode<T:Encodable, RT>(obj : T) -> RT?
    {
        guard let data : Data = encode(obj) else { return nil }
        let any = try? JSONSerialization.jsonObject(with: data, options: [.mutableContainers])
        return any as? RT
    }
    
    //MARK: public
    
    public func encode<T:Encodable>(_ model : T) -> Data?
    {
        let data = try? JSONEncoder().encode(model)
        return data
    }
    
    public func encode<T:Encodable>(_ model:T) -> String?
    {
        guard let data : Data = encode(model) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    public func encode<T:Encodable>(_ model : T) -> [String:Any]?
    {
        return _encode(obj: model)
    }
    
    public func encode<T:Encodable>(_ models : Array<T>) -> Array<[String : Any]>?
    {
        return _encode(obj: models)
    }
}
