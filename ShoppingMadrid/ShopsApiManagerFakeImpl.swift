import Foundation

public typealias ErrorClosure = (Error) -> Void

public class ShopsApiManagerFakeImpl {
    
    public func downloadShops(completion: @escaping ([Shop]) -> Void) {
        self.downloadShops(completion: completion, onError: nil)
    }
    
    public func downloadShops(completion: @escaping ([Shop]) -> Void, onError: ErrorClosure? = nil) {
        let shopOne = Shop(name: "Cortefiel - Preciados", logo: "http:\\/\\/madrid-shops.com\\/media\\/shops\\/logo-cortefiel-200.jpg")
        let shopTwo = Shop(name: "Hoss intropia", logo: "https://madrid-shops.com/media/shops/logo-hossintropia-200.jpg")
        completion([shopOne, shopTwo])
    }
    
}
