//
//  AddItemViewController.swift
//  Checklists
//
//  Created by zhuangqiuxiong on 16/3/15.
//  Copyright © 2016年 zhuangqiuxiong. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.textField .becomeFirstResponder()
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func done(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: Delegate
    //“Return Value: An index-path object that confirms or alters the selected row. Return an NSIndexPath object other than indexPath if you want another cell to be selected. Return nil if you don't want the row selected.”
    
    //1. Return the same index-path you were given. This confirms that this row can be selected.
    //2. Return another index-path in order to select another row.
    //3. Return nil to prevent the row from being selected, which is what you did.
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil//prevent any row to be selected
    }
    

}
