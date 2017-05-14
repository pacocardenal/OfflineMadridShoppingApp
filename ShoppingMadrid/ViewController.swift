import UIKit
import CoreData
import SystemConfiguration

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var goShoppingButton: UIButton!
    
    var shops: [Shop]!
    var context: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Go shopping"
    
        if (!isInternetAvailable()) {
            self.goShoppingButton.isHidden = true
            let alert = UIAlertController(title: "Error", message: "No Internet connection available. Relaunch App with Internet connection", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let isDownloaded = UserDefaults.standard.bool(forKey: "downloaded")
        
        if (!isDownloaded) {
            getShops()
        }
        
    }
    
    func getShops() {
        assert(Thread.current == Thread.main)
        guard let context = context else { return }
        
        self.goShoppingButton.isHidden = true
        activityIndicator.startAnimating()
        ShopsInteractor(manager: ShopsApiManagerGCDImpl(context: context), context: context).execute { (shops) in
            self.shops = shops
            
            guard self.shops.count > 0 else { return }
            for shop in shops {
                print(shop.name!)
            }
            self.activityIndicator.stopAnimating()
            self.goShoppingButton.isHidden = false
            UserDefaults.standard.set(true, forKey: "downloaded")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "goShoppingSegue" {
                let vc = segue.destination as! ShopsViewController
                vc.context = self.context
            }
        }
    }
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }

}

