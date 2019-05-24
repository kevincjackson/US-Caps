//
//  ItemViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/22/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var progresLabel: UILabel!
    
    var worldStateController: WorldStateController!

}
//@IBOutlet weak var itemView: UIView!
//
//@IBOutlet weak var itemQuestionView: UIView!
//
//@IBOutlet weak var itemAnswerView: UIView!
//
//
//@IBOutlet weak var itemProgessBar: UIView!
//@IBOutlet weak var itemProgressLabel: UILabel!
//@IBOutlet weak var itemQuestionLabel: UILabel!
//@IBOutlet weak var itemAnswerLabel: UILabel!
//
//// More Item View
//@IBOutlet weak var progressView: UIProgressView!
//@IBOutlet weak var toolbar: UIToolbar!

//// MARK: - View Life Cycle
//override func viewDidLoad() {
//    super.viewDidLoad()
//
//
//    // Add swipes for changing current item.
//    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(itemViewSwipedLeft))
//    swipeLeft.direction = .left
//    itemView.addGestureRecognizer(swipeLeft)
//
//    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(itemViewSwipedRight))
//    swipeRight.direction = .right
//    itemView.addGestureRecognizer(swipeRight)
//}
//
//
//// MARK: - Helper Functions
//@objc func itemViewSwipedLeft() {
//    if studyCurrentIndex == studyData.count - 1 {
//        studyCurrentIndex = 0
//    } else {
//        studyCurrentIndex += 1
//    }
//}
//
//@objc func itemViewSwipedRight() {
//    if studyCurrentIndex == 0 {
//        studyCurrentIndex = studyData.count - 1
//    } else {
//        studyCurrentIndex -= 1
//    }
//}
//
//func updateItemView() {
//    let item = studyData[studyCurrentIndex]
//    let capital = studyData[studyCurrentIndex].capital
//    let state =  studyData[studyCurrentIndex].name
//
//    // Account for data reverse
//    let question = studyDataReverse ? capital : state
//    var answer = studyDataReverse ? state : capital
//
//    // Modify answer depending on hint mode
//    answer = "" // DESCRIBE
//
//    // Update question and answer
//    itemQuestionLabel.text = question
//    itemAnswerLabel.text = answer
//
//    // Update progress
//    itemProgressLabel.text = "\(studyCurrentIndex + 1) / \(studyData.count)"
//    progressView.progress = Float(studyCurrentIndex + 1) / Float(studyData.count)
//}

//@IBAction func itemViewTapped(_ sender: UITapGestureRecognizer) {
//    let item = studyData[studyCurrentIndex]
//    //        item.displayState = DisplayMode.next(state: item.displayState)
//    updateItemView()
//}
