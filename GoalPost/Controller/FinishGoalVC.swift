//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by Rares Man on 09.09.2020.
//  Copyright © 2020 Rares Man. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var CreateGoalBtn: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    var GoalDescription: String!
    var GoalType: GoalType!
    
    func initData(description: String, type: GoalType) {
        self.GoalDescription = description
        self.GoalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CreateGoalBtn.bindToKeyboard()
        pointsTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        //Pass data into Core Data Goal Model
        if pointsTextField.text != "" {
            self.save { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func save(completion: (_ finished: Bool) ->()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = GoalDescription
        goal.goalType = GoalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            print("Successfully saved data")
            try managedContext.save()
            completion(true)
        }
        catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }
    
}
