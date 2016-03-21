//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by zhuangqiuxiong on 16/3/21.
//  Copyright © 2016年 zhuangqiuxiong. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class{
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController)
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingItem: Checklist)
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingItem: Checklist)
    
}

class ListDetailViewController: UITableViewController , UITextFieldDelegate {
    
    weak var delegate: ListDetailViewControllerDelegate?
    
    @IBOutlet weak var doneBarBtn: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    var checklistToEdit: Checklist?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textField.delegate = self
        
        if let item = checklistToEdit{
            self.navigationItem.title = "Edit Checklist"
            self.textField.text = item.name
            self.doneBarBtn.enabled = true
        }
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.textField .becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancel(sender: AnyObject) {
        
        self.delegate?.listDetailViewControllerDidCancel(self)
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func done(sender: AnyObject) {
        
        if let item = checklistToEdit{
            item.name = self.textField.text!
            self.delegate?.listDetailViewController(self, didFinishEditingItem: item)
            self.navigationController?.popViewControllerAnimated(true)
        }
            
        else
        {
            
            let item = Checklist(name: self.textField.text!)
            
            self.delegate?.listDetailViewController(self, didFinishAddingItem: item)
            self.navigationController?.popViewControllerAnimated(true)
            
        }
    }

    
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
