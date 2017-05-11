import CoreData

extension Shop {
    public convenience init(context: NSManagedObjectContext, name: String) {
        self.init(context: context)
        
        self.name = name
    }
}
