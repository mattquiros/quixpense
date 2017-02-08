//
//  TabbedRootViewController.swift
//  Spare
//
//  Created by Matt Quiros on 15/10/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit
import CoreData
import Mold

class TabbedRootViewController: UITabBarController {
    
    var operationQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [
            BaseNavBarVC(rootViewController: HomeVC()),
            DummyAddViewController(),
            BaseNavBarVC(rootViewController: SettingsVC())
        ]
        self.delegate = self
        
        self.tabBar.barTintColor = UIColor(hex: 0x222222)
        self.tabBar.isTranslucent = false
        
        self.operationQueue.addOperation(
            LoadAppOperation().onSuccess {[unowned self] result in
                let persistentContainer = result as! NSPersistentContainer
                App.coreDataStack = CoreDataStack(persistentContainer: persistentContainer)
                
                self.operationQueue.addOperation(MakeDummyDataOperation().onSuccess({ (_) in
                    NotificationCenter.default.post(name: Notifications.CoreDataStackFinishedInitializing, object: nil)
                }))
            }
        )
    }
    
}

extension TabbedRootViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is DummyAddViewController {
            self.present(BaseNavBarVC(rootViewController: AddExpenseVC()), animated: true, completion: nil)
            
            return false
        }
        return true
    }
    
}

fileprivate class DummyAddViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Add"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
