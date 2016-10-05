//
//  GetExpensesOperation.swift
//  Spare
//
//  Created by Matt Quiros on 19/09/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation
import Mold
import BNRCoreDataStack

class GetExpensesOperation: MDOperation {
    
    var category: Category
    var startDate: Date
    var endDate: Date
    
    init(category: Category, startDate: Date, endDate: Date) {
        self.category = category
        self.startDate = startDate
        self.endDate = endDate
    }
    
    override func makeResult(fromSource source: Any?) throws -> Any? {
        // Experimenting here. Notice how I use the main queue context for fetching the expenses.
        // I'm assuming that if you're just reading data and you're sure you won't have simultaneous operations writing to the store,
        // using the main context is OK; that a private queue is only necessary if writing changes at all.
        
        let request1 = NSFetchRequest<NSFetchRequestResult>(entityName: Expense.entityName)
        request1.predicate = NSPredicate(format: "category == %@ AND dateSpent >= %@ AND dateSpent <= %@", [self.category, self.startDate, self.endDate])
        
        let request2 = NSFetchRequest<NSFetchRequestResult>(entityName: Expense.entityName)
        request2.predicate = NSPredicate(format: "dateSpent >= %@ AND dateSpent <= %@", [self.startDate, self.endDate])
        
        guard let allExpensesInCategory = (try? App.mainQueueContext.fetch(request1)) as? [Expense],
            let allExpensesInDateRange = (try? App.mainQueueContext.fetch(request2)) as? [Expense]
            else {
                return nil
        }
        
        let totalForCategory = allExpensesInCategory.total()
        let totalForDateRange = allExpensesInDateRange.total()
        let percent = (totalForCategory / totalForDateRange).doubleValue
        return (allExpensesInCategory, totalForCategory, percent)
    }
    
}
