//
//  Expense.swift
//  PersistenciaDados
//
//  Created by Santos, Adriano da Silva on 18/05/26.
//

import Foundation
import CoreData

@objc(Expense)
public class Expense: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var id: UUID
    @NSManaged public var category: String
    @NSManaged public var amount: Double
    @NSManaged public var month: Int16
    @NSManaged public var note: String?
    @NSManaged public var date: Date

    static func fetchRequestForMonth(_ month: Int16) -> NSFetchRequest<Expense> {
        let req: NSFetchRequest<Expense> = Expense.fetchRequest()
        req.predicate = NSPredicate(format: "month == %d", month)
        let sort = NSSortDescriptor(key: "date", ascending: true)
        req.sortDescriptors = [sort]
        return req
    }
}
