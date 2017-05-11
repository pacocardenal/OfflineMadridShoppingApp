import CoreData

extension Shop {
    
    class func fetchRequestOrderedByName() -> NSFetchRequest<Shop> {
        let fetchRequest: NSFetchRequest<Shop> = Shop.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
}
