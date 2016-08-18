//
//  SGSTdtWMSLayer.swift
//  imapMobile
//
//  Created by Lee on 16/5/30.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit

class SGSTdtWMSLayer: AGSWMSLayer {
    override func layerDidLoad() {
        super.layerDidLoad()
        
        self.setValue([4326, 900913], forKey: "supportedWKIDS")
    }
}
