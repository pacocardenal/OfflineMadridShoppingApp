import CoreData

extension Shop {
    public convenience init(context: NSManagedObjectContext, name: String, logo: String) {
        self.init(context: context)
        
        self.name = name
        self.logo = logo
    }
}
