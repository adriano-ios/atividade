//
//  PersistenciaController.swift
//  PersistenciaDados
//
//  Created by Santos, Adriano da Silva on 18/05/26.
//
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        // montar modelo programaticamente
        let model = NSManagedObjectModel()
        let entity = NSEntityDescription()
        entity.name = "Expense"
        entity.managedObjectClassName = NSStringFromClass(Expense.self)

        var properties: [NSAttributeDescription] = []

        let id = NSAttributeDescription()
        id.name = "id"; id.attributeType = .UUIDAttributeType; id.isOptional = false
        properties.append(id)

        let category = NSAttributeDescription()
        category.name = "category"; category.attributeType = .stringAttributeType; category.isOptional = false
        properties.append(category)

        let amount = NSAttributeDescription()
        amount.name = "amount"; amount.attributeType = .doubleAttributeType; amount.isOptional = false
        properties.append(amount)

        let month = NSAttributeDescription()
        month.name = "month"; month.attributeType = .integer16AttributeType; month.isOptional = false
        properties.append(month)

        let note = NSAttributeDescription()
        note.name = "note"; note.attributeType = .stringAttributeType; note.isOptional = true
        properties.append(note)

        let date = NSAttributeDescription()
        date.name = "date"; date.attributeType = .dateAttributeType; date.isOptional = false
        properties.append(date)

        entity.properties = properties
        model.entities = [entity]

        container = NSPersistentContainer(name: "ExpensesModel", managedObjectModel: model)

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { desc, error in
            if let e = error as NSError? { fatalError("Core Data load error: \(e)") }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
