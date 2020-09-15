//
//  CreateGoalVC.swift
//  GoalPost
//
//  Created by Rares Man on 09.09.2020.
//  Copyright © 2020 Rares Man. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var GoalTextView: UITextView!
    @IBOutlet weak var LongTermBtn: UIButton!
    @IBOutlet weak var ShortTermBtn: UIButton!
    @IBOutlet weak var NextBtn: UIButton!
    
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NextBtn.bindToKeyboard()
        ShortTermBtn.setSelectedColor()
        LongTermBtn.setDeselectedColor()
        GoalTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func longBtnWasPressed(_ sender: Any) {
        goalType = .longTerm
        ShortTermBtn.setDeselectedColor()
        LongTermBtn.setSelectedColor()
    }
    
    
    @IBAction func shortBtnWasPressed(_ sender: Any) {
        goalType = .shortTerm
        ShortTermBtn.setSelectedColor()
        LongTermBtn.setDeselectedColor()
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        if GoalTextView.text != "" && GoalTextView.text != "What is your goal?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(identifier: "FinishGoalVC") as? FinishGoalVC else { return }
            finishGoalVC.initData(description: GoalTextView.text!, type: goalType)
            presentingViewController?.presentSecondaryDetail(finishGoalVC)
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        GoalTextView.text = ""
        GoalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
}
