import CoreData
import UIKit

public class ShopsApiManagerNSUrlSessionImpl {
    
    var context: NSManagedObjectContext?
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    public func downloadShops(completion: @escaping ([Shop]) -> Void) {
        self.downloadShops(completion: completion, onError: nil)
    }
    
    public func downloadShops(completion: @escaping ([Shop]) -> Void, onError: ErrorClosure? = nil) {
        guard let context = context else { return }
        
        let urlString = "http://madrid-shops.com/json_new/getShops.php"
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error, let onError = onError {
                onError(error)
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let shopsJson = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
                let shops = shopsJson["result"] as! [Dictionary<String, Any>]
                var shop: Shop?
                var allShops: [Shop] = []
                for aShop in shops {
                    shop = Shop(context: context, name: aShop["name"] as! String)
                    allShops.append(shop!)
                }
                //let firstShop = shops[0]
//                let shop = Shop(context: context, name: firstShop["name"] as! String)
                DispatchQueue.main.async {
                    self.saveInContext()
                    completion(allShops)
                }
            } catch {
                print("Error in downloadCard: " + error.localizedDescription)
                if let errorClosure = onError {
                    errorClosure(error)
                }
            }
            
        }
        task.resume()
        
    }
    
    public func saveInContext() {
        do {
            try self.context?.save()
        } catch {
            
        }
    }
    
}
