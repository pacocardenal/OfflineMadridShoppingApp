import CoreData

public func persistentContainer(dbName: String, onError: ((NSError) -> Void)? = nil) -> NSPersistentContainer {
    let container = NSPersistentContainer(name: dbName)
    
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError?,
            let onError = onError {
            onError(error)
        }
    })
    return container
}

// TODO: add onError
public func saveContext(context: NSManagedObjectContext) {
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
