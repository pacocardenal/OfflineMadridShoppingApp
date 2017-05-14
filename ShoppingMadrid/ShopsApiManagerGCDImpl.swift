import CoreData
import UIKit

public class ShopsApiManagerGCDImpl {
    
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
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let shopsJson = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
                let shops = shopsJson["result"] as! [Dictionary<String, Any>]
                var shop: Shop?
                var allShops: [Shop] = []
                //var logo: String?
                for aShop in shops {
                    //logo = self.getFilenameFromUrl(url: aShop["logo_img"] as! String)
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
                    shop = Shop(context: context, name: aShop["name"] as! String, logoUrl: aShop["logo_img"] as! String, logoName: self.getFilenameFromUrl(aShop["logo_img"] as! String), latitude: latitude, longitude: longitude, descriptionSpa: aShop["description_es"] as! String, descriptionEng: aShop["description_en"] as! String, backgroundUrl: aShop["img"] as! String, backgroundName: self.getFilenameFromUrl(aShop["img"] as! String))
                    self.downloadShopImage(urlString: (shop?.logoUrl)!, shop: shop!, completion: { (image, theShop) in
                        guard let logoName = theShop.logoName else { return }
                        self.saveInDocumentsDirectoryWithImage(image, name: logoName)
                    })
                    self.downloadShopImage(urlString: (shop?.backgroundUrl)!, shop: shop!, completion: { (image, theShop) in
                        guard let backgroundName = theShop.backgroundName else { return }
                        self.saveInDocumentsDirectoryWithImage(image, name: backgroundName)
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
    }
    
    public func downloadShopImage(urlString: String, shop: Shop, completion: @escaping (UIImage, Shop) -> Void, onError: ErrorClosure? = nil) {
        
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().sync {
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
