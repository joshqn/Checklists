//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by Joshua Kuehn on 11/3/15.
//  Copyright © 2015 Joshua Kuehn. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class {
    func listDetailViewControllerDidCancel(controller: ListDetailViewController)
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist)
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: ListDetailViewControllerDelegate?
    
    var checklistToEdit: Checklist?
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let checklist = checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklist.name
            doneBarButton.enabled = true
        }
    }
    
    //MARK: UITextFieldDelegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText:NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        doneBarButton.enabled = (newText.length > 0)
        return true 
    }
    
    //MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    //MARK: IBActions
    
    @IBAction func cancel() {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let checklist = checklistToEdit {
            checklist.name = textField.text!
            delegate?.listDetailViewController(self, didFinishEditingChecklist: checklist)
        } else {
            let checklist = Checklist(name: textField.text!)
            delegate?.listDetailViewController(self, didFinishAddingChecklist: checklist)
        }
    }
    
}