//
//  TaskDetailViewController.swift
//  ToDoListAppNew
//
//  Created by Gwinyai Nyatsoka on 17/3/2023.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var toggleTaskCompletionButton: UIButton!
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let task = task {
            titleLabel.text = task.title
            categoryLabel.text = task.category.rawValue
            descriptionLabel.text = task.description
            let toggleButtonTitle = task.isComplete ? "Mark Task Incomplete" : "Mark Task Complete"
            toggleTaskCompletionButton.setTitle(toggleButtonTitle, for: .normal)
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Confirm Delete", message: "Are you sure you want to delete this task?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            //delete the task
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @IBAction func toggleTaskCompletionButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func editTaskButtonTapped(_ sender: Any) {
    }
    

}
