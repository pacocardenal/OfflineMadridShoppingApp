import CoreData
import UIKit

public class ShopsApiManagerNSUrlSessionImpl {
    
    var context: NSManagedObjectContext?
    
    //MARK: Initialization
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    //MARK: Protocol
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
                //var logo: String?
                for aShop in shops {
                    var latitude: Double
                    var longitude: Double
                    if let lat = Double(aShop["gps_lat"] as! String) {
                        latitude = lat
                    } else {
                        latitude = 0
                    }
                    if let lon = Double(aShop["gps_lon"] as! String) {
                        longitude = lon
                    } else {
                        longitude = 0
                    }
                    //logo = self.getFilenameFromUrl(url: aShop["logo_img"] as! String)
                    shop = Shop(context: context, name: aShop["name"] as! String, logoUrl: aShop["logo_img"] as! String, logoName: self.getFilenameFromUrl(aShop["logo_img"] as! String), latitude: latitude, longitude: longitude, descriptionSpa: aShop["description_es"] as! String, descriptionEng: aShop["description_en"] as! String, backgroundUrl: aShop["img"] as! String, backgroundName: self.getFilenameFromUrl(aShop["img"] as! String), address: aShop["address"] as! String, mapName: "\(aShop["name"] as! String)Map")
                    self.downloadShopImage(shop: shop!, completion: { (image, theShop) in
                        guard let logoName = theShop.logoName else { return }
                        self.saveInDocumentsDirectoryWithImage(image, name: logoName)
                    })
                    allShops.append(shop!)
                    
                }
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
    
    public func downloadShopImage(shop: Shop, completion: @escaping (UIImage, Shop) -> Void, onError: ErrorClosure? = nil) {
        
        guard let urlString = shop.logoUrl, let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error, let onError = onError {
                onError(error)
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    completion(image, shop)
                }
            } catch {
                print("Error in downloadShopImage: " + error.localizedDescription)
            }
            
        }
        task.resume()
        
    }
    
    //MARK: Utils
    public func saveInContext() {
        do {
            try self.context?.save()
        } catch {
            
        }
    }
    
    public func getFilenameFromUrl(_ url: String) -> String {
        let theFileName = (url as NSString).lastPathComponent
        return theFileName
    }
    
    public func saveInDocumentsDirectoryWithImage(_ image: UIImage, name: String) {
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let imageURL = documentsURL?.appendingPathComponent(name)
        
        do {
            //try UIImagePNGRepresentation(image)?.write(to: imageURL!)
            try UIImageJPEGRepresentation(image, 1)?.write(to: imageURL!)
        } catch {
            print("Error in jpeg representation")
        }
        
    }
    
}
