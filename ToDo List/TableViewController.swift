import UIKit

class TableViewController: UITableViewController {
    
    let taskModel = TaskModel()
    
    var tasks: [Task] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addTaskButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New task", message: "Please add task", preferredStyle: .alert)
        
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Submit", style: .cancel) { _ in
            guard let tf = alert.textFields?.first, let title = tf.text, !title.isEmpty else {return}
            self.tasks = self.taskModel.createTask(title: title)
        }
        
        alert.addAction(submitButton)
        
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tasks = self.taskModel.getAllTasks()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let task = tasks[indexPath.row]
        
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        let editButton = UIAlertAction(title: "Edit", style: .default) { _ in
            let alert = UIAlertController(title: "Edit task", message: "Edit your task", preferredStyle: .alert)
            
            alert.addTextField()
            alert.textFields?.first?.text = task.title
            
            let editButton = UIAlertAction(title: "Save", style: .cancel) { _ in
                guard let tf = alert.textFields?.first, let newTitle = tf.text, !newTitle.isEmpty else {return}
                self.tasks = self.taskModel.updateTask(task: task, newTitle: newTitle)
            }
            
            alert.addAction(editButton)
            
            self.present(alert, animated: true)
        }
        let deleteButton = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.tasks = self.taskModel.deleteTask(task: task)
        }
        
        sheet.addAction(cancelButton)
        sheet.addAction(editButton)
        sheet.addAction(deleteButton)
        
        present(sheet, animated: true)
    }
}
