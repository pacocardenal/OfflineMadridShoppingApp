import CoreData
import UIKit

extension Shop {
    
    public convenience init(context: NSManagedObjectContext, name: String, logoUrl: String, logoName: String) {
        self.init(context: context)
        
        self.name = name
        self.logoUrl = logoUrl
        self.logoName = logoName
    }

}
