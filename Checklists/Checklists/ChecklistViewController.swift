//
//  ViewController.swift
//  Checklists
//
//  Created by zhuangqiuxiong on 16/3/15.
//  Copyright © 2016年 zhuangqiuxiong. All rights reserved.
//

import UIKit


class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {

    var checklist : Checklist!
    
    required init?(coder aDecoder: NSCoder) {
                
        super.init(coder: aDecoder)
        
//        self.loadChecklistItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = self.checklist.name
        
//        print(self.dataFilePath())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.checklist.items.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        let item = self.checklist.items[indexPath.row]
            
        label.text = item.text
        
        let checklabel = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            checklabel.text = "√"
        }else{
            checklabel.text = ""
        }
        
        return cell
        
    }
    
    //MARK: Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
        if let cell = tableView.cellForRowAtIndexPath(indexPath){
            
            let item = self.checklist.items[indexPath.row]
            item.checked = !item.checked
            
            let checklabel = cell.viewWithTag(1001) as! UILabel
            if item.checked {
                checklabel.text = "√"
            }else{
                checklabel.text = ""
            }
            
        }
            
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
//        self.saveChecklistItems()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        self.checklist.items.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
//        self.saveChecklistItems()
    }
    
    //MARK: ItemDetailViewControllerDelegate
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    {
        
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem newItem: ChecklistItem)
    {
        let newRowIndex = self.checklist.items.count
        
        self.checklist.items.append(newItem)
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
//        self.saveChecklistItems()
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem editItem: ChecklistItem)
    {
//        self.tableView.reloadData()
        if let index = self.checklist.items.indexOf(editItem){
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = self.tableView.cellForRowAtIndexPath(indexPath) {
                
                let label = cell.viewWithTag(1000) as! UILabel
                label.text = editItem.text
            }
        }
//        self.saveChecklistItems()
    }
    
    
    //MARK: Storyboard
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "Add Item"{
            
            let newController = segue.destinationViewController as! ItemDetailViewController
            newController.delegate = self
        }
        
        else if segue.identifier == "Edit Item"{
            let newController = segue.destinationViewController as! ItemDetailViewController
            newController.delegate = self
            
            if let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell)
            {
                newController.itemToEdit = self.checklist.items[indexPath.row]
            }
            
        }
        
        
    }
    


}

