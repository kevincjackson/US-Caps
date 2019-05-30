//
//  MainViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/21/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet var filterButton: UIBarButtonItem!
    @IBOutlet var listDisplayModeButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    var worldStateController: WorldStateController!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        update()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "itemViewSegue":
            let navVC = segue.destination as! UINavigationController
            let itemVC = navVC.topViewController as! ItemViewController
            itemVC.worldStateController = worldStateController
        default:
            preconditionFailure("Unknown segue identifier")
        }
    }
    
    // MARK: - Target-Actions
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        showFilterOptions(sender)
    }
    
    @IBAction func reverseButtonPressed(_ sender: UIBarButtonItem) {
        worldStateController.reversePair()
        update()
    }
    
    @IBAction func displayModeButtonPressed(_ sender: UIBarButtonItem) {
        let newMode = worldStateController.nextDisplayModeForList()
        listDisplayModeButton.title = newMode.next.rawValue.capitalized
        update()
    }
    
    @IBAction func unwindToListView(_ unwindSegue: UIStoryboardSegue) {}

    // MARK: - Helpers
    private func showFilterOptions(_ sender: UIBarButtonItem) {
        // Create alert
        let actionSheet = UIAlertController(title: "Study By Region", message: nil, preferredStyle: .actionSheet)
        
        // Add handler for each filter.
        WorldState.Filter.allCases.forEach { stateFilter in
            actionSheet.addAction(UIAlertAction(
                title: "\(stateFilter)".capitalized,
                style: .default,
                handler: { [weak self] _ in
                    self?.worldStateController.update(filter: stateFilter)
                    self?.update()
        }))}
        
        // Add Cancel
        actionSheet.addAction(UIAlertAction(title: "Cancel", style:.cancel))
        
        // Handle popovers
        actionSheet.popoverPresentationController?.barButtonItem = sender

        // Show it
        self.present(actionSheet, animated: true)
    }
    
    func update() {
        filterButton.title = worldStateController.worldState.filter.rawValue.capitalized
        listDisplayModeButton.title = worldStateController.worldState.displayMode.next.rawValue.capitalized
        tableView.reloadData()
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worldStateController.worldState.states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let state = worldStateController.worldState.states[indexPath.row]
        let labelText = worldStateController.worldState.pairReversed ?
            state.capital : state.name
        let detailText = worldStateController.worldState.pairReversed ?
            state.name : state.capital
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        cell.textLabel?.text = labelText
        cell.detailTextLabel?.text = detailText.display(usingMode: state.displayMode)
        
        return cell
    }
    
    // MARK: Implement
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        let state = worldStateController.worldState.states[index]
        
        // Update current index
        worldStateController.update(index: index)
        
        // Change display mode
        worldStateController.nextDisplayModeFor(state: state)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
