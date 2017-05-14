import UIKit
import CoreData

class ViewController: UIViewController {

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var shops: [Shop]!
    var context: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let isDownloaded = UserDefaults.standard.bool(forKey: "downloaded")
        
        if (!isDownloaded) {
            getShops()
        }
        
    }
    
    func getShops() {
        assert(Thread.current == Thread.main)
        guard let context = context else { return }
        
        activityIndicator.startAnimating()
        ShopsInteractor(manager: ShopsApiManagerGCDImpl(context: context), context: context).execute { (shops) in
            self.shops = shops
            
            guard self.shops.count > 0 else { return }
            for shop in shops {
                print(shop.name!)
            }
            self.activityIndicator.stopAnimating()
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

}

