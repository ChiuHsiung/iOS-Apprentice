//
//  ChecklistItem.swift
//  Checklists
//
//  Created by zhuangqiuxiong on 16/3/15.
//  Copyright © 2016年 zhuangqiuxiong. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
    
    var text : String
    var checked : Bool
    
    //这是为了初始化方便，因为超类中的init()方法并没有规定为required
    override init() {
        
        self.text = ""
        self.checked = false
        
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.text = aDecoder.decodeObjectForKey("Text") as! String
        self.checked = aDecoder.decodeBoolForKey("Checked")
        
        super.init()
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(self.text, forKey: "Text")
        aCoder.encodeBool(self.checked, forKey: "Checked")
        
    }
    
    
}