//
//  PairViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/25/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class PairViewController: UIViewController {
    
    @IBOutlet private var questionLabel: UILabel!
    @IBOutlet private var answerLabel: UILabel!
    
    var worldStateController: WorldStateController!
    var index: Int!
    
    private var state: State {
        return worldStateController.worldState.states[index]
    }
    private var questionText: String {
        return worldStateController.worldState.pairReversed ? state.capital : state.name
    }
    private var answerText: String {
        return worldStateController.worldState.pairReversed ?
            state.name : state.capital
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        questionLabel.text = questionText
        answerLabel.text = answerText.display(usingMode: state.displayMode)
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        worldStateController.nextDisplayModeFor(state: state)
        updatePair()
    }
    
    func updatePair() {
        questionLabel.fadeTransition(0.5)
        questionLabel.text = questionText
        answerLabel.fadeTransition(0.5)
        answerLabel.text = answerText.display(usingMode: state.displayMode)
    }
}

// MARK: -
extension PairViewController {
    
    // Convenience function for creating a Pair View
    static func instantiateFromStoryBoard(worldStateController: WorldStateController,
                                          index: Int) -> PairViewController {
        
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "pairViewController")
            as! PairViewController
        
        vc.worldStateController = worldStateController
        vc.index = index
        
        return vc
    }
}
