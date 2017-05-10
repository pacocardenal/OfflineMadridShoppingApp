import Foundation

public typealias ErrorClosure = (Error) -> Void

public class ShopsApiManagerFakeImpl {
    
    public func downloadShops(completion: @escaping ([Shops]) -> Void) {
        self.downloadShops(completion: completion, onError: nil)
    }
    
    public func downloadShops(completion: @escaping ([Shops]) -> Void, onError: ErrorClosure? = nil) {
        let shopOne = Shops(name: "Cortefiel - Preciados", logo: "http:\\/\\/madrid-shops.com\\/media\\/shops\\/logo-cortefiel-200.jpg")
        let shopTwo = Shops(name: "Hoss intropia", logo: "https://madrid-shops.com/media/shops/logo-hossintropia-200.jpg")
        completion([shopOne, shopTwo])
    }
    
}
