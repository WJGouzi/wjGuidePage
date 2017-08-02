//
//  wjServerModel.swift
//  wjGuidePage
//
//  Created by gouzi on 2017/8/2.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjServerModel: NSObject {

    var serverName : String!
    var serverIP : String!
    
    func wjServerModelWithDict(_ dict : [String : String]) -> wjServerModel {
        let model = wjServerModel()
        model.setValuesForKeys(dict)
        return model
    }
}
