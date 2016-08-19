//
//  UIColor+Ext.swift
//  SGRoutePlan
//
//  Created by 吴小星 on 16/8/19.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import Foundation

extension UIColor{
    
    convenience init?(hexString: String) {
        var hexStr = hexString.uppercaseString
        
        if hexStr.hasPrefix("#") {
            hexStr.removeAtIndex(hexStr.startIndex)
        }
        
        guard hexStr.characters.count == 6 || hexStr.characters.count == 8 else {
            return nil
        }
        
        var hex: UInt32 = 0
        NSScanner(string: hexStr).scanHexInt(&hex)
        
        if hexStr.characters.count == 6 {
            self.init(hexRGBValue: hex)
        } else {
            self.init(hexRGBAValue: hex)
        }
    }
    
    
    convenience init(hexRGBAValue rgbaValue: UInt32) {
        let r = CGFloat((rgbaValue >> 24) & 0xff)
        let g = CGFloat((rgbaValue >> 16) & 0xff)
        let b = CGFloat((rgbaValue >> 8) & 0xff)
        let a = CGFloat(rgbaValue & 0xff)
        
        self.init(red: (r / 255.0), green: (g / 255.0), blue: (b / 255.0), alpha: (a / 255.0))
    }
    
    
    /**
     通过RGB值实例化UIColor
     
     - parameter rgbValue: 十六进制RGB数值
     
     - returns: UIColor
     */
    convenience init(hexRGBValue rgbValue: UInt32) {
        let r = CGFloat((rgbValue >> 16) & 0xff)
        let g = CGFloat((rgbValue >> 8) & 0xff)
        let b = CGFloat(rgbValue & 0xff)
        
        self.init(red: (r / 255.0), green: (g / 255.0), blue: (b / 255.0), alpha: 1.0)
    }
}