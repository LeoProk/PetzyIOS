//
//this class acsses firebase database from gets snapshop
//create new park object from the snapshop and populate
//the listOfParks array with it
//
//

import Foundation
import Firebase

public class ParkListMaker {
    
    var ref: DatabaseReference!
    
    func getParks(completion: (_ result: Array<Park>) -> Void)  {
        var listOfParks:[Park] = []
        let dispatchGroup = DispatchGroup()
        // create firebase database reffarance from url
        ref = Database.database().reference(fromURL: "https://petzy-1001.firebaseio.com/input")
        //get the date from server in postDict
        dispatchGroup.enter()
        ref.observe(DataEventType.value, with: { (snapshot) in
            _ = snapshot.value as? [String : AnyObject] ?? [:]
            //for loop that interact over snapshot data to poulate new park
            //add the park to parks array
            for fireObj in snapshot.children{
                //create new park from the firebase info
                let parkSnap = Park(dataSnap : fireObj as! DataSnapshot)
                //adds the park to the park list
                if listOfParks.count < snapshot.childrenCount - 1{
                    listOfParks.append(parkSnap)
                    print(snapshot.childrenCount)
                    print(listOfParks.count)
                }else {
                    dispatchGroup.leave()
                }
            }
        })
        // return populated array of parks
        dispatchGroup.notify(queue: DispatchQueue.main, execute: {
            print(listOfParks[5].address)
        })
    }
}
