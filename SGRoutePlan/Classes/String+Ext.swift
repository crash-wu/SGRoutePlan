//
//  String+Ext.swift
//  Pods
//
//  Created by 吴小星 on 16/8/18.
//
//

import Foundation

public extension String{
    
    public func SGtoJSONObject(options opt: NSJSONReadingOptions = .AllowFragments) -> AnyObject? {
        if let jsonData = self.SGUTF8Data {
            return try? NSJSONSerialization.JSONObjectWithData(jsonData, options: opt)
        }
        
        return nil
    }
    
    
    // 返回 UTF8 编码后的 NSData
    public var SGUTF8Data: NSData? {
        return self.dataUsingEncoding(NSUTF8StringEncoding)
    }
}