//
//  MainViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/21/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet private var filterButton: UIBarButtonItem!
    @IBOutlet private var listDisplayModeButton: UIBarButtonItem!
    @IBOutlet private var tableView: UITableView!
    
    var worldStateController: WorldStateController!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        update(animated: false)
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
    @IBAction private func filterButtonPressed(_ sender: UIBarButtonItem) {
        showFilterOptions(sender)
    }
    
    @IBAction private func reverseButtonPressed(_ sender: UIBarButtonItem) {
        worldStateController.reversePair()
        reloadRows(withAnimation: .right, usingInterval: 0.04)
    }
    
    @IBAction private func displayModeButtonPressed(_ sender: UIBarButtonItem) {
        let newMode = worldStateController.nextDisplayModeForList()
        listDisplayModeButton.title = newMode.next.rawValue.capitalized
        update(animated: true)
    }
    
    @IBAction func unwindToListView(_ unwindSegue: UIStoryboardSegue) {}

    // MARK: - Helpers
    private func showFilterOptions(_ sender: UIBarButtonItem) {
        // Create alert
        let actionSheet = UIAlertController(title: "Study By Region", message: nil, preferredStyle: .actionSheet)

        // Add handler for each filter.
        actionSheet.addAction(UIAlertAction(title: "All", style: .default) { [unowned self] _ in
            self.updateFilter(from: self.worldStateController.worldState.filter,
                              to: .all)
        })
        
        actionSheet.addAction(UIAlertAction(title: "Midwest", style: .default) { [unowned self] _ in
            self.updateFilter(from: self.worldStateController.worldState.filter,
                              to: .midwest)
        })
        
        actionSheet.addAction(UIAlertAction(title: "Northeast", style: .default) { [unowned self] _ in
            self.updateFilter(from: self.worldStateController.worldState.filter,
                              to: .northeast)
        })
        
        actionSheet.addAction(UIAlertAction(title: "Southeast", style: .default) { [unowned self] _ in
            self.updateFilter(from: self.worldStateController.worldState.filter,
                              to: .southeast)
        })
        
        actionSheet.addAction(UIAlertAction(title: "Southwest", style: .default) { [unowned self] _ in
            self.updateFilter(from: self.worldStateController.worldState.filter,
                              to: .southwest)
        })
        
        actionSheet.addAction(UIAlertAction(title: "West", style: .default) { [unowned self] _ in
            self.updateFilter(from: self.worldStateController.worldState.filter,
                              to: .west)
        })
        
        // Add Cancel
        actionSheet.addAction(UIAlertAction(title: "Cancel", style:.cancel))
        
        // Handle popovers
        actionSheet.popoverPresentationController?.barButtonItem = sender

        // Show it
        self.present(actionSheet, animated: true)
    }
    
    // Incrementally modify states for animation
    private func updateFilter(from: WorldState.Filter, to: WorldState.Filter) {
        
        var index = 0
        var currentStates = worldStateController.worldState.states(by: from)
        let targetStates = worldStateController.worldState.states(by: to)
        
        // Use or add all the target indexes first
        while index < targetStates.count {
            
            // If the state's not there
            if !currentStates.contains(targetStates[index]) {
                
                // Swap with the current if you can
                if index < currentStates.count {
                    currentStates[index] = targetStates[index]
                    worldStateController.update(toCustomFilterWith: currentStates)
                    tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)

                }
                // Or add an index if you need to
                else {
                    currentStates.append(targetStates[index])
                    worldStateController.update(toCustomFilterWith: currentStates)
                    tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                }
            }
            
            // If the state is there, move it to the right spot
            else {
                let matchIndex = currentStates.firstIndex(of: targetStates[index])!
                currentStates.remove(at: matchIndex)
                currentStates.insert(targetStates[index], at: index)
                worldStateController.update(toCustomFilterWith: currentStates)
                tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            }
            
            index += 1
        }
        
        // Delete any extras
        while currentStates.count > targetStates.count {
            currentStates.remove(at: index)
            worldStateController.update(toCustomFilterWith: currentStates)
            tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        }

        tableView.setContentOffset(CGPoint.zero, animated: true)
        worldStateController.update(filter: to)
        filterButton.title = worldStateController.worldState.filter.toString()
    }
    
    private func update(animated: Bool) {
        
        if animated {
            if let indexPaths = tableView.indexPathsForVisibleRows {
                tableView.reloadRows(at: indexPaths, with: .automatic)
            }
        }
        else {
            update()
        }
    }
    
    private func update() {
        tableView.reloadData()
        filterButton.title = worldStateController.worldState.filter.toString()
        listDisplayModeButton.title = worldStateController.worldState.displayMode.next.rawValue.capitalized
    }
}

// MARK: -
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        let state = worldStateController.worldState.states[index]
        
        // Update current index
        worldStateController.update(index: index)
        
        // Change display mode
        worldStateController.nextDisplayModeFor(state: state)
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    private func reloadRows(withAnimation rowAnimation: UITableView.RowAnimation, usingInterval timeInterval: TimeInterval) {
        
        guard let indexPaths = tableView.indexPathsForVisibleRows else {
            tableView.reloadData()
            return
        }
        
        indexPaths.enumerated().forEach { (index, indexPath) in
            Timer.scheduledTimer(withTimeInterval: Double(index) * timeInterval, repeats: false) {_ in
                self.tableView.reloadRows(at: [indexPath], with: rowAnimation)
            }
        }
    }
}
