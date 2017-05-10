import Foundation
import CoreData

public typealias ErrorClosure = (Error) -> Void

public class ShopsApiManagerFakeImpl {
    
    var context: NSManagedObjectContext?
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    public func downloadShops(completion: @escaping ([Shop]) -> Void) {
        self.downloadShops(completion: completion, onError: nil)
    }
    
    public func downloadShops(completion: @escaping ([Shop]) -> Void, onError: ErrorClosure? = nil) {
        guard let context = context else { return }
        //let shopOne = Shops(name: "Cortefiel - Preciados", logo: "http:\\/\\/madrid-shops.com\\/media\\/shops\\/logo-cortefiel-200.jpg")
        //let shopTwo = Shops(name: "Hoss intropia", logo: "https://madrid-shops.com/media/shops/logo-hossintropia-200.jpg")
        let shopOne = Shop(context: context)
        let shopTwo = Shop(context: context)
        shopOne.name = "Cortefiel - Preciados"
        shopTwo.name = "Hoss Intropia"
        do {
            try context.save()
        } catch {
            
        }
        completion([shopOne, shopTwo])
    }
    
}
