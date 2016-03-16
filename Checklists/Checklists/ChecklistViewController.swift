//
//  ViewController.swift
//  Checklists
//
//  Created by zhuangqiuxiong on 16/3/15.
//  Copyright © 2016年 zhuangqiuxiong. All rights reserved.
//

import UIKit


class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {

    var items: [ChecklistItem]
    
    required init?(coder aDecoder: NSCoder) {
        
        self.items = [ChecklistItem]()
        
        let row0item = ChecklistItem()
        row0item.text = "Walk the dog"
        row0item.checked = false
        items.append(row0item)
        
        let row1item = ChecklistItem()
        row1item.text = "Brush my teeth"
        row1item.checked = true
        items.append(row1item)
        
        let row2item = ChecklistItem()
        row2item.text = "Learn iOS development"
        row2item.checked = true
        items.append(row2item)
        
        let row3item = ChecklistItem()
        row3item.text = "Soccer practice"
        row3item.checked = false
        items.append(row3item)
        
        let row4item = ChecklistItem()
        row4item.text = "Eat ice cream"
        row4item.checked = true
        items.append(row4item)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        let item = self.items[indexPath.row]
            
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
            
            let item = self.items[indexPath.row]
            item.checked = !item.checked
            
            let checklabel = cell.viewWithTag(1001) as! UILabel
            if item.checked {
                checklabel.text = "√"
            }else{
                checklabel.text = ""
            }
            
        }
            
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        self.items.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
    }
    
    //MARK: ItemDetailViewControllerDelegate
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    {
        
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem newItem: ChecklistItem)
    {
        let newRowIndex = self.items.count
        
        self.items.append(newItem)
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem editItem: ChecklistItem)
    {
//        self.tableView.reloadData()
        if let index = self.items.indexOf(editItem){
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = self.tableView.cellForRowAtIndexPath(indexPath) {
                
                let label = cell.viewWithTag(1000) as! UILabel
                label.text = editItem.text
            }
        }
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
                newController.itemToEdit = self.items[indexPath.row]
            }
            
        }
        
        
    }

}

