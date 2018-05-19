//
//this UITableViewController class get the current location
//then gets the park info from firebase and display the info
//in new cells
//show the park image title address and distance from current
//location
//

import UIKit
import SDWebImage
import Firebase
import SwiftLocation
import MapKit
import RxSwift

class ParkTableViewController: UITableViewController {

    //empty array of parks
    var parksArray : Array<Park>!
    var curLoc : CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initalize array
        parksArray = []
        //tries to get current location using swiftlocation
        Locator.currentPosition(
            //acuracy of cuurent location
            accuracy: .house,
            //timeout to look for lcoation
            timeout: Timeout.delayed(60.0),
            //if current location found set curLoc to current location
            onSuccess: { 
                cllocation in self.curLoc = cllocation
        },
            //on fail prin the error
            onFail: { locationError, cllocation in
               print(locationError)
        })
        getPark().subscribe(
            //when done looping over all the park reload the table view on main thread
            onCompleted: {
            parksLocation.currentLocation = self.curLoc
            parksLocation.parksArray = self.parksArray
                self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //uses size of park array
        return parksArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //identifer of the park
        let cellIdentifier = "ParkTableViewCell"
        //create custom cel with in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ParkTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ParkTableViewCell.")
        }
        // get the park by row index
        let park = parksArray[indexPath.row]
        //assign the park image to UIImage of the same category
        cell.parkImage.sd_setImage(with: URL(string: park.getImage()), placeholderImage: UIImage(named: "placeholder.png"))
        //assign the park title to UILabel of the same category
        cell.parkName.text = park.title
        //assign the park address to UILabel of the same category
        cell.parkAddress.text = park.address
        //create new park location with the lat lng location from firebase
        let parkLoc = CLLocation(latitude: Double(park.location.lat ?? "")!, longitude:Double(park.location.lng ?? "")!)
        //assogn the park location to UILabel of the same category
        cell.parkRange.text = distanceKM(distanceMeters: Int(curLoc.distance(from: parkLoc)))
        return cell
    }
    
    //MARK: - tab hieght
    //sets the hieght of the row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 400.0;
    }
    
    //MARK: - firebase park retriver
    //create dispatch group to update the tab view when done fetching all the
    //data from firebase
    func getPark()->Observable<Any>{
    //return observable with polulate the array from firebase
    return Observable.create{
        //populate the array with parks from firebase
        observ in let ref = Database.database().reference(fromURL: "https://petzy-1001.firebaseio.com/input")
        ref.observe(DataEventType.value, with: { (snapshot) in
            _ = snapshot.value as? [String : AnyObject] ?? [:]
            //for loop that loops over snapshot data to poulate new park
            //add the park to parks array
            for fireObj in snapshot.children{
                //create new park from the firebase info
                let parkSnap = Park(dataSnap : fireObj as! DataSnapshot)
                //adds the park to the park list
                //if there still parks left continue to loop otherwise
                //complete the observer
                if self.parksArray.count < snapshot.childrenCount - 1{
                    self.parksArray.append(parkSnap)
                }else {
                    observ.on(.completed)
                }
            }
            })
            return Disposables.create()
        }
    }
    
    //MARK: - metter and km converter
    //take distance in meters and convert it to kelomters
    func distanceKM(distanceMeters:Int) -> String {
        var range : String
        var finalDistance : Int
        //if the distance is less the 1 km show meters
        if distanceMeters < 1000{
            range = "מטרים"
            finalDistance = distanceMeters
        } else {
            //if the distance is bigger the 1 km show kilometers
            range = "קילומטרים"
            finalDistance = distanceMeters / 1000
        }
        //return the distance and approparate range
        return "\(finalDistance) \(range)"
    }
    
    //used to get the current location and parks array in ParkMapView
    struct parksLocation {
        static var currentLocation: CLLocation?
        static var parksArray : Array<Park>?
        
    }
}
