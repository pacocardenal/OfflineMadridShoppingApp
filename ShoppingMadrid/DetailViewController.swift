import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapImageView: UIImageView!
    
    var context: NSManagedObjectContext?
    var shop: Shop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = shop?.name
        
        syncViewWithModel()
    }
    
    func syncViewWithModel() {
        nameLabel.text = shop?.name
        descriptionLabel.text = shop?.descriptionEng
        if let preferredLanguage = NSLocale.preferredLanguages[0] as String? {
            if preferredLanguage == "es-ES" {
                descriptionLabel.text = shop?.descriptionSpa
            }
        }
        
        addressLabel.text = shop?.address
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        
        if let _ = shop?.mapName {
            
            if let dirPath          = paths.first
            {
                let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent((shop?.mapName)!)
                let image    = UIImage(contentsOfFile: imageURL.path)
                mapImageView.image = image
            }
        }
        
        
    }
    
}
