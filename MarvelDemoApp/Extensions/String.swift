//
//  String.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import Foundation

extension String {
    
    public func append(pathComponent:String?) -> String {
        guard let component = pathComponent else { return self }
        return self.appending((self.last == "/" || component.first == "/") ? component : ("/" + component))
    }
    
    mutating func addQueryParameter(key:String?, value:String?) {
        
        guard let value = value else { return }
        guard let key = key else { return }
        
        let queryString = key + "=" + value.escape()
        self = self + (self.contains("?") ? "&" : "?") + queryString
    }
    
    mutating func addQueryParameter(key:String?, value:Int?){
        self.addQueryParameter(key: key, value: value?.toString())
    }
    
    mutating func addQueryParameter<Key:RawRepresentable>(key:Key?, value:Int?) where Key.RawValue == String {
        self.addQueryParameter(key: key?.rawValue, value: value?.toString())
    }
    
    mutating func addQueryParameter<Key:RawRepresentable>(key:Key?, value:String?) where Key.RawValue == String {
        self.addQueryParameter(key: key?.rawValue, value: value)
    }
    
    public func escape() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}
