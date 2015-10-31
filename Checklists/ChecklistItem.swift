//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Joshua Kuehn on 10/31/15.
//  Copyright © 2015 Joshua Kuehn. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}