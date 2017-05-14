import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var context: NSManagedObjectContext?
    var shop: Shop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        syncViewWithModel()
    }
    
    func syncViewWithModel() {
        nameLabel.text = shop?.name
        descriptionLabel.text = shop?.descriptionSpa
        addressLabel.text = shop?.address
    }

}
