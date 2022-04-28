import Foundation
import CoreData
import UIKit

class TaskModel {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllTasks() -> [Task] {
        do {
            return try context.fetch(Task.fetchRequest())
        }
        catch {
            return []
        }
    }
    
    func createTask(title: String) -> [Task] {
        let task = Task(context: context)
        task.title = title
        
        do {
            try context.save()
            return getAllTasks()
        }
        catch {
            return []
        }
    }
    
    func deleteTask(task: Task) -> [Task] {
        context.delete(task)
        
        do {
            try context.save()
            return getAllTasks()
        }
        catch {
            return []
        }
    }
    
    func updateTask(task: Task, newTitle: String) -> [Task] {
        task.title = newTitle
        
        do {
            try context.save()
            return getAllTasks()
        }
        catch {
            return []
        }
    }
}

