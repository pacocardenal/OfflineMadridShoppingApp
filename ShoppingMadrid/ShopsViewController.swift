import UIKit
import CoreData
import MapKit

class ShopsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var context: NSManagedObjectContext?
    var _fetchedResultsController: NSFetchedResultsController<Shop>? = nil
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViews()
    }
    
    func initializeViews() {
        let madridLocation = CLLocation(latitude: 40.416775, longitude: -3.703790)
        let region = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpanMake(0.2, 0.2))
        //mapView.setCenter(madridLocation.coordinate, animated: true)
        mapView.setRegion(region, animated: true)
    }

}
