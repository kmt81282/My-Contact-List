//
//  MapViewController.swift
//  My Contact List
//
//  Created by Marc Turner on 3/25/23.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapPoint: NSObject, MKAnnotation{
    var title: String?
    var subtitle: String?
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() //ask for permission
        
        // Do any additional setup after loading the view.
    }
    //Called when the location permission status changes
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            print("Permission granted")
        }
        else {
            print("Permission NOT granted")
        }
    }
    /*
    override func viewWillAppear(_ animated: Bool) {
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    */
     
    @IBAction func findUser(_ sender: Any) {
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let errorType = error._code == CLError.denied.rawValue ? "Location Permission Denied" :
        "Unknown Error"
        let alertController = UIAlertController(title: "Error Getting Location: \(errorType)",
                                                message: "Error Message: \(error.localizedDescription))",
                                                preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertController.addAction(actionOK)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    /*
    private func processAddressResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if let error = error {
            print("Geocode Error: \(error)")
        }
        else {
            var bestMatch: CLLocation?
            if let placemarks = placemarks, placemarks.count > 0 {
                bestMatch = (placemarks.first?.location)!
            }
            if let coordinate = bestMatch?.coordinate {
                lblLatitude.text = String(format: "%g\u{00B0}", coordinate.latitude)
                lblLongitude.text = String(format: "%g\u{00B0}", coordinate.longitude)
            }
            /*
             We use optional binding to get the coordinate portion of the bestMatch location. The CLPlacemark object contains a large amount of information (such as state, city, points of interest) for the location, but the actual coordinates are also stored in there. The code \u00B0 is the Unicode for a degree symbol that is added to the end of the numerical value. The placeholder %g is used to format a decimal number with six significant digits.
             */
            else {
                print("Didn't find any matching location")
            }
        }
    }
    
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let eventDate = location.timestamp
            let howRecent = eventDate.timeIntervalSinceNow
            if Double(howRecent) < 15.0 {
                let coordinate = location.coordinate
                lblLongitude.text = String(format: "%g\u{00B0}", coordinate.longitude)
                lblLatitude.text = String(format: "%g\u{00B0}", coordinate.latitude)
                lblLocationAccuracy.text = String(format: "%gm", location.horizontalAccuracy)
                lblAltitude.text = String(format: "%gm", location.altitude)
                lblAltitudeAccuracy.text = String(format: "%gm", location.verticalAccuracy)
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if newHeading.headingAccuracy > 0 {
            let theHeading = newHeading.trueHeading
            var direction: String
            switch theHeading {
            case 225..<315:
                direction = "W"
            case 135..<225:
                direction = "S"
            case 45..<135:
                direction = "E"
            default:
                direction = "N"
            }
            lblHeading.text = String(format: "%g\u{00B0} (%@)", theHeading, direction)
            lblHeadingAccuracy.text = String(format: "%g\u{00B0} (%@)", newHeading.headingAccuracy)
            
        }
    }
    */
    

    
    /*
     
     
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "Contact")
        var fetchedObject: [NSManagedObject] = []
        do {
            fetchedObject = try context.fetch(request)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        contacts = fetchedObjects as! [Contact]
        
        self.mapView.removeAnnotation(self.mapView.annotations)
    }
    
    
    
    
    
    
    @IBAction func findUser(_ sender: Any) {
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        var span = MKCoordinateSpan()
        span.latitudeDelta = 0.2
        span.longitudeDelta = 0.2
        let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        //let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        mapView.setRegion(viewRegion, animated: true)
        let mp = MapPoint(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        mp.title = "You"
        mp.subtitle = "Are Here"
        mapView.addAnnotation(mp)
        
    }
     */


}
