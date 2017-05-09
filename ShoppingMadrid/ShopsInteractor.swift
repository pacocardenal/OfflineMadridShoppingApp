import Foundation

public class ShopsInteractor {
    let manager: ShopsApiManagerFakeImpl
    
    public init(manager: ShopsApiManagerFakeImpl) {
        self.manager = manager
    }
    
    public func execute(completion: @escaping ([Shop]) -> Void) {
        manager.downloadShops { (shops) in
            assert(Thread.current == Thread.main)
            
            completion(shops)
        }
    }
    
}
