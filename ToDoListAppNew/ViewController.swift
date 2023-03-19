//
//  ViewController.swift
//  ToDoListAppNew
//
//  Created by Gwinyai Nyatsoka on 21/2/2023.
//

import UIKit


//CRUD = Create Read Update and Delete

class Task {
    let title: String
    let description: String
    let category: Category
    var isComplete: Bool
    init(title: String, description: String, category: Category, isComplete: Bool = false) {
        self.title = title
        self.description = description
        self.category = category
        self.isComplete = isComplete
    }
    func toggleIsComplete() {
        isComplete = !isComplete
    }
}

protocol AddTaskDelegate: AnyObject {
    func add(task: Task)
}

protocol ViewControllerDelegate: AnyObject {
    func toggleIsComplete(forIndex index: Int)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var selectedIndex: Int = 0
    
    var tasks: [Task] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CreateTaskSegue" {
            let destinationVC = segue.destination as! AddTaskViewController
            destinationVC.delegate = self
        }
        else if segue.identifier == "TaskDetailSegue" {
            let destinationVC = segue.destination as! TaskDetailViewController
            let selectedTask = sender as! Task
            destinationVC.task = selectedTask
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "CreateTaskSegue", sender: nil)
    }
    
}

extension ViewController: AddTaskDelegate {
    
    func add(task: Task) {
        self.tasks.append(task)
        tableView.reloadData()
    }
    
}

extension ViewController: ViewControllerDelegate {
    
    func toggleIsComplete(forIndex index: Int) {
        let taskSelected = tasks[index]
        taskSelected.toggleIsComplete()
        tableView.reloadData()
    }
    
}

//MARK: - The datasource for our tasks
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        cell.titleLabel.text = task.title
        cell.categoryLabel.text = task.category.rawValue
        cell.delegate = self
        cell.index = indexPath.row
        if task.isComplete {
            cell.checkmarkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        } else {
            cell.checkmarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        return cell
    }
    
    //IndexPath IndexPath.section = 0 IndexPath.row = 0
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}

//MARK: - Change row height
extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskSelected = tasks[indexPath.row]
        performSegue(withIdentifier: "TaskDetailSegue", sender: taskSelected)
    }

}



