import UIKit

class ViewController: UIViewController {

    var shops: [Shop]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getShops()
    }
    
    func getShops() {
        assert(Thread.current == Thread.main)
        
        ShopsInteractor(manager: ShopsApiManagerFakeImpl()).execute { (shops) in
            self.shops = shops
            
            guard self.shops.count > 0 else { return }
            for shop in shops {
                print(shop.name)
            }
        }
    }

}

