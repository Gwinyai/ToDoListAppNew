//
//  AddTaskViewController.swift
//  ToDoListAppNew
//
//  Created by Gwinyai Nyatsoka on 10/3/2023.
//

import UIKit
import RealmSwift

// work gym hobby

//implicit animations

    //UIView.animate
    //Property Animators

//explicit animations

    //CABasicAnimation
    //CAKeyFrameAnimation


//interpolation

//duration

//timimg function = linear, easeIn, easeOut, easeInOut

//spring

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var modalView: UIView!
    weak var delegate: AddTaskDelegate?
    var task: Task?
    var index: Int?

    lazy var categories: [Category] = {
        return Category.allCases
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        modalView.layer.cornerRadius = 6
        titleTextField.layer.borderWidth = 0.5
        titleTextField.layer.borderColor = UIColor.lightGray.cgColor
        titleTextField.layer.cornerRadius = 6
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.cornerRadius = 6
        submitButton.layer.cornerRadius = submitButton.frame.height / 2
        
        modalView.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        UIView.animate(withDuration: 0.45, delay: 0) {
//            self.modalView.transform = CGAffineTransform(scaleX: 1, y: 1)
//        }
        
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 2, options: [.curveEaseOut]) {
            self.modalView.transform = CGAffineTransform(scaleX: 1, y: 1)
        } completion: { success in
            
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
        
        /*
         Saving task to Realm
         */
        
        let realm = try! Realm()
        let localTask = LocalTask()
        localTask.taskTitle = title
        localTask.taskDescription = description
        localTask.category = selectedCategory.rawValue
        
        try! realm.write({
            realm.add(localTask)
        })
        
        if let _ = task,
            let index = index {
            NotificationCenter.default.post(name: NSNotification.Name("com.fullstacktuts.updateTask"), object: nil, userInfo: ["index": index, "task": newTask])
        } else {
            delegate?.add(task: newTask)
        }
    
        dismiss(animated: true)
    }
    
    @IBAction func dismissAddTask(_ sender: Any) {
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
