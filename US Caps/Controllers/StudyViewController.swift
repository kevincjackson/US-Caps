//
//  ViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 3/6/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class StudyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listAnswerDisplayState: AnswerDisplayState = .show
    var studyData = States.all
    var studyDataReverse = false
    
    @IBOutlet weak var studyTableView: UITableView!
    @IBOutlet weak var showButton: UIBarButtonItem!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - Actions
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        
        // Create alert
        let alert = UIAlertController(title: "Filter", message: "Choose which states and capitals to show.", preferredStyle: .actionSheet)

        // Add actions
        alert.addAction(UIAlertAction(title: "All", style: .default) { (action) in
            self.studyData = States.all
            self.filterButton.title = "All"
            self.studyTableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Midwest", style: .default) { (action) in
            self.studyData = States.all.filter { $0.region == StateFilter.midwest }
            self.filterButton.title = "Midwest"
            self.studyTableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Northeast", style: .default) { (action) in
            self.studyData = States.all.filter { $0.region == StateFilter.northeast }
            self.filterButton.title = "Northeast"
            self.studyTableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Southwest", style: .default) { (action) in
            self.studyData = States.all.filter { $0.region == StateFilter.southwest }
            self.filterButton.title = "Southwest"
            self.studyTableView.reloadData()
        })

        alert.addAction(UIAlertAction(title: "Southeast", style: .default) { (action) in
            self.studyData = States.all.filter { $0.region == StateFilter.southeast }
            self.filterButton.title = "Southeast"
            self.studyTableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "West", style: .default) { (action) in
            self.studyData = States.all.filter { $0.region == StateFilter.west }
            self.filterButton.title = "West"
            self.studyTableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func switchButtonPressed(_ sender: UIBarButtonItem) {
        studyDataReverse = !studyDataReverse
        studyTableView.reloadData()
    }
    
    @IBAction func formatButtonPressed(_ sender: UIBarButtonItem) {
        print("formatPressed")
    }

    
    @IBAction func showButtonPressed(_ sender: UIBarButtonItem) {

        switch listAnswerDisplayState {
        case .show:
            listAnswerDisplayState = .hide
            for item in studyData {
                item.answerDisplayState = .hide
            }
            showButton.title = "Hint"
        case .hint:
            listAnswerDisplayState = .show
            for item in studyData {
                item.answerDisplayState = .show
            }
            showButton.title = "Hide"
        case .hide:
            listAnswerDisplayState = .hint
            for item in studyData {
                item.answerDisplayState = .hint
            }
            showButton.title = "Show"
        }
        
        self.studyTableView.reloadData()
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
        switch studyData[indexPath.row].answerDisplayState {
        case .hide:
            cell.detailTextLabel?.text = ""
        case .hint:
            cell.detailTextLabel?.text = String(detailText[detailText.startIndex]) + "..."
        case .show:
            cell.detailTextLabel?.text = detailText
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = studyData[indexPath.row]
        let currentState = item.answerDisplayState
        
        switch currentState {
        case .hide:
            item.answerDisplayState = .hint
        case .hint:
            item.answerDisplayState = .show
        case .show:
            item.answerDisplayState = .hide
        }
        
        self.studyTableView.reloadData()
    }
        
}
