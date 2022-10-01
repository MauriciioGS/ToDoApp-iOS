//
//  TaskViewCell.swift
//  ToDoApp
//
//  Created by Proteco on 24/09/22.
//

import UIKit

class TaskViewCell: UITableViewCell {

    @IBOutlet weak var titleTaskLabel: UILabel!
    var taskUUID: String?
    var taskTitle: String?
    var taskDate: Date?
    var taskNotes: String?
    
    func setup(with task: Task){
        taskUUID = task.id_task?.description
        taskTitle = task.name
        taskDate = task.date
        taskNotes = task.notes
        titleTaskLabel.text = taskTitle
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
