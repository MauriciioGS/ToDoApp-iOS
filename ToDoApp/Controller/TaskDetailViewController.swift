//
//  TaskDetailViewController.swift
//  ToDoApp
//
//  Created by Proteco on 23/09/22.
//

import UIKit

class TaskDetailViewController: UITableViewController {
    
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var taskDatePicker: UIDatePicker!
    @IBOutlet weak var taskNotes: UITextView!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    var task: Task?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if task != nil {
            taskName.text = task?.name
            taskDatePicker.date = (task?.date)!
            taskNotes.text = task?.notes
        } else {
            task = Task(context: self.context)
            task!.id_task = UUID()
            taskName.text = ""
        }
        
        //setUpTextFields()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ToDoListViewController
        task?.name = taskName.text
        task?.notes = taskNotes.text
        task?.date = taskDatePicker.date
        if ((task?.id_task?.uuidString.isEmpty) != nil){
            task?.id_task = UUID()
        }
        destination.currentTask = task
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var perform = false
        if validateText(text: taskName.text!){
            perform = true
        }else{
            userMessage(alertTitle: NSLocalizedString("alert", comment: ""),
                        message: NSLocalizedString("messageAlert", comment: ""),
                        actionTitle: NSLocalizedString("okAction", comment: ""),
                        vc: self)
        }
        return perform
    }
    
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        let isModal = self.presentingViewController is UINavigationController
        if isModal{
            self.dismiss(animated: true)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    //Este Método agrega un botón al teclado para mostrar el botón
    // "Listo" para realizar el "dismiss" del teclado para que
    // no se mantenga en pantalla, la llamamos en viewDidLoad
    func setUpTextFields() {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: NSLocalizedString("doneBtn", comment: ""), style: .done, target: self, action: #selector(doneButtonTapped) )
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        taskName.inputAccessoryView = toolbar
        taskNotes.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }

    
}
