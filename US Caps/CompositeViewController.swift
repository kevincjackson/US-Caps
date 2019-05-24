//
//  MainViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/21/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class CompositeViewController: UIViewController {
    
    @IBOutlet var viewA: UIView!
    @IBOutlet var viewB: UIView!
    
    var worldStateController: WorldStateController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewA.isHidden = false
        viewB.isHidden = true
    }
    
    @IBAction func switchViewButtonPressed(_ sender: UIBarButtonItem) {
        viewA.isHidden = !viewA.isHidden
        viewB.isHidden = !viewB.isHidden
    }
}

//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segue.identifier {
//        case "listViewSegue":
//            let listVC = segue.destination as! ListViewController
//            listVC.worldStateController = worldStateController
//        case "itemViewSegue":
//            let itemVC = segue.destination as! ItemViewController
//            itemVC.worldStateController = worldStateController
//        default:
//            preconditionFailure("Unknown segue identifier.")
//        }
//    }
//
//    @IBAction func dataReverseButtonPressed(_ sender: UIBarButtonItem) {
//        studyDataReverse = !studyDataReverse
//        listView.reloadData()
//    }
//
//    @IBAction func displayModeButtonPressed(_ sender: UIBarButtonItem) {
//
//        switch studyDisplayMode {
//        case .show:
//            studyDisplayMode = .hide
//            studyData.forEach { $0.displayState = .hide }
//            displayModeButton.title = "Hint"
//        case .hint:
//            studyDisplayMode = .show
//            studyData.forEach { $0.displayState = .show }
//            displayModeButton.title = "Hide"
//        case .hide:
//            studyDisplayMode = .hint
//            studyData.forEach { $0.displayState = .hint }
//            displayModeButton.title = "Show"
//        }
//
//        updateItemView()
//        listView.reloadData()
//    }
//
//    @IBAction func itemModeButtonPressed(_ sender: UIBarButtonItem) {
//        itemView.isHidden = !itemView.isHidden
//        listView.isHidden = !itemView.isHidden
//        itemModeButton.title = itemView.isHidden ? "Item" : "List"
//
//        // Update views
//        updateItemView()
//        listView.reloadData()
//    }
//
//    // MARK: - Actions
//    @IBAction func dataFilterButtonPressed(_ sender: UIBarButtonItem) {
//
//        // Create alert
//        let alert = UIAlertController(title: "Filter", message: "Choose which states and capitals to show.", preferredStyle: .actionSheet)
//
//        //         Add State Filter actions
//        State.Filter.allCases.forEach { (stateFilter) in
//            alert.addAction(UIAlertAction(
//                title: "\(stateFilter)".capitalized,
//                style: .default,
//                handler: { (action) in
//                    self.studyDataFilter = stateFilter
//                    self.dataFilterButton.title = "\(stateFilter)".capitalized
//                    self.listView.reloadData()
//            }))
//        }
//
//        // Add Cancel
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//
//        // Show it
//        self.present(alert, animated: true)
//    }
//
//}
