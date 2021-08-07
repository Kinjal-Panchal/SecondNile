//
//  MapViewVC.swift
//  SecondNile
//
//  Created by panchal kinjal on 23/07/21.
//

import UIKit
import MapKit
import CoreLocation

struct Stadium {
  var name: String
  var lattitude: CLLocationDegrees
  var longtitude: CLLocationDegrees
}

class MapViewVC: UIViewController,CLLocationManagerDelegate {

   //MARK: - ====Outlets ======
    @IBOutlet weak var mapview: MKMapView!


   //MARK:- ===== Variables ======
    let locationManager = CLLocationManager()
    let stadiums = [Stadium(name: "Emirates Stadium", lattitude: 51.5549, longtitude: -0.108436),
    Stadium(name: "Stamford Bridge", lattitude: 51.4816, longtitude: -0.191034),
    Stadium(name: "White Hart Lane", lattitude: 51.6033, longtitude: -0.065684),
    Stadium(name: "Olympic Stadium", lattitude: 51.5383, longtitude: -0.016587),
    Stadium(name: "Anfield", lattitude: 53.4308, longtitude: -2.96096)]



    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarWithMenuORBack(Title: "Locations", LetfBtn: "", IsNeedRightButton: false, RightButton: "", isTranslucent: false)
        checkLocationServices()
        mapview.delegate = self
        fetchStadiumsOnMap(stadiums)
        self.locationManager.delegate = self
               self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
               self.locationManager.requestWhenInUseAuthorization()
               self.locationManager.startUpdatingLocation()
               self.mapview.showsUserLocation = true

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           let location = locations.last
           let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
           let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))

           self.mapview.setRegion(region, animated: true)
           self.locationManager.stopUpdatingLocation()

       }

        // Get user's Current Location and Drop a pin



       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("Errors " + error.localizedDescription)
       }


    func zoomToFitMapAnnotations(map:MKMapView)
    {
        if(map.annotations.count == 0)
        {
              return
        }

        var topLeftCoord = CLLocationCoordinate2D(latitude: -90, longitude: 180)

        var bottomRightCoord = CLLocationCoordinate2D(latitude: 90, longitude: -180)


        map.annotations.forEach {

            topLeftCoord.longitude = fmin(topLeftCoord.longitude, $0.coordinate.longitude);
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, $0.coordinate.latitude);

            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, $0.coordinate.longitude);
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, $0.coordinate.latitude);
        }

        let resd = CLLocationCoordinate2D(latitude: topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5, longitude: topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5)

        let span = MKCoordinateSpan(latitudeDelta: fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.3, longitudeDelta: fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.3)

        var region = MKCoordinateRegion(center: resd, span: span);

        region = map.regionThatFits(region)

        map.setRegion(region, animated: true)


    }

    func checkLocationServices() {
      if CLLocationManager.locationServicesEnabled() {
        checkLocationAuthorization()
      } else {
        // Show alert letting the user know they have to turn this on.
      }
    }
    func checkLocationAuthorization() {
      switch CLLocationManager.authorizationStatus() {
      case .authorizedWhenInUse: break
        //mapView.sh = true
       case .denied: // Show alert telling users how to turn on permissions
       break
      case .notDetermined:
        locationManager.requestWhenInUseAuthorization()
        //mapView.showsUserLocation = true
      case .restricted: // Show an alert letting them know what’s up
       break
      case .authorizedAlways:
       break
      }
    }


    func fetchStadiumsOnMap(_ stadiums: [Stadium]) {
      for stadium in stadiums {
        let annotations:MKPointAnnotation = MKPointAnnotation()
        annotations.title = stadium.name
        annotations.coordinate = CLLocationCoordinate2D(latitude:
          stadium.lattitude, longitude: stadium.longtitude)
        mapview.addAnnotation(annotations)
        zoomToFitMapAnnotations(map: mapview)
      }
    }


}

extension MapViewVC: MKMapViewDelegate{

    
    func mapView(_ mapView: MKMapView,
                   viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        // Leave default annotation for user location
        if annotation is MKUserLocation {
          return nil
        }

        let reuseID = "Location"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        if annotationView == nil {
          let pin = MKAnnotationView(annotation: annotation,
                                     reuseIdentifier: reuseID)
              pin.image = UIImage(named: "ic_Marker")
              pin.isEnabled = true
              pin.canShowCallout = true

          let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
              label.textColor = .white
              //label.text = annotation.id // set text here
              pin.addSubview(label)

          annotationView = pin
        } else {
          annotationView?.annotation = annotation
        }

        return annotationView
      }

func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    print("tapped on pin ")

    let detail : CampaginDetailVC = CampaginDetailVC.instantiate(appStoryboard: .main)
    detail.isFromLocation = true
    self.navigationController?.pushViewController(detail, animated: true)
}

func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    if control == view.rightCalloutAccessoryView {
        if (view.annotation?.title!) != nil {
           print("do something")
        }
    }
  }
}

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: UIImage!
}
