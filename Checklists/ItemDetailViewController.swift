//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by Joshua Kuehn on 10/31/15.
//  Copyright © 2015 Joshua Kuehn. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(controller:ItemDetailViewController)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingitem item: ChecklistItem)
    func itemDetailViewController(controller:ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
}

class ItemDetailViewController:UITableViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    var itemToEdit:ChecklistItem?
    
    weak var delegate: AddItemViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.enabled = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        textField.becomeFirstResponder()
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    //MARK: IBActions
    
    @IBAction func cancel() {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        print("Contents of the text field: \(textField.text!)")
        
        if let item = itemToEdit {
            
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
            
        } else {
            let item = ChecklistItem()
            item.text = textField.text!
            item.checked = false
            
            delegate?.itemDetailViewController(self, didFinishAddingitem: item)
        }
        
    }
    
    //MARK: UITextFieldDelegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        //print("New Text: \(newText)")
        doneBarButton.enabled = (newText.length > 0)
        return true 
    }
    
}