//
//  TaskTableViewCell.swift
//  ToDoListAppNew
//
//  Created by Gwinyai Nyatsoka on 21/2/2023.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var checkmarkButton: UIButton!
    weak var delegate: ViewControllerDelegate?
    var index = 0
    
    @IBAction func checkmarkButtonTapped(_ sender: Any) {
        delegate?.toggleIsComplete(forIndex: index)
    }
    
}



