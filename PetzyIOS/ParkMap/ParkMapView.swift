//
//this class uses the parks array we get from firebase and creates
//map markers over goolgle map also shows user current location
//

import UIKit
import GoogleMaps

class ParkMapView: UIViewController {
    
    override func loadView() {
        //sets the camera to current location
        let camera = GMSCameraPosition.camera(withLatitude: 41.887,
                                              longitude:-87.622,
                                              zoom:15)
        let mapView = GMSMapView.map(withFrame: .zero, camera:camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 41.887, longitude: -87.622)
        //marker.appearAnimation = GMSMarkerAnimation
        marker.icon = UIImage(named: "flag_icon")
        marker.map = mapView
        
        view = mapView
    }
}
