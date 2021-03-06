//
//  AddExpenseViewController.swift
//  Spare
//
//  Created by Matt Quiros on 23/06/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit
import Bedrock

class AddExpenseViewController: ExpenseFormViewController {
    
    let operationQueue = OperationQueue()
    
    override init() {
        super.init()
        self.title = "ADD EXPENSE"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func handleTapOnCancelButton() {
        self.view.endEditing(true)
        
        guard self.hasUnsavedChanges()
            else {
                self.resetFields()
                return
        }
        
        let alertController = UIAlertController(
            title: "Discard changes", message: "Are you sure you want to continue?", preferredStyle: .alert)
        alertController.addCancelAction()
        alertController.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: { (_) in
            self.resetFields()
            alertController.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func handleTapOnDoneButton() {
        validateExpense { [unowned self] (validExpense) in
            let addOp = AddExpenseOperation(context: Global.coreDataStack.newBackgroundContext(),
                                            validExpense: validExpense) {[weak self] result in
                                                guard let weakSelf = self,
                                                    let result = result
                                                    else {
                                                        return
                                                }
                                                switch result {
                                                case .success(_):
                                                    DispatchQueue.main.async {
                                                        BRAlertDialog.showInPresenter(weakSelf, title: "Expense saved.", message: nil, cancelButtonTitle: "Got it!")
                                                        weakSelf.resetFields()
                                                    }
                                                    
                                                case .error(let error):
                                                    BRAlertDialog.showInPresenter(weakSelf, title: error.localizedDescription, message: nil, cancelButtonTitle: "Got it!")
                                                }
            }
            self.operationQueue.addOperation(addOp)
        }
    }
    
}
