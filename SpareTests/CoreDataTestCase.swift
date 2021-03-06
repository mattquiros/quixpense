//
//  CoreDataTestCase.swift
//  SpareTests
//
//  Created by Matt Quiros on 02/08/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import XCTest
import CoreData
import Bedrock
@testable import Spare

class CoreDataTestCase: XCTestCase {
    
    var coreDataStack: NSPersistentContainer!
    var operationQueue = OperationQueue()
    
    var setupTimeout = TimeInterval(60)
    
    override func setUp() {
        super.setUp()
        
        operationQueue = OperationQueue()
        
        let xp = expectation(description: "\(#function)\(#line)")
        loadCoreDataStack {
            xp.fulfill()
        }
        wait(for: [xp], timeout: setupTimeout)
    }
    
    func loadCoreDataStack(completion: (() -> Void)?) {
        let xp = expectation(description: #function)
        let loadOp = LoadCoreDataStackOperation(inMemory: true) { _ in
            xp.fulfill()
        }
        operationQueue.addOperation(loadOp)
        wait(for: [xp], timeout: setupTimeout)
        
        guard let result = loadOp.result
            else {
                fatalError("No result")
        }
        
        switch result {
        case .success(let container):
            container.viewContext.automaticallyMergesChangesFromParent = true
            coreDataStack = container
            completion?()
        case .error(let error):
            XCTFail(error.localizedDescription)
        }
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
    }
    
    func makeFetchControllerForAllExpenses() -> NSFetchedResultsController<Expense> {
            let request: NSFetchRequest<Expense> = Expense.fetchRequest()
            request.sortDescriptors = [
                NSSortDescriptor(key: #keyPath(Expense.dateSpent), ascending: true)
            ]
            let frc = NSFetchedResultsController<Expense>(fetchRequest: request,
                                                          managedObjectContext: coreDataStack.viewContext,
                                                          sectionNameKeyPath: nil,
                                                          cacheName: nil)
            return frc
    }
    
    func makeValidExpense(from rawExpense: RawExpense) -> ValidExpense {
        let validateOp = ValidateExpenseOperation(rawExpense: rawExpense, context: coreDataStack.viewContext, completionBlock: nil)
        validateOp.start()
        
        guard let result = validateOp.result
            else {
                fatalError("No result")
        }
        
        switch result {
        case .success(let validExpense):
            return validExpense
        case .error(let error):
            fatalError("Error: \(error)")
        }
    }
    
    func makeDate(day: Int = 1, month: Int = 1, year: Int = 2017, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        components.hour = hour
        components.minute = minute
        components.second = second
        return Calendar.current.date(from: components)!
    }
    
}
