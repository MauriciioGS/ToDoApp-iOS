//
//  ToDoListViewController.swift
//  ToDoApp
//
//  Created by Proteco on 23/09/22.
//

import UIKit

class ToDoListViewController: UIViewController,
                              UITableViewDataSource,
                              UITableViewDelegate
{
    
    @IBOutlet weak var toDoListTableView: UITableView!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    @IBOutlet weak var editTask: UIBarButtonItem!
    
    var tasks : [Task] = []
    var currentTask : Task?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoListTableView.delegate = self
        toDoListTableView.dataSource = self
        
        let dataManager = TaskDataManager(context: context)
        tasks = dataManager.fetch()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toDoTaskCell = tableView.dequeueReusableCell(withIdentifier: "toDoTaskCell", for: indexPath) as! TaskViewCell
        toDoTaskCell.setup(with: tasks[indexPath.row])
        return toDoTaskCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "taskDetailSegue", sender: Self.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskDetailSegue" {
            let destination = segue.destination as! TaskDetailViewController
            let selectedIndexPath = toDoListTableView.indexPathForSelectedRow!
            destination.task = tasks[selectedIndexPath.row]
        }
    }
    
    @IBAction  func unWindFromDetail(segue: UIStoryboardSegue ){
        let source = segue.source as! TaskDetailViewController
        currentTask = source.task
        do{
            try context.save()
        }
        catch{
            print("error al salvar",error)
        }
        
        let dataManager = TaskDataManager(context: context)
        tasks = dataManager.fetch()
        self.toDoListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedTaskTmp = tasks[sourceIndexPath.item]
        tasks.remove(at: sourceIndexPath.item)
        tasks.insert(movedTaskTmp, at: destinationIndexPath.item)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //si el renglon seleccinado esta en modo de eliminacion
        if editingStyle == .delete{
            //guardamo la tarea seleccionada en la variable "currentTask"
            currentTask = self.tasks[indexPath.row]
            //eliminamos la tarea
            self.context.delete(currentTask!)
            //actualizamos el contexto utilizando el método save
            do{
                try self.context.save()
            }
            catch{
                print("Error: ", error)
            }
            let dataManager = TaskDataManager(context: context)
            //si todo fue bien recuperamos el listado de tareas actualizado
            tasks = dataManager.fetch()
            self.toDoListTableView.reloadData()
        }
    }
    
    
    @IBAction func editTasksPressed(_ sender: UIBarButtonItem) {
        if toDoListTableView.isEditing{
            toDoListTableView.setEditing(false, animated: true)
            sender.title = NSLocalizedString("editBtn", comment: "")
            addBtn.isEnabled = true
        }
        else {
            toDoListTableView.setEditing(true, animated: true)
            sender.title = NSLocalizedString("doneBtn", comment: "")
            addBtn.isEnabled = false
        }
    }
    
}
