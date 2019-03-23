//
//  ViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 3/6/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class StudyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - View Outlets
    @IBOutlet weak var dataFilterButton: UIBarButtonItem!
    @IBOutlet weak var displayModeButton: UIBarButtonItem!
    @IBOutlet weak var itemModeButton: UIBarButtonItem!
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var itemQuestionLabel: UILabel!
    @IBOutlet weak var itemAnswerLabel: UILabel!
    @IBOutlet weak var listView: UITableView!
    @IBOutlet weak var progressLabel: UILabel!
    

    // MARK: - Controllers
    var studyCurrentIndex = 0 {
        didSet {
            updateProgressBar()
            updateItemView()
        }
    }
    var studyData = States.all
    var studyDataFilter: StateFilter = .all {
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
        listView.isHidden = false
        itemView.isHidden = true
        itemModeButton.title = "Item"
    }
    
    
    // MARK: - Functions
    func updateItemView() {
        let item = studyData[studyCurrentIndex]
        let capital = studyData[studyCurrentIndex].capital
        let state =  studyData[studyCurrentIndex].name
        
        // Account for data reverse
        let question = studyDataReverse ? capital : state
        var answer = studyDataReverse ? state : capital
        
        // Modify answer depending on hint mode
        answer = DisplayState.describe(answer: answer, mode: item.displayState)
        
        // Update view
        itemQuestionLabel.text = question
        itemAnswerLabel.text = answer
    }
    
    func updateProgressBar() {
        progressLabel.text = "\(studyCurrentIndex + 1) / \(studyData.count)"
    }
    
    
    // MARK: - Actions
    @IBAction func dataFilterButtonPressed(_ sender: UIBarButtonItem) {
        
        // Create alert
        let alert = UIAlertController(title: "Filter", message: "Choose which states and capitals to show.", preferredStyle: .actionSheet)

        // Add actions
        alert.addAction(UIAlertAction(title: "All", style: .default) { (action) in
            self.studyDataFilter = .all
            self.dataFilterButton.title = "All"
            self.listView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Midwest", style: .default) { (action) in
            self.studyDataFilter = .midwest
            self.dataFilterButton.title = "Midwest"
            self.listView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Northeast", style: .default) { (action) in
            self.studyDataFilter = .northeast
            self.dataFilterButton.title = "Northeast"
            self.listView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Southwest", style: .default) { (action) in
            self.studyDataFilter = .southwest
            self.dataFilterButton.title = "Southwest"
            self.listView.reloadData()
        })

        alert.addAction(UIAlertAction(title: "Southeast", style: .default) { (action) in
            self.studyDataFilter = .southeast
            self.dataFilterButton.title = "Southeast"
            self.listView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "West", style: .default) { (action) in
            self.studyDataFilter = .west
            self.dataFilterButton.title = "West"
            self.listView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func displayModeButtonPressed(_ sender: UIBarButtonItem) {

        switch studyDisplayMode {
        case .show:
            studyDisplayMode = .hide
            for item in studyData {
                item.displayState = .hide
            }
            displayModeButton.title = "Hint"
        case .hint:
            studyDisplayMode = .show
            for item in studyData {
                item.displayState = .show
            }
            displayModeButton.title = "Hide"
        case .hide:
            studyDisplayMode = .hint
            for item in studyData {
                item.displayState = .hint
            }
            displayModeButton.title = "Show"
        }
        
        updateItemView()
        self.listView.reloadData()
    }
    
    @IBAction func dataReverseButtonPressed(_ sender: UIBarButtonItem) {
        studyDataReverse = !studyDataReverse
        listView.reloadData()
    }

    @IBAction func itemModeButtonPressed(_ sender: UIBarButtonItem) {
        itemView.isHidden = !itemView.isHidden
        listView.isHidden = !itemView.isHidden
        itemModeButton.title = itemView.isHidden ? "Item" : "List"
    }
    
    
    // MARK: - Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
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
        updateProgressBar()
    }
        
}
