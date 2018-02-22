//
//this class uses the parks array we get from firebase and creates
//map markers over goolgle map also shows user current location
//

import UIKit
import GoogleMaps

class ParkMapView: UIViewController {
    
    override func loadView() {
        //sets the camera to current location
        let currentLocation = ParkTableViewController.parksLocation.currentLocation?.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: currentLocation?.latitude ?? 0,
                                              longitude:currentLocation?.longitude ?? 0,
                                              zoom:0)
        //frame of the map
        let mapView = GMSMapView.map(withFrame: .zero, camera:camera)
        //gets the current array of firebae parks from ParkTableViewController
        let parksArray = ParkTableViewController.parksLocation.parksArray
        //if the park loction is empty reutn
        for park in parksArray!{
            guard let parkLat = park.location.lat else {return}
            guard let parkLng = park.location.lng else {return}
            //create new marker on the map
            let marker = GMSMarker()
            //sets the location of the marker to the location of park at current
            //array index
            marker.position = CLLocationCoordinate2D(latitude:Double(parkLat)!,
                                                     longitude:  Double(parkLng)!)
            //sets the marker icon
            marker.icon = UIImage(named: "flag_icon")
            //sets the park title as the title of the marker
            marker.title = park.title
            //sets snippet as the adress of the park
            marker.snippet = park.address
            //sets the color of the marker to the same color as menu tab
            marker.icon = GMSMarker.markerImage(with: UIColor(red: 141/255, green: 182/255, blue: 0, alpha:1.0))
            //add the marker to mapview
            marker.map = mapView
        }
        //show the markers we added in the look
        view = mapView
    }
    func setCurrentPos(notfication: NSNotification){
        
    }
}
