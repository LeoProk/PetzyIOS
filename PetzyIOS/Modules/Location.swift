//
//model for location used for park's location
//lat latitude of the park
//lng longitude of the park
//

import Foundation

class Location {
    
    //latitude of the park
    let lat : String
    
    //longitude of the park
    let lng : String
    
    //class init for new location
    init(lat:String,lng:String) {
        self.lat = lat
        self.lng = lng
    }
}
