//
//  Task.swift
//  ToDoListAppNew
//
//  Created by Gwinyai Nyatsoka on 4/4/2023.
//

import Foundation
import RealmSwift

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

class LocalTask: Object {
    @Persisted var taskTitle: String = ""
    @Persisted var taskDescription: String = ""
    @Persisted var category: String = ""
    @Persisted var isComplete: Bool = false
}
