//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by zhuangqiuxiong on 16/3/15.
//  Copyright © 2016年 zhuangqiuxiong. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class{
    
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem: ChecklistItem)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem: ChecklistItem)
    
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    weak var delegate: ItemDetailViewControllerDelegate?
    
    @IBOutlet weak var doneBarBtn: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    var itemToEdit: ChecklistItem?
    
    override func viewDidLoad() {
        self.textField.delegate = self
        
        if let item = itemToEdit{
            self.navigationItem.title = "Edit Item"
            self.textField.text = item.text
            self.doneBarBtn.enabled = true
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.textField .becomeFirstResponder()
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        
        self.delegate?.itemDetailViewControllerDidCancel(self)
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func done(sender: AnyObject) {
        
        if let item = itemToEdit{
            item.text = self.textField.text!
            self.delegate?.itemDetailViewController(self, didFinishEditingItem: item)
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        else
        {
            
            let item = ChecklistItem()
            item.text = self.textField.text!
            item.checked = false
            
            self.delegate?.itemDetailViewController(self, didFinishAddingItem: item)
            self.navigationController?.popViewControllerAnimated(true)

        }
    }
    
    //MARK: Table view Delegate
    //“Return Value: An index-path object that confirms or alters the selected row. Return an NSIndexPath object other than indexPath if you want another cell to be selected. Return nil if you don't want the row selected.”
    
    //1. Return the same index-path you were given. This confirms that this row can be selected.
    //2. Return another index-path in order to select another row.
    //3. Return nil to prevent the row from being selected, which is what you did.
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil//prevent any row to be selected
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let oldText : NSString = textField.text!
        let newText : NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        if newText.length > 0{
            self.doneBarBtn.enabled = true
        }
        else{
            self.doneBarBtn.enabled = false
        }
        return true
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }

}
