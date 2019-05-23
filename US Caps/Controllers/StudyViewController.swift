//
//  ViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 3/6/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class StudyViewController: UIViewController {

    // MARK: - View Outlets
    @IBOutlet weak var dataFilterButton: UIBarButtonItem!
    @IBOutlet weak var displayModeButton: UIBarButtonItem!
    @IBOutlet weak var itemModeButton: UIBarButtonItem!
    
    
    // MARK - Item View
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var itemQuestionView: UIView!
    @IBOutlet weak var itemAnswerView: UIView!
    @IBOutlet weak var itemProgessBar: UIView!
    @IBOutlet weak var itemProgressLabel: UILabel!
    @IBOutlet weak var itemQuestionLabel: UILabel!
    @IBOutlet weak var itemAnswerLabel: UILabel!
    @IBOutlet weak var listView: UITableView!
    // More Item View
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    
    // MARK: - Controllers
    var studyCurrentIndex = 0 {
        didSet {
            updateItemView()
        }
    }
    var studyData = States.all
    var studyDataFilter: State.Filter = .all {
        didSet {
            if studyDataFilter == .all {
                studyData = States.all
            } else {
                studyData = States.all.filter { $0.region == studyDataFilter }
            }
            studyCurrentIndex = 0
        }
    }
    var studyDataReverse = false {
        didSet {
            updateItemView()
        }
    }
    var studyDisplayMode: DisplayState.Mode = .show {
        didSet {
            updateItemView()
        }
    }
    var studyItemMode = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // List / Table View
        listView.isHidden = false
        listView.rowHeight = 100
        
        // Item View
        itemView.isHidden = true
        itemModeButton.title = "Item"
        
        // Add swipes for changing current item.
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(itemViewSwipedLeft))
        swipeLeft.direction = .left
        itemView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(itemViewSwipedRight))
        swipeRight.direction = .right
        itemView.addGestureRecognizer(swipeRight)
    }
    
    
    // MARK: - Helper Functions
    @objc func itemViewSwipedLeft() {
        if studyCurrentIndex == studyData.count - 1 {
            studyCurrentIndex = 0
        } else {
            studyCurrentIndex += 1
        }
    }
    
    @objc func itemViewSwipedRight() {
        if studyCurrentIndex == 0 {
            studyCurrentIndex = studyData.count - 1
        } else {
            studyCurrentIndex -= 1
        }
    }
    
    func updateItemView() {
        let item = studyData[studyCurrentIndex]
        let capital = studyData[studyCurrentIndex].capital
        let state =  studyData[studyCurrentIndex].name
        
        // Account for data reverse
        let question = studyDataReverse ? capital : state
        var answer = studyDataReverse ? state : capital
        
        // Modify answer depending on hint mode
        answer = DisplayState.describe(answer: answer, mode: item.displayState)
        
        // Update question and answer
        itemQuestionLabel.text = question
        itemAnswerLabel.text = answer
        
        // Update progress
        itemProgressLabel.text = "\(studyCurrentIndex + 1) / \(studyData.count)"
        progressView.progress = Float(studyCurrentIndex + 1) / Float(studyData.count)
    }

    // MARK: - Actions
    @IBAction func dataFilterButtonPressed(_ sender: UIBarButtonItem) {
        
        // Create alert
        let alert = UIAlertController(title: "Filter", message: "Choose which states and capitals to show.", preferredStyle: .actionSheet)

        // Add State Filter actions
        State.Filter.allCases.forEach { (stateFilter) in
            alert.addAction(UIAlertAction(
                title: "\(stateFilter)".capitalized,
                style: .default,
                handler: { (action) in
                    self.studyDataFilter = stateFilter
                    self.dataFilterButton.title = "\(stateFilter)".capitalized
                    self.listView.reloadData()
            }))
        }

        // Add Cancel
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Show it
        self.present(alert, animated: true)
    }
    
    @IBAction func dataReverseButtonPressed(_ sender: UIBarButtonItem) {
        studyDataReverse = !studyDataReverse
        listView.reloadData()
    }

    @IBAction func displayModeButtonPressed(_ sender: UIBarButtonItem) {

        switch studyDisplayMode {
        case .show:
            studyDisplayMode = .hide
            studyData.forEach { $0.displayState = .hide }
            displayModeButton.title = "Hint"
        case .hint:
            studyDisplayMode = .show
            studyData.forEach { $0.displayState = .show }
            displayModeButton.title = "Hide"
        case .hide:
            studyDisplayMode = .hint
            studyData.forEach { $0.displayState = .hint }
            displayModeButton.title = "Show"
        }
        
        updateItemView()
        listView.reloadData()
    }
    
    @IBAction func itemModeButtonPressed(_ sender: UIBarButtonItem) {
        itemView.isHidden = !itemView.isHidden
        listView.isHidden = !itemView.isHidden
        itemModeButton.title = itemView.isHidden ? "Item" : "List"
        
        // Update views
        updateItemView()
        listView.reloadData()
    }
    
    @IBAction func itemViewTapped(_ sender: UITapGestureRecognizer) {
        let item = studyData[studyCurrentIndex]
        item.displayState = DisplayState.next(state: item.displayState)
        updateItemView()
    }
}

// MARK: - TableView
extension StudyViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let labelText = studyDataReverse ? studyData[indexPath.row].capital : studyData[indexPath.row].name
        let detailText = studyDataReverse ? studyData[indexPath.row].name : studyData[indexPath.row].capital
        
        // Set label
        cell.textLabel?.text = labelText
        
        // Set detail
        cell.detailTextLabel?.text = DisplayState.describe(answer: detailText, mode: studyData[indexPath.row].displayState)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Update controllers
        studyCurrentIndex = indexPath.row
        
        // Update item display state
        let item = studyData[studyCurrentIndex]
        item.displayState = DisplayState.next(state: item.displayState)
        
        // Update Views
        self.listView.reloadData()
    }
}
