//
//  PageViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/25/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

protocol PageViewControllerDelegate: AnyObject {
    
    func indexDidUpdate()
}

class PageViewController: UIPageViewController {
    
    var worldStateController: WorldStateController!
    weak var pageViewControllerDelegate: PageViewControllerDelegate?
    private var pendingIndex = 0
    private var currentPairViewController: PairViewController?
    private var pendingPairViewController: PairViewController?
    
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
        currentPairViewController = initialVC
        
        setViewControllers(
            [initialVC],
            direction: .reverse,
            animated: true,
            completion: nil
        )
    }
    
    func updatePair() {
        currentPairViewController?.updatePair()
    }

    private func instantiatePairViewController(index: Int) -> PairViewController {
        
        let pairVC = PairViewController.instantiateFromStoryBoard(
            worldStateController: worldStateController,
            index: index
        )
        
        return pairVC
    }
}

// MARK: - Page View Controller Datasource
extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let previousIndex = worldStateController.worldState.previousIndex
        let pairVC = instantiatePairViewController(index: previousIndex)

        return pairVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let nextIndex = worldStateController.worldState.nextIndex
        let pairVC = instantiatePairViewController(index: nextIndex)

        return pairVC
    }
}

// MARK: - Page View Controller Delegate
extension PageViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        let pairVC = pendingViewControllers[0] as! PairViewController
        pendingIndex = pairVC.index
        pendingPairViewController = pairVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        worldStateController.update(index: pendingIndex)
        currentPairViewController = pendingPairViewController
        pageViewControllerDelegate?.indexDidUpdate()
    }
}
