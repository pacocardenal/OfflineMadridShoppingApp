import CoreData
import UIKit

extension Shop {
    
    public convenience init(context: NSManagedObjectContext, name: String, logoUrl: String, logoName: String, latitude: Double, longitude: Double) {
        self.init(context: context)
        
        self.name = name
        self.logoUrl = logoUrl
        self.logoName = logoName
        self.latitude = latitude
        self.longitude = longitude
    }

}
