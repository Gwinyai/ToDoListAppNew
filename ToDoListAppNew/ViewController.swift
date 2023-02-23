//
//  ViewController.swift
//  ToDoListAppNew
//
//  Created by Gwinyai Nyatsoka on 21/2/2023.
//

import UIKit


//CRUD = Create Read Update and Delete

struct Task {
    let title: String
    let category: String
    let isComplete: Bool
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let tasks: [Task] = [
        Task(title: "Walk the Dog", category: "Hobby", isComplete: false),
        Task(title: "Go fishing", category: "Leisure", isComplete: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        cell.titleLabel.text = task.title
        cell.categoryLabel.text = task.category
        if task.isComplete {
            cell.checkmarkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        } else {
            cell.checkmarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    

}



