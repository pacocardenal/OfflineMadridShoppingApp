import UIKit
import CoreData

class ShopsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var context: NSManagedObjectContext?
    var _fetchedResultsController: NSFetchedResultsController<Shop>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchedResultsController.delegate = self
        self.tableView.dataSource = self
    }

}
