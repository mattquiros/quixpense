//
//  BaseFormVC.swift
//  Spare
//
//  Created by Matt Quiros on 09/05/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit
import Mold

class BaseFormVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        glb_applyGlobalVCSettings(self)
        
        self.addCancelAndDoneBarButtonItems("Cancel", doneButtonTitle: "Save")
        
        let barButtonAttributes = [
            NSFontAttributeName: Font.ModalBarButtonText,
            NSForegroundColorAttributeName: Color.UniversalTextColor
        ]
        if let leftBarButtonItem = self.navigationItem.leftBarButtonItem {
            leftBarButtonItem.setTitleTextAttributes(barButtonAttributes, for: UIControlState())
        }
        if let rightBarButtonItem = self.navigationItem.rightBarButtonItem {
            rightBarButtonItem.setTitleTextAttributes(barButtonAttributes, for: UIControlState())
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
