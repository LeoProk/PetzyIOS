//
//model class for to retrive data from firebase with following verables
//title of the park
//address of the park
//user to idenify if park for sumbited or premade
//image of the park from google maps
//camera with the x and y axis
//location of the current park with lat and lang
//

import Foundation
import Firebase

class Park{
    
    //title of the park
    var title : String
    
    //address of the park
    var address : String
    
    //used to identify if park was sumbited by user
    var user : String
    
    //image of the park from google maps
    //var image : String
    
    //camera x and y
    var camera : String
    
    //lat lang location
    var location : Location
    
    
    //init for new park
    init(dataSnap : DataSnapshot) {
        let userDict = dataSnap.value as! [String:Any]
        self.title = userDict["title"] as! String
        self.address = userDict["address"] as! String
        self.user = userDict["user"] as! String
        self.camera = userDict["camera"] as! String
        location = Location()
        let locationDict = userDict["location"] as! [String: Any]
        self.location.lat = locationDict["lat"] as? String
        self.location.lng = locationDict["lng"] as? String
    }
    //return image url of the park using google street view with lat and lng parmas
    // and camera for camera angle
    func getImage() -> String {
       let imgUrl: String = "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=\(location.lat ?? ""),\(location.lng ?? "")\(camera)&key=AIzaSyDGTKCSCY_lpKtVrA1bJYctJdrJhjzGMlE";
       return imgUrl
    }
}

