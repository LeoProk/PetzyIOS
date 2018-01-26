//
//this class acsses firebase database from url to get the park information
//
//
//

import Foundation
import Firebase

public class ParkListMaker {
    
    var ref: DatabaseReference!
    
    func getParks() -> Array<Park> {
        let listOfPark = Array<Park>()
        // create firebase database reffarance from url
        ref = Database.database().reference(fromURL: "https://petzy-1001.firebaseio.com/input")
        //get the date from server in postDict
        ref.observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            print(postDict)
        })
        // return array of parks
        return listOfPark
    }
}
