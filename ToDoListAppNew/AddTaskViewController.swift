//
//  AddTaskViewController.swift
//  ToDoListAppNew
//
//  Created by Gwinyai Nyatsoka on 10/3/2023.
//

import UIKit

// work gym hobby



class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate: AddTaskDelegate?
    var task: Task?
    var index: Int?

    lazy var categories: [Category] = {
        return Category.allCases
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isScrollEnabled = false
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self
        if let task = task {
            titleLabel.text = "Edit Task"
            titleTextField.text = task.title
            descriptionTextView.text = task.description
            let taskCategory = task.category
            var row = categories.firstIndex { queryCategory in
                queryCategory == taskCategory
            }
            if let row = row {
                categoryPickerView.selectRow(row, inComponent: 0, animated: false)
            }
        }
    }
    

    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text else {
            return
        }
        guard let description = descriptionTextView.text else {
            return
        }
        let selectedPickerviewRow = categoryPickerView.selectedRow(inComponent: 0)
        let selectedCategory = categories[selectedPickerviewRow]
        let newTask = Task(title: title, description: description, category: selectedCategory)
        
        if let _ = task,
            let index = index {
            NotificationCenter.default.post(name: NSNotification.Name("com.fullstacktuts.updateTask"), object: nil, userInfo: ["index": index, "task": newTask])
        } else {
            delegate?.add(task: newTask)
        }
    
        dismiss(animated: true)
    }
    

}

extension AddTaskViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
}

extension AddTaskViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titleOfCategory = categories[row]
        return titleOfCategory.rawValue
    }
    
}
