//
//  PageViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/25/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    enum direction {
        case before
        case after
    }
    
    var worldStateController: WorldStateController!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Page View
        dataSource = self
        delegate = self
    }
    
    func update() {
        
        // Setup Initial View For PageViewController
        let index = worldStateController.worldState.index
        let initialVC = instantiatePairViewController(index: index)
        
        setViewControllers(
            [initialVC],
            direction: .forward,
            animated: true,
            completion: nil
        )
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("PageView: VIEW DID DISAPPEAR()")
    }


    private func instantiatePairViewController(index: Int) -> PairViewController {
        
        return PairViewController.instantiateFromStoryBoard(
            worldStateController: worldStateController,
            index: index
        )
    }
}

// MARK: - Page View Controller Datasource
extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let previousIndex = worldStateController.worldState.previousIndex
        let pairVC = instantiatePairViewController(index: previousIndex)
        pairVC.pageViewDirection = .before
        return pairVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let nextIndex = worldStateController.worldState.nextIndex
        let pairVC = instantiatePairViewController(index: nextIndex)
        pairVC.pageViewDirection = .after
        return pairVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            if let pairVC = previousViewControllers.first as? PairViewController {
                if let direction = pairVC.pageViewDirection {
                    switch direction {
                    case .before:
                        let previousIndex = worldStateController.worldState.previousIndex
                        worldStateController.update(index: previousIndex )
                    case .after:
                        let nextIndex = worldStateController.worldState.nextIndex
                        worldStateController.update(index: nextIndex )
                    }
                }
            }
        }
    }
}
