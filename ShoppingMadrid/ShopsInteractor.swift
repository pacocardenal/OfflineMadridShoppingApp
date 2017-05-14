import Foundation
import CoreData

public class ShopsInteractor {
    let manager: ShopsApiManagerGCDImpl
    var context: NSManagedObjectContext?
    
    public init(manager: ShopsApiManagerGCDImpl, context: NSManagedObjectContext) {
        self.manager = manager
        self.context = context
    }
    
    public func execute(completion: @escaping ([Shop]) -> Void) {
        guard let context = context else { return }
        
        ShopsApiManagerGCDImpl(context: context).downloadShops { (shops) in
            assert(Thread.current == Thread.main)
            
            completion(shops)
        }
    }
    
}
