import Foundation
import CoreData

public class ShopsInteractor {
    let manager: ShopsApiManagerNSUrlSessionImpl
    var context: NSManagedObjectContext?
    
    public init(manager: ShopsApiManagerNSUrlSessionImpl, context: NSManagedObjectContext) {
        self.manager = manager
        self.context = context
    }
    
    public func execute(completion: @escaping ([Shop]) -> Void) {
        guard let context = context else { return }
        
        ShopsApiManagerNSUrlSessionImpl(context: context).downloadShops { (shops) in
            assert(Thread.current == Thread.main)
            
            completion(shops)
        }
    }
    
}
