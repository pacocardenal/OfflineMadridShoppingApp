import CoreData
import UIKit

extension Shop {
    
    public convenience init(context: NSManagedObjectContext, name: String, logoUrl: String, logoName: String, latitude: Double, longitude: Double, descriptionSpa: String, descriptionEng: String, backgroundUrl: String, backgroundName: String, address: String) {
        self.init(context: context)
        
        self.name = name
        self.logoUrl = logoUrl
        self.logoName = logoName
        self.latitude = latitude
        self.longitude = longitude
        self.descriptionEng = descriptionEng
        self.descriptionSpa = descriptionSpa
        self.backgroundUrl = backgroundUrl
        self.backgroundName = backgroundName
        self.address = address
    }

}
