import UIKit
import CoreData

class ViewController: UIViewController {

    var shops: [Shop]!
    var context: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getShops()
    }
    
    func getShops() {
        assert(Thread.current == Thread.main)
        guard let context = context else { return }
        
        ShopsInteractor(manager: ShopsApiManagerNSUrlSessionImpl(context: context), context: context).execute { (shops) in
            self.shops = shops
            
            guard self.shops.count > 0 else { return }
            for shop in shops {
                print(shop.name!)
            }
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

