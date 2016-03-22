//
//  DataModel.swift
//  Checklists
//
//  Created by zhuangqiuxiong on 16/3/21.
//  Copyright © 2016年 zhuangqiuxiong. All rights reserved.
//

import UIKit

let ChecklistIndexKey = "ChecklistIndex"
let FirstTimeKey = "FirstTime"

class DataModel: NSObject {
    
    var lists = [Checklist]()
    
    override init()
    {
        super.init()
        self.loadChecklists()
        
        //注册出厂设置
        self.registerDefaults()
        
        //第一次运行处理
        self.handleFirstTime()
        
    }
    
    //MARK: Utility
    func documentsDirectory() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
        
    }
    
    func dataFilePath() -> String {
        
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("Checklists.plist")
        
    }
    
    //MARK: Sava data
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(self.lists, forKey: "Checklists")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    //MARK: Load data
    func loadChecklists() {
        // 1
        let path = dataFilePath()
        // 2
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            // 3
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                self.lists = unarchiver.decodeObjectForKey("Checklists") as! [Checklist]
                unarchiver.finishDecoding()
            }
        }
    }
    
    //MARK: 注册出厂设置
    func registerDefaults() {
        
        let dictionary = [ ChecklistIndexKey: -1, FirstTimeKey: true]
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
        
    }
    
    func handleFirstTime()
    {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let firstTime = userDefaults.boolForKey(FirstTimeKey)
        if firstTime
        {
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            NSUserDefaults.standardUserDefaults().setInteger(0, forKey: ChecklistIndexKey)
            userDefaults.setBool(false, forKey: FirstTimeKey)
            userDefaults.synchronize()
        }
    }

}
