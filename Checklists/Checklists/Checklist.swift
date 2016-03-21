//
//  Checklist.swift
//  Checklists
//
//  Created by zhuangqiuxiong on 16/3/21.
//  Copyright © 2016年 zhuangqiuxiong. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
    
    var name : String
    var items : [ChecklistItem] = [ChecklistItem]()
    
    init(name: String)
    {
        self.name = name
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.name = aDecoder.decodeObjectForKey("Name") as! String
        self.items = aDecoder.decodeObjectForKey("Items") as! [ChecklistItem]
        
        super.init()
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(self.name, forKey: "Name")
        aCoder.encodeObject(self.items, forKey: "Items")
        
    }

}
