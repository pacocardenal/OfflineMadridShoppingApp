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
        addPinsToMap()
    }
    
    func initializeViews() {
        let madridLocation = CLLocation(latitude: 40.416775, longitude: -3.703790)
        let region = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpanMake(0.2, 0.2))
        //mapView.setCenter(madridLocation.coordinate, animated: true)
        mapView.setRegion(region, animated: true)
    }
    
    func addPinsToMap() {
        addPinToMapWithCoordinate(CLLocationCoordinate2D(latitude: 40.416775, longitude: -3.703790))
        
        let fetchRequest = NSFetchRequest<Shop>(entityName: "Shop")
        
        do {
            let results = try context?.fetch(fetchRequest)
            let  shops = results! as [Shop]
            
            for shop in shops {
                print("Pin")
                print(shop.name ?? "No name")
                let latitude = shop.latitude
                let longitude = shop .longitude
                if (latitude != 0) && (longitude != 0) {
                    addPinToMapWithCoordinate(CLLocationCoordinate2DMake(latitude, longitude))
                }
            }
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func addPinToMapWithCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let a1 = MapPin(coordinate: coordinate)
//        a1.title = "Pin 1"
//        a1.subtitle = "Subtitle 1"
        
        self.mapView.addAnnotation(a1)
    }

}

class MapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
