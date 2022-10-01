//
//  HelpersTexts.swift
//  ToDoApp
//
//  Created by Proteco on 30/09/22.
//

import Foundation
import UIKit

func validateText(text : String) -> Bool{
    if (text.trimmingCharacters(in: .whitespaces).isEmpty){
        return false
    }
    else{
        return true
    }
}

func userMessage(alertTitle : String, message : String, actionTitle : String, vc : UIViewController) {
    let userAlert = UIAlertController.init(title: alertTitle, message: message, preferredStyle: .alert)
    userAlert.addAction(UIAlertAction.init(title: actionTitle, style: .default))
    vc.present(userAlert, animated: true)
}
