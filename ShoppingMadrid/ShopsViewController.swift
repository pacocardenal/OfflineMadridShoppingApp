import UIKit
import CoreData
import MapKit

class ShopsViewController: UIViewController, MKMapViewDelegate {

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
        self.mapView.delegate = self
    }
    
    func addPinsToMap() {
        //addPinToMapWithCoordinate(CLLocationCoordinate2D(latitude: 40.416775, longitude: -3.703790))
        
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
                    addPinToMapWithShop(shop)
                }
            }
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func addPinToMapWithShop(_ shop: Shop) {
        
        let latitude = shop.latitude
        let longitude = shop .longitude
        if (latitude != 0) && (longitude != 0) {
            let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            let annotation = MapPin(coordinate: coordinate)
            annotation.title = shop.name
            //annotation.subtitle = "Subtitle 1"
            
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "mapPin")
        }
        
        return annotationView
    }

}

func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    guard !(view.annotation is MKUserLocation) else { return }
    
    mapView.setCenter((view.annotation?.coordinate)!, animated: true)
}

func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    print("tapped annotation " + ((view.annotation?.title)!)!)
}


class MapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
