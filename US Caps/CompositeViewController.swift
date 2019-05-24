//
//  MainViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/21/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class CompositeViewController: UIViewController {
    
    @IBOutlet var listViewContainer: UIView!
    @IBOutlet var itemViewContainer: UIView!
    @IBOutlet var filterButton: UIBarButtonItem!
    @IBOutlet var viewButton: UIBarButtonItem!
    @IBOutlet var displayModeButton: UIBarButtonItem!
    
    var worldStateController: WorldStateController!
    private var listViewController: ListViewController?
    private var itemViewController: ItemViewController?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        listViewContainer.isHidden = false
        itemViewContainer.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "listViewSegue":
            let listVC = segue.destination as! ListViewController
            listVC.worldStateController = worldStateController
            listViewController = listVC
        case "itemViewSegue":
            let itemVC = segue.destination as! ItemViewController
            itemVC.worldStateController = worldStateController
            itemViewController = itemVC
        default:
            preconditionFailure("Unknown segue identifier.")
        }
    }
    
    // MARK: - Target-Actions
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        showFilterOptions(sender)
    }
    
    @IBAction func reverseButtonPressed(_ sender: UIBarButtonItem) {
        worldStateController.reversePair()
        updateViews()
    }
    
    @IBAction func viewButtonPressed(_ sender: UIBarButtonItem) {
        
        // Update button
        viewButton.title = itemViewContainer.isHidden ? "Item" : "List"
        
        // Update Views
        listViewContainer.isHidden = !listViewContainer.isHidden
        itemViewContainer.isHidden = !itemViewContainer.isHidden
        updateViews()
    }
    
    @IBAction func displayModeButtonPressed(_ sender: UIBarButtonItem) {
        
        let newDisplayMode = worldStateController.nextDisplayModeForList()
        displayModeButton.title = newDisplayMode.next.rawValue.capitalized
        updateViews()
    }
    
    
    // MARK: - Helpers
    private func updateViews() {
        listViewController?.update()
        itemViewController?.update()
    }
    
    private func showFilterOptions(_ sender: UIBarButtonItem) {
        // Create alert
        let actionSheet = UIAlertController(title: "Filter By Region", message: nil, preferredStyle: .actionSheet)
        
        // Add handler for each region filter.
        WorldState.Filter.allCases.forEach { stateFilter in
            actionSheet.addAction(UIAlertAction(
                title: "\(stateFilter)".capitalized,
                style: .default,
                handler: { [weak self] _ in
                    self?.worldStateController.update(filter: stateFilter)
                    self?.filterButton.title = "\(stateFilter)".capitalized
                    self?.updateViews()
        }))}
        
        // Add Cancel
        actionSheet.addAction(UIAlertAction(title: "Cancel", style:.cancel))
        
        // Handle popovers
        actionSheet.popoverPresentationController?.barButtonItem = sender

        // Show it
        self.present(actionSheet, animated: true)
    }
}




