import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!

    var context: NSManagedObjectContext?
    var shop: Shop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        syncViewWithModel()
    }
    
    func syncViewWithModel() {
        nameLabel.text = shop?.name
    }

}
