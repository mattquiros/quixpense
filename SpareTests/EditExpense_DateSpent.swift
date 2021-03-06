//
//  EditExpense_DateSpent.swift
//  SpareTests
//
//  Created by Matt Quiros on 18/09/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import XCTest
import CoreData
@testable import Spare

class EditExpense_DateSpent: CoreDataTestCase {
    
    override func setUp() {
        super.setUp()
        makeExpenses(from: [
            RawExpense(amount: "250.00", dateSpent: Date(), categorySelection: .name("Food"), tagSelection: .none),
            RawExpense(amount: "164.11", dateSpent: Date(), categorySelection: .name("Transportation"), tagSelection: .none),
            RawExpense(amount: "7.00", dateSpent: Date(), categorySelection: .name("Transportation"), tagSelection: .none),
            RawExpense(amount: "149.00", dateSpent: Date(), categorySelection: .name("Food"), tagSelection: .none),
            RawExpense(amount: "16", dateSpent: Date(), categorySelection: .name("Transportation"), tagSelection: .none)
            ])
    }
    
}

extension EditExpense_DateSpent {
    
    func testDateSpent_newDate_shouldChangeClassifierGroups() {
        let frc = makeFetchControllerForAllExpenses()
        try! frc.performFetch()
        let firstExpense = frc.fetchedObjects!.first!
        let newDate = Date(timeIntervalSince1970: 1459468800)
        let validExpense = makeValidEnteredExpense(from: RawExpense(amount: "333.45",
                                                                               dateSpent: newDate,
                                                                               categorySelection: .none,
                                                                               tagSelection: .none))
        let editOp = EditExpenseOperation(context: coreDataStack.viewContext,
                                          expenseId: firstExpense.objectID,
                                          validExpense: validExpense,
                                          completionBlock: nil)
        let expenseToEdit = editOp.fetchExpense()!
        
        let shouldChangeDate = editOp.shouldChangeDateSpent(expenseToEdit.dateSpent, with: newDate)
        XCTAssertTrue(shouldChangeDate)
    }
    
}
